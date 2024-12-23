import 'package:commune/core/models/commore_transaction.dart';
import 'package:commune/core/services/commore_service.dart';
import 'package:commune/features/post/providers/link_preview_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/post.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/post/providers/mu_selector_provider.dart';
import 'package:commune/features/post/providers/media_upload_provider.dart';
import 'package:commune/features/post/providers/poll_provider.dart';

final postTypeProvider = StateProvider<PostType>((ref) => PostType.text);

class PostWriteState {
  final bool isSubmitting;
  final String? error;

  PostWriteState({
    this.isSubmitting = false,
    this.error,
  });

  PostWriteState copyWith({
    bool? isSubmitting,
    String? error,
  }) {
    return PostWriteState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
    );
  }
}

class PostWriteNotifier extends StateNotifier<PostWriteState> {
  final Ref _ref;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  PostWriteNotifier(this._ref) : super(PostWriteState());

  Future<void> submitPost({
    required String title,
    required String content,
    DateTime? scheduledFor,
  }) async {
    final user = _ref.read(authStateProvider).value;
    final selectedMu = _ref.read(selectedMuProvider);
    final type = _ref.read(postTypeProvider);
    
    if (user == null) throw Exception('로그인이 필요해요');
    if (selectedMu == null) throw Exception('뮤를 선택해주세요');

    state = state.copyWith(isSubmitting: true);

    try {
      List<String> mediaUrls = [];
      Map<String, dynamic>? linkMetadata;
      Map<String, dynamic>? pollData;

      switch (type) {
        case PostType.media:
          mediaUrls = _ref.read(mediaUploadProvider).mediaUrls;
          break;
        case PostType.link:
          final linkPreview = await _ref.read(linkPreviewProvider(content).future);
          linkMetadata = linkPreview?.toJson();
          break;
        case PostType.poll:
          pollData = _ref.read(pollOptionsProvider.notifier).getPollData();
          break;
        default:
          break;
      }

      final mentions = _extractMentions(content);
      final hashtags = _extractHashtags(content);

      final post = Post(
        id: '',
        muId: selectedMu.id,
        userId: user.id,
        title: title,
        content: content,
        type: type,
        mediaUrls: mediaUrls,
        linkUrl: type == PostType.link ? content : null,
        linkMetadata: linkMetadata,
        pollData: pollData,
        mentions: mentions,
        hashtags: hashtags,
        scheduledFor: scheduledFor,
        createdAt: DateTime.now(),
      );

      // Save post
      final docRef = await _db.collection('posts').add(post.toJson());
      
      // Update mu post count
      await _db.collection('mus').doc(selectedMu.id).update({
        'postCount': FieldValue.increment(1),
        'lastActivityAt': FieldValue.serverTimestamp(),
      });

      // Award commore points
      await _ref.read(commoreServiceProvider).awardPoints(
        userId: user.id,
        type: CommoreActionType.postCreate,
        amount: 100,
        relatedId: docRef.id,
      );

      // Create notifications for mentioned users
      if (mentions.isNotEmpty) {
        await _createMentionNotifications(mentions, docRef.id);
      }

      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  List<String> _extractMentions(String content) {
    final regex = RegExp(r'@(\w+)');
    return regex.allMatches(content)
        .map((match) => match.group(1)!)
        .toList();
  }

  List<String> _extractHashtags(String content) {
    final regex = RegExp(r'#(\w+)');
    return regex.allMatches(content)
        .map((match) => match.group(1)!)
        .toList();
  }

  Future<void> _createMentionNotifications(
    List<String> mentions,
    String postId,
  ) async {
    final batch = _db.batch();

    for (final username in mentions) {
      final userQuery = await _db
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userId = userQuery.docs.first.id;
        final notificationRef = _db.collection('notifications').doc();
        
        batch.set(notificationRef, {
          'userId': userId,
          'type': 'mention',
          'message': '포스트에서 언급되었어요',
          'relatedId': postId,
          'isRead': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    }

    await batch.commit();
  }
}

final postWriteProvider = StateNotifierProvider<PostWriteNotifier, PostWriteState>(
  (ref) => PostWriteNotifier(ref),
);