// #File: lib/features/home/providers/home_feed_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/post.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/features/home/providers/feed_filter_provider.dart';

final homeFeedProvider = StreamProvider<List<Post>>((ref) {
  final algorithm = ref.watch(feedAlgorithmProvider);
  final postType = ref.watch(postTypeFilterProvider);
  final muType = ref.watch(muTypeFilterProvider);
  final user = ref.watch(authStateProvider).value;

  final db = FirebaseFirestore.instance;
  Query query = db.collection('posts')
      .where('status', isEqualTo: PostStatus.published.name);

  // Apply filters
  if (postType != PostTypeFilter.all) {
    query = query.where('type', isEqualTo: postType.name);
  }

  if (muType != MuTypeFilter.all) {
    query = query.where('muCategory', isEqualTo: muType.name);
  }

  // Apply algorithm-specific logic
  switch (algorithm) {
    case FeedAlgorithm.best:
      // Get posts from last 6 hours with highest engagement
      final sixHoursAgo = DateTime.now().subtract(const Duration(hours: 6));
      return query
          .where('createdAt', isGreaterThan: sixHoursAgo)
          .orderBy('createdAt', descending: true)
          .orderBy('thumbsUp', descending: true)
          .limit(50)
          .snapshots()
          .map((snapshot) => 
              snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());

    case FeedAlgorithm.latest:
      return query
          .orderBy('createdAt', descending: true)
          .limit(50)
          .snapshots()
          .map((snapshot) => 
              snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());

    case FeedAlgorithm.following:
      if (user == null || user.joinedMus.isEmpty) {
        return Stream.value([]);
      }
      return query
          .where('muId', whereIn: user.joinedMus)
          .orderBy('createdAt', descending: true)
          .limit(50)
          .snapshots()
          .map((snapshot) => 
              snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
  }
});

final paginatedHomeFeedProvider = StreamProvider.family<List<Post>, HomeFeedParams>(
  (ref, params) {
    final db = FirebaseFirestore.instance;
    Query query = db.collection('posts')
        .where('status', isEqualTo: PostStatus.published.name);

    // Apply filters
    if (params.postType != PostTypeFilter.all) {
      query = query.where('type', isEqualTo: params.postType.name);
    }

    if (params.muType != MuTypeFilter.all) {
      query = query.where('muCategory', isEqualTo: params.muType.name);
    }

    if (params.algorithm == FeedAlgorithm.following) {
      if (params.userId == null || params.joinedMus.isEmpty) {
        return Stream.value([]);
      }
      query = query.where('muId', whereIn: params.joinedMus);
    }

    if (params.lastPost != null) {
      query = query.startAfterDocument(params.lastPost!);
    }

    // Apply sorting
    switch (params.algorithm) {
      case FeedAlgorithm.best:
        final sixHoursAgo = DateTime.now().subtract(const Duration(hours: 6));
        query = query
            .where('createdAt', isGreaterThan: sixHoursAgo)
            .orderBy('createdAt', descending: true)
            .orderBy('thumbsUp', descending: true);
        break;
      case FeedAlgorithm.latest:
      case FeedAlgorithm.following:
        query = query.orderBy('createdAt', descending: true);
        break;
    }

    return query
        .limit(params.limit)
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
  },
);

class HomeFeedParams {
  final FeedAlgorithm algorithm;
  final PostTypeFilter postType;
  final MuTypeFilter muType;
  final String? userId;
  final List<String> joinedMus;
  final DocumentSnapshot? lastPost;
  final int limit;

  const HomeFeedParams({
    required this.algorithm,
    required this.postType,
    required this.muType,
    this.userId,
    this.joinedMus = const [],
    this.lastPost,
    this.limit = 20,
  });

  HomeFeedParams copyWith({
    FeedAlgorithm? algorithm,
    PostTypeFilter? postType,
    MuTypeFilter? muType,
    String? userId,
    List<String>? joinedMus,
    DocumentSnapshot? lastPost,
    int? limit,
  }) {
    return HomeFeedParams(
      algorithm: algorithm ?? this.algorithm,
      postType: postType ?? this.postType,
      muType: muType ?? this.muType,
      userId: userId ?? this.userId,
      joinedMus: joinedMus ?? this.joinedMus,
      lastPost: lastPost ?? this.lastPost,
      limit: limit ?? this.limit,
    );
  }
}
