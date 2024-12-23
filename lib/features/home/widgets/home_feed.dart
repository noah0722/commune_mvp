import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/features/home/providers/home_feed_provider.dart';
import 'package:commune/features/home/widgets/feed_filter_bar.dart';
import 'package:commune/features/post/widgets/post_list.dart';
import 'package:commune/core/widgets/error_view.dart';
import 'package:commune/core/widgets/loading_view.dart';

class HomeFeed extends ConsumerWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(homeFeedProvider);

    return Column(
      children: [
        const FeedFilterBar(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              ref.invalidate(homeFeedProvider);
              return Future.value();
            },
            child: feedState.when(
              data: (posts) => PostList(posts: posts),
              loading: () => const LoadingView(),
              error: (error, stack) => ErrorView(
                message: error.toString(),
                onRetry: () => ref.invalidate(homeFeedProvider),
              ),
            ),
          ),
        ),
      ],
    );
  }
}