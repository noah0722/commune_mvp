import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

enum CommentStatus {
  @JsonValue('active')
  active,
  @JsonValue('deleted')
  deleted,
  @JsonValue('hidden')
  hidden,
}

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String postId,
    required String userId,
    required String content,
    String? parentId,
    @Default(1) int level,
    @Default([]) List<String> childIds,
    @Default([]) List<String> mentions,
    @Default(CommentStatus.active) CommentStatus status,
    @Default(0) int thumbsUp,
    @Default(0) int thumbsDown,
    DateTime? editedAt,
    required DateTime createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}
