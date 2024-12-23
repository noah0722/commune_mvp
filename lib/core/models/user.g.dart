// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      profileImage: json['profileImage'] as String?,
      commorePoints: (json['commorePoints'] as num?)?.toInt() ?? 0,
      joinedMus: (json['joinedMus'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recentMus: (json['recentMus'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      savedPosts: (json['savedPosts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isAdmin: json['isAdmin'] as bool? ?? false,
      isModerator: json['isModerator'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'displayName': instance.displayName,
      'profileImage': instance.profileImage,
      'commorePoints': instance.commorePoints,
      'joinedMus': instance.joinedMus,
      'recentMus': instance.recentMus,
      'savedPosts': instance.savedPosts,
      'isAdmin': instance.isAdmin,
      'isModerator': instance.isModerator,
      'isVerified': instance.isVerified,
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
