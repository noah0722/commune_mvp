// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commore_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommoreTransactionImpl _$$CommoreTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$CommoreTransactionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$CommoreActionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toInt(),
      relatedId: json['relatedId'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CommoreTransactionImplToJson(
        _$CommoreTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$CommoreActionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'relatedId': instance.relatedId,
      'description': instance.description,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$CommoreActionTypeEnumMap = {
  CommoreActionType.postCreate: 'post_create',
  CommoreActionType.commentCreate: 'comment_create',
  CommoreActionType.postReaction: 'post_reaction',
  CommoreActionType.commentReaction: 'comment_reaction',
  CommoreActionType.muJoin: 'mu_join',
  CommoreActionType.referral: 'referral',
  CommoreActionType.dailyLogin: 'daily_login',
  CommoreActionType.achievement: 'achievement',
};
