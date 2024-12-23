// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      muId: json['muId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      type: $enumDecode(_$PostTypeEnumMap, json['type']),
      status: $enumDecodeNullable(_$PostStatusEnumMap, json['status']) ??
          PostStatus.published,
      mediaUrls: (json['mediaUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mediaMetadata: json['mediaMetadata'] as Map<String, dynamic>?,
      linkUrl: json['linkUrl'] as String?,
      linkMetadata: json['linkMetadata'] as Map<String, dynamic>?,
      pollData: json['pollData'] as Map<String, dynamic>?,
      mentions: (json['mentions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isOfficial: json['isOfficial'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      thumbsUp: (json['thumbsUp'] as num?)?.toInt() ?? 0,
      thumbsDown: (json['thumbsDown'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      shareCount: (json['shareCount'] as num?)?.toInt() ?? 0,
      saveCount: (json['saveCount'] as num?)?.toInt() ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>?,
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'muId': instance.muId,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'type': _$PostTypeEnumMap[instance.type]!,
      'status': _$PostStatusEnumMap[instance.status]!,
      'mediaUrls': instance.mediaUrls,
      'mediaMetadata': instance.mediaMetadata,
      'linkUrl': instance.linkUrl,
      'linkMetadata': instance.linkMetadata,
      'pollData': instance.pollData,
      'mentions': instance.mentions,
      'hashtags': instance.hashtags,
      'isOfficial': instance.isOfficial,
      'isPinned': instance.isPinned,
      'viewCount': instance.viewCount,
      'thumbsUp': instance.thumbsUp,
      'thumbsDown': instance.thumbsDown,
      'commentCount': instance.commentCount,
      'shareCount': instance.shareCount,
      'saveCount': instance.saveCount,
      'metadata': instance.metadata,
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
      'editedAt': instance.editedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$PostTypeEnumMap = {
  PostType.text: 'text',
  PostType.media: 'media',
  PostType.link: 'link',
  PostType.poll: 'poll',
};

const _$PostStatusEnumMap = {
  PostStatus.published: 'published',
  PostStatus.draft: 'draft',
  PostStatus.deleted: 'deleted',
  PostStatus.hidden: 'hidden',
};
