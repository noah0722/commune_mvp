// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      message: json['message'] as String,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      actionUrl: json['actionUrl'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      isRead: json['isRead'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'message': instance.message,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'actionUrl': instance.actionUrl,
      'data': instance.data,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.newPost: 'new_post',
  NotificationType.newComment: 'new_comment',
  NotificationType.newReply: 'new_reply',
  NotificationType.commoreReceived: 'commore_received',
  NotificationType.muJoined: 'mu_joined',
  NotificationType.mention: 'mention',
  NotificationType.postReaction: 'post_reaction',
  NotificationType.commentReaction: 'comment_reaction',
};
