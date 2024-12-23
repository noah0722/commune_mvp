import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String username,
    String? displayName,
    String? profileImage,
    @Default(0) int commorePoints,
    @Default([]) List<String> joinedMus,
    @Default([]) List<String> recentMus,
    @Default([]) List<String> savedPosts,
    @Default(false) bool isAdmin,
    @Default(false) bool isModerator,
    @Default(false) bool isVerified,
    DateTime? lastLoginAt,
    required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}