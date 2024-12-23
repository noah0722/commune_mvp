// #File: lib/features/post/widgets/post_poll_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/post.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/post/providers/poll_vote_provider.dart';

class PostPollWidget extends ConsumerWidget {
  final Post post;
  final bool showResults;

  const PostPollWidget({
    super.key,
    required this.post,
    this.showResults = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final pollData = post.pollData;

    if (pollData == null) return const SizedBox();

    final options = List<String>.from(pollData['options'] ?? []);
    final votes = List<int>.from(pollData['votes'] ?? []);
    final voters = Map<String, int>.from(pollData['voters'] ?? {});
    final endDate = pollData['endDate']?.toDate() ?? DateTime.now();

    final totalVotes = votes.fold<int>(0, (sum, count) => sum + count);
    final hasVoted = user != null && voters.containsKey(user.id);
    final isEnded = endDate.isBefore(DateTime.now());
    final shouldShowResults = showResults || hasVoted || isEnded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(options.length, (index) {
          final option = options[index];
          final voteCount = votes[index];
          final percentage = totalVotes > 0
              ? (voteCount / totalVotes * 100).toStringAsFixed(1)
              : '0.0';
          final isSelected = user != null && voters[user.id] == index;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: shouldShowResults || user == null
                  ? null
                  : () => _handleVote(context, ref, index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).dividerColor,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      if (shouldShowResults)
                        LinearProgressIndicator(
                          value: totalVotes > 0 ? voteCount / totalVotes : 0,
                          backgroundColor: Colors.transparent,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          minHeight: 48,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            if (!shouldShowResults && user != null)
                              Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            Expanded(
                              child: Text(
                                option,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight:
                                          isSelected ? FontWeight.bold : null,
                                    ),
                              ),
                            ),
                            if (shouldShowResults)
                              Text(
                                '$percentage%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight:
                                          isSelected ? FontWeight.bold : null,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '총 $totalVotes표',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Spacer(),
            if (isEnded)
              Text(
                '투표 종료',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              )
            else
              Text(
                _getRemainingTime(endDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleVote(
      BuildContext context, WidgetRef ref, int optionIndex) async {
    try {
      await ref.read(pollVoteProvider(post.id).notifier).vote(optionIndex);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
          ),
        );
      }
    }
  }

  String _getRemainingTime(DateTime endDate) {
    final remaining = endDate.difference(DateTime.now());

    if (remaining.inDays > 0) {
      return '${remaining.inDays}일 남음';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours}시간 남음';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes}분 남음';
    } else {
      return '곧 종료';
    }
  }
}
