// #File: lib/features/post/providers/post_reaction_provider.dart

import 'package:commune/core/models/commore_transaction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/services/commore_service.dart';

class PostReactions {
  final int thumbsUp;
  final int thumbsDown;
  final Set<String> thumbUpUsers;
  final Set<String> thumbDownUsers;

  PostReactions({
    this.thumbsUp = 0,
    this.thumbsDown = 0,
    this.thumbUpUsers = const {},
    this.thumbDownUsers = const {},
  });

  bool hasUserThumbUp(String? userId) =>
      userId != null && thumbUpUsers.contains(userId);

  bool hasUserThumbDown(String? userId) =>
      userId != null && thumbDownUsers.contains(userId);
}

class PostReactionNotifier extends StateNotifier<PostReactions> {
  final String postId;
  final Ref ref;
  final _db = FirebaseFirestore.instance;

  PostReactionNotifier(this.postId, this.ref) : super(PostReactions()) {
    _listenToReactions();
  }

  void _listenToReactions() {
    _db.collection('posts').doc(postId).snapshots().listen((doc) {
      if (!doc.exists) return;

      final data = doc.data();
      if (data == null) return;

      state = PostReactions(
        thumbsUp: data['thumbsUp'] ?? 0,
        thumbsDown: data['thumbsDown'] ?? 0,
        thumbUpUsers: Set<String>.from(data['thumbUpUsers'] ?? []),
        thumbDownUsers: Set<String>.from(data['thumbDownUsers'] ?? []),
      );
    });
  }

  Future<void> toggleThumbUp(String userId) async {
    if (state.hasUserThumbDown(userId)) {
      throw Exception('이미 싫어요를 누르셨어요');
    }

    try {
      final isRemoving = state.hasUserThumbUp(userId);

      await _db.runTransaction((transaction) async {
        final postDoc = await transaction.get(
          _db.collection('posts').doc(postId),
        );

        if (!postDoc.exists) {
          throw Exception('포스트를 찾을 수 없어요');
        }

        final thumbUpUsers = Set<String>.from(
          postDoc.data()?['thumbUpUsers'] ?? [],
        );

        if (isRemoving) {
          thumbUpUsers.remove(userId);
          transaction.update(postDoc.reference, {
            'thumbsUp': FieldValue.increment(-1),
            'thumbUpUsers': thumbUpUsers.toList(),
          });
        } else {
          thumbUpUsers.add(userId);
          transaction.update(postDoc.reference, {
            'thumbsUp': FieldValue.increment(1),
            'thumbUpUsers': thumbUpUsers.toList(),
          });

          // Award commore points
          await ref.read(commoreServiceProvider).awardPoints(
                userId: userId,
                type: CommoreActionType.postReaction,
                amount: 1,
                relatedId: postId,
              );
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleThumbDown(String userId) async {
    if (state.hasUserThumbUp(userId)) {
      throw Exception('이미 좋아요를 누르셨어요');
    }

    try {
      final isRemoving = state.hasUserThumbDown(userId);

      await _db.runTransaction((transaction) async {
        final postDoc = await transaction.get(
          _db.collection('posts').doc(postId),
        );

        if (!postDoc.exists) {
          throw Exception('포스트를 찾을 수 없어요');
        }

        final thumbDownUsers = Set<String>.from(
          postDoc.data()?['thumbDownUsers'] ?? [],
        );

        if (isRemoving) {
          thumbDownUsers.remove(userId);
          transaction.update(postDoc.reference, {
            'thumbsDown': FieldValue.increment(-1),
            'thumbDownUsers': thumbDownUsers.toList(),
          });
        } else {
          thumbDownUsers.add(userId);
          transaction.update(postDoc.reference, {
            'thumbsDown': FieldValue.increment(1),
            'thumbDownUsers': thumbDownUsers.toList(),
          });
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}

final postReactionProvider =
    StateNotifierProvider.family<PostReactionNotifier, PostReactions, String>(
  (ref, postId) => PostReactionNotifier(postId, ref),
);
