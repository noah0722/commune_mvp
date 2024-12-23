import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:commune/core/models/post.dart';
import 'package:commune/features/post/widgets/post_card.dart';
import 'package:commune/core/widgets/error_view.dart';
import 'package:commune/core/widgets/loading_view.dart';

class PostList extends ConsumerStatefulWidget {
  const PostList({
    super.key,
    required this.posts,
    this.enablePagination = false,
    this.fetchPage,
  }) : assert(!enablePagination || fetchPage != null);
  final List<Post> posts;
  final bool enablePagination;
  final Future<List<Post>> Function(int pageKey)? fetchPage;

  @override
  ConsumerState<PostList> createState() => _PostListState();
}

class _PostListState extends ConsumerState<PostList> {
  static const _pageSize = 20;
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    if (widget.enablePagination) {
      _pagingController.addPageRequestListener(_fetchPage);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (!widget.enablePagination) return;

    try {
      final newItems = await widget.fetchPage!(pageKey);
      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enablePagination) {
      return RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: PagedListView<int, Post>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (context, post, index) => PostCard(post: post),
            firstPageErrorIndicatorBuilder: (context) => ErrorView(
              message: _pagingController.error.toString(),
              onRetry: _pagingController.refresh,
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Text('포스트가 없어요'),
            ),
            firstPageProgressIndicatorBuilder: (context) => const LoadingView(),
            newPageProgressIndicatorBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            newPageErrorIndicatorBuilder: (context) => ErrorView(
              message: _pagingController.error.toString(),
              onRetry: _pagingController.retryLastFailedRequest,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: widget.posts.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) => PostCard(
        post: widget.posts[index],
      ),
    );
  }
}
