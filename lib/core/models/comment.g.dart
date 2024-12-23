// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      parentId: json['parentId'] as String?,
      level: (json['level'] as num?)?.toInt() ?? 1,
      childIds: (json['childIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mentions: (json['mentions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$CommentStatusEnumMap, json['status']) ??
          CommentStatus.active,
      thumbsUp: (json['thumbsUp'] as num?)?.toInt() ?? 0,
      thumbsDown: (json['thumbsDown'] as num?)?.toInt() ?? 0,
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'content': instance.content,
      'parentId': instance.parentId,
      'level': instance.level,
      'childIds': instance.childIds,
      'mentions': instance.mentions,
      'status': _$CommentStatusEnumMap[instance.status]!,
      'thumbsUp': instance.thumbsUp,
      'thumbsDown': instance.thumbsDown,
      'editedAt': instance.editedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$CommentStatusEnumMap = {
  CommentStatus.active: 'active',
  CommentStatus.deleted: 'deleted',
  CommentStatus.hidden: 'hidden',
};
