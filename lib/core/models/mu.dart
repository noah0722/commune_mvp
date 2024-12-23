import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'mu.freezed.dart';
part 'mu.g.dart';

enum MuCategory {
  @JsonValue('politician')
  politician,
  @JsonValue('party')
  party,
  @JsonValue('media')
  media,
  @JsonValue('pollster')
  pollster,
  @JsonValue('candidate')
  candidate,
}

@freezed
class Mu with _$Mu {
  const factory Mu({
    required String id,
    required String name,
    required String description,
    required String profileImage,
    required String bannerImage,
    required String country,
    required String language,
    required String topicLevel1,
    required String topicLevel2,
    MuCategory? category,
    @Default(0) int memberCount,
    @Default(0) int postCount,
    @Default(false) bool isOfficial,
    @Default(false) bool isVerified,
    @Default([]) List<String> moderators,
    String? officialWebsite,
    Map<String, dynamic>? metadata,
    required DateTime createdAt,
    DateTime? lastActivityAt,
  }) = _Mu;

  factory Mu.fromJson(Map<String, dynamic> json) => _$MuFromJson(json);

  factory Mu.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Mu.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}
