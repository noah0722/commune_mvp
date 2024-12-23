// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MuImpl _$$MuImplFromJson(Map<String, dynamic> json) => _$MuImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      profileImage: json['profileImage'] as String,
      bannerImage: json['bannerImage'] as String,
      country: json['country'] as String,
      language: json['language'] as String,
      topicLevel1: json['topicLevel1'] as String,
      topicLevel2: json['topicLevel2'] as String,
      category: $enumDecodeNullable(_$MuCategoryEnumMap, json['category']),
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
      postCount: (json['postCount'] as num?)?.toInt() ?? 0,
      isOfficial: json['isOfficial'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      moderators: (json['moderators'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      officialWebsite: json['officialWebsite'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastActivityAt: json['lastActivityAt'] == null
          ? null
          : DateTime.parse(json['lastActivityAt'] as String),
    );

Map<String, dynamic> _$$MuImplToJson(_$MuImpl instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'profileImage': instance.profileImage,
      'bannerImage': instance.bannerImage,
      'country': instance.country,
      'language': instance.language,
      'topicLevel1': instance.topicLevel1,
      'topicLevel2': instance.topicLevel2,
      'category': _$MuCategoryEnumMap[instance.category],
      'memberCount': instance.memberCount,
      'postCount': instance.postCount,
      'isOfficial': instance.isOfficial,
      'isVerified': instance.isVerified,
      'moderators': instance.moderators,
      'officialWebsite': instance.officialWebsite,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
    };

const _$MuCategoryEnumMap = {
  MuCategory.politician: 'politician',
  MuCategory.party: 'party',
  MuCategory.media: 'media',
  MuCategory.pollster: 'pollster',
  MuCategory.candidate: 'candidate',
};
