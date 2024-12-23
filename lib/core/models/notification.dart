import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

enum NotificationType {
  @JsonValue('new_post')
  newPost,
  @JsonValue('new_comment')
  newComment,
  @JsonValue('new_reply')
  newReply,
  @JsonValue('commore_received')
  commoreReceived,
  @JsonValue('mu_joined')
  muJoined,
  @JsonValue('mention')
  mention,
  @JsonValue('post_reaction')
  postReaction,
  @JsonValue('comment_reaction')
  commentReaction,
}

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String userId,
    required NotificationType type,
    required String message,
    String? title,
    String? imageUrl,
    String? actionUrl,
    Map<String, dynamic>? data,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  factory Notification.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Notification.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}
