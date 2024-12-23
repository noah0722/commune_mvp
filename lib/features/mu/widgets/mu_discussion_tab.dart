import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/mu/providers/mu_posts_provider.dart';
import 'package:commune/features/post/widgets/post_list.dart';
import 'package:commune/core/widgets/error_view.dart';
import 'package:commune/core/widgets/loading_view.dart';

class MuDiscussionTab extends ConsumerWidget {
  final String muId;

  const MuDiscussionTab({
    super.key,
    required this.muId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(muPostsProvider(muId));

    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(muPostsProvider(muId));
        return Future.value();
      },
      child: postsState.when(
        data: (posts) => posts.isEmpty
            ? Center(
                child: Text(
                  '첫 포스트를 작성해보세요!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              )
            : PostList(posts: posts),
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(muPostsProvider(muId)),
        ),
      ),
    );
  }
}