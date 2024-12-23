import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'post.freezed.dart';
part 'post.g.dart';

enum PostType {
  @JsonValue('text')
  text,
  @JsonValue('media')
  media,
  @JsonValue('link')
  link,
  @JsonValue('poll')
  poll,
}

enum PostStatus {
  @JsonValue('published')
  published,
  @JsonValue('draft')
  draft,
  @JsonValue('deleted')
  deleted,
  @JsonValue('hidden')
  hidden,
}

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String muId,
    required String userId,
    required String title,
    required String content,
    required PostType type,
    @Default(PostStatus.published) PostStatus status,
    @Default([]) List<String> mediaUrls,
    Map<String, dynamic>? mediaMetadata,
    String? linkUrl,
    Map<String, dynamic>? linkMetadata,
    Map<String, dynamic>? pollData,
    @Default([]) List<String> mentions,
    @Default([]) List<String> hashtags,
    @Default(false) bool isOfficial,
    @Default(false) bool isPinned,
    @Default(0) int viewCount,
    @Default(0) int thumbsUp,
    @Default(0) int thumbsDown,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    @Default(0) int saveCount,
    Map<String, dynamic>? metadata,
    DateTime? scheduledFor,
    DateTime? editedAt,
    required DateTime createdAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}
