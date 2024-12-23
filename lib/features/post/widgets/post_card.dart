// #File: lib/features/post/widgets/post_card.dart

import 'package:commune/core/models/mu.dart';
import 'package:commune/features/mu/providers/mu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/post.dart';
import 'package:commune/core/widgets/mu_avatar.dart';
import 'package:commune/core/widgets/link_preview_card.dart';
import 'package:commune/core/widgets/media_preview.dart';
import 'package:commune/core/utils/date_utils.dart' as app_date;
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/post/providers/post_reaction_provider.dart';
import 'package:commune/features/post/providers/poll_provider.dart';
import 'package:commune/features/post/providers/link_preview_provider.dart';
import 'package:commune/features/post/widgets/post_poll_widget.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    super.key,
    required this.post,
    this.isDetailView = false,
    this.onTap,
  });
  final Post post;
  final bool isDetailView;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final muAsync = ref.watch(muProvider(post.muId));

    return muAsync.when(
      data: (mu) {
        if (mu == null) return const SizedBox();

        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, mu),
              InkWell(
                onTap: isDetailView
                    ? null
                    : (onTap ?? () => _navigateToDetail(context)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      _buildContent(context, ref),
                    ],
                  ),
                ),
              ),
              _buildReactions(context, ref),
              const Divider(height: 1),
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        height: 200,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => SizedBox(
        height: 200,
        child: Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Mu mu) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          MuAvatar(
            mu: mu,
            radius: 20,
            showBadge: true,
            onTap: () => _navigateToMu(context, mu.id),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mu/${mu.name}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  app_date.DateUtils.getTimeAgo(post.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (!isDetailView) _buildJoinButton(context, mu.id),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    switch (post.type) {
      case PostType.text:
        return Text(
          post.content,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: isDetailView ? null : 5,
          overflow: isDetailView ? null : TextOverflow.ellipsis,
        );

      case PostType.media:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMediaContent(context),
            if (post.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: isDetailView ? null : 2,
                overflow: isDetailView ? null : TextOverflow.ellipsis,
              ),
            ],
          ],
        );

      case PostType.link:
        final preview = ref.watch(linkPreviewProvider(post.content));
        return preview.when(
          data: (linkPreview) => linkPreview != null
              ? LinkPreviewCard(
                  preview: linkPreview,
                  isClickable: true,
                )
              : Text(post.content),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Text(
            post.content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );

      case PostType.poll:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostPollWidget(post: post),
            if (post.content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: isDetailView ? null : 3,
                overflow: isDetailView ? null : TextOverflow.ellipsis,
              ),
            ],
          ],
        );
    }
  }

  Widget _buildMediaContent(BuildContext context) {
    if (post.mediaUrls.isEmpty) return const SizedBox();

    return SizedBox(
      height: 200,
      child: post.mediaUrls.length == 1
          ? MediaPreview(
              url: post.mediaUrls.first,
              width: double.infinity,
              height: 200,
            )
          : PageView.builder(
              itemCount: post.mediaUrls.length,
              itemBuilder: (context, index) => MediaPreview(
                url: post.mediaUrls[index],
                width: double.infinity,
                height: 200,
              ),
            ),
    );
  }

  Widget _buildReactions(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final reactions = ref.watch(postReactionProvider(post.id));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              reactions.hasUserThumbUp(user?.id)
                  ? Icons.thumb_up
                  : Icons.thumb_up_outlined,
              color: reactions.hasUserThumbUp(user?.id)
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            onPressed: () => _handleThumbUp(context, ref),
          ),
          Text(
            (reactions.thumbsUp - reactions.thumbsDown).toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          IconButton(
            icon: Icon(
              reactions.hasUserThumbDown(user?.id)
                  ? Icons.thumb_down
                  : Icons.thumb_down_outlined,
              color: reactions.hasUserThumbDown(user?.id)
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
            onPressed: () => _handleThumbDown(context, ref),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.comment_outlined),
            onPressed: isDetailView ? null : () => _navigateToDetail(context),
          ),
          Text(
            post.commentCount.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () => _showShareOptions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinButton(BuildContext context, String muId) {
    return ElevatedButton(
      onPressed: () => _handleJoinMu(context, muId),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: Size.zero,
      ),
      child: const Text('가입'),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/post/${post.id}',
    );
  }

  void _navigateToMu(BuildContext context, String muId) {
    Navigator.pushNamed(
      context,
      '/mu/$muId',
    );
  }

  Future<void> _handleThumbUp(BuildContext context, WidgetRef ref) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) {
      _showLoginRequiredDialog(context);
      return;
    }

    try {
      await ref
          .read(postReactionProvider(post.id).notifier)
          .toggleThumbUp(user.id);
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

  Future<void> _handleThumbDown(BuildContext context, WidgetRef ref) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) {
      _showLoginRequiredDialog(context);
      return;
    }

    try {
      await ref
          .read(postReactionProvider(post.id).notifier)
          .toggleThumbDown(user.id);
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

  Future<void> _handleJoinMu(BuildContext context, String muId) async {
    // Implement mu join logic
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => // Implement share options bottom sheet
          const SizedBox(), // Placeholder
    );
  }

  void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인이 필요해요'),
        content: const Text('이 기능을 사용하려면 로그인이 필요합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('로그인'),
          ),
        ],
      ),
    );
  }
}
