// lib/core/models/commore_transaction.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'commore_transaction.freezed.dart';
part 'commore_transaction.g.dart';

enum CommoreActionType {
  @JsonValue('post_create')
  postCreate,
  @JsonValue('comment_create')
  commentCreate,
  @JsonValue('post_reaction')
  postReaction,
  @JsonValue('comment_reaction')
  commentReaction,
  @JsonValue('mu_join')
  muJoin,
  @JsonValue('referral')
  referral,
  @JsonValue('daily_login')
  dailyLogin,
  @JsonValue('achievement')
  achievement,
}

@freezed
class CommoreTransaction with _$CommoreTransaction {
  const factory CommoreTransaction({
    required String id,
    required String userId,
    required CommoreActionType type,
    required int amount,
    String? relatedId,
    String? description,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
  }) = _CommoreTransaction;

  factory CommoreTransaction.fromJson(Map<String, dynamic> json) =>
      _$CommoreTransactionFromJson(json);

  factory CommoreTransaction.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CommoreTransaction.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}
