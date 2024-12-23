// #File: lib/features/post/providers/poll_vote_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/providers/auth_provider.dart';

class PollVoteNotifier extends StateNotifier<AsyncValue<void>> {
  final String postId;
  final Ref ref;
  final _db = FirebaseFirestore.instance;

  PollVoteNotifier(this.postId, this.ref) : super(const AsyncValue.data(null));

  Future<void> vote(int optionIndex) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) {
      throw Exception('로그인이 필요해요');
    }

    state = const AsyncValue.loading();

    try {
      await _db.runTransaction((transaction) async {
        final postDoc = await transaction.get(
          _db.collection('posts').doc(postId),
        );

        if (!postDoc.exists) {
          throw Exception('포스트를 찾을 수 없어요');
        }

        final pollData = postDoc.data()?['pollData'] as Map<String, dynamic>?;
        if (pollData == null) {
          throw Exception('투표 데이터를 찾을 수 없어요');
        }

        final endDate = (pollData['endDate'] as Timestamp).toDate();
        if (endDate.isBefore(DateTime.now())) {
          throw Exception('종료된 투표예요');
        }

        final votes = List<int>.from(pollData['votes'] ?? []);
        final voters = Map<String, dynamic>.from(pollData['voters'] ?? {});

        // Remove previous vote if exists
        final previousVote = voters[user.id];
        if (previousVote != null) {
          votes[previousVote as int]--;
        }

        // Add new vote
        votes[optionIndex]++;
        voters[user.id] = optionIndex;

        transaction.update(postDoc.reference, {
          'pollData.votes': votes,
          'pollData.voters': voters,
        });
      });

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      throw error;
    }
  }
}

final pollVoteProvider = StateNotifierProvider.family<PollVoteNotifier, AsyncValue<void>, String>(
  (ref, postId) => PollVoteNotifier(postId, ref),
);