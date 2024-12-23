// #File: lib/features/mu/providers/mu_posts_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/post.dart';

final muPostsProvider = StreamProvider.family<List<Post>, String>((ref, muId) {
  final db = FirebaseFirestore.instance;
  
  return db.collection('posts')
      .where('muId', isEqualTo: muId)
      .where('status', isEqualTo: PostStatus.published.name)
      .orderBy('createdAt', descending: true)
      .limit(20)
      .snapshots()
      .map((snapshot) => 
          snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
});

final muPostsSortingProvider = StateProvider<PostSorting>((ref) {
  return PostSorting.best;
});

enum PostSorting {
  best,
  latest,
}

final filteredMuPostsProvider = Provider.family<List<Post>, String>((ref, muId) {
  final posts = ref.watch(muPostsProvider(muId)).value ?? [];
  final sorting = ref.watch(muPostsSortingProvider);

  switch (sorting) {
    case PostSorting.best:
      return List.of(posts)
        ..sort((a, b) => (b.thumbsUp - b.thumbsDown)
            .compareTo(a.thumbsUp - a.thumbsDown));
    case PostSorting.latest:
      return posts; // Already sorted by createdAt
  }
});

final muPostsPaginationProvider = StreamProvider.family<List<Post>, MuPostsParams>(
  (ref, params) {
    final db = FirebaseFirestore.instance;
    Query query = db.collection('posts')
        .where('muId', isEqualTo: params.muId)
        .where('status', isEqualTo: PostStatus.published.name);

    if (params.lastPost != null) {
      query = query.startAfterDocument(params.lastPost!);
    }

    return query
        .orderBy('createdAt', descending: true)
        .limit(params.limit)
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
  },
);

class MuPostsParams {
  final String muId;
  final DocumentSnapshot? lastPost;
  final int limit;

  const MuPostsParams({
    required this.muId,
    this.lastPost,
    this.limit = 20,
  });

  MuPostsParams copyWith({
    String? muId,
    DocumentSnapshot? lastPost,
    int? limit,
  }) {
    return MuPostsParams(
      muId: muId ?? this.muId,
      lastPost: lastPost ?? this.lastPost,
      limit: limit ?? this.limit,
    );
  }
}