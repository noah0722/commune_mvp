// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Mu _$MuFromJson(Map<String, dynamic> json) {
  return _Mu.fromJson(json);
}

/// @nodoc
mixin _$Mu {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  String get bannerImage => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get topicLevel1 => throw _privateConstructorUsedError;
  String get topicLevel2 => throw _privateConstructorUsedError;
  MuCategory? get category => throw _privateConstructorUsedError;
  int get memberCount => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;
  bool get isOfficial => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  List<String> get moderators => throw _privateConstructorUsedError;
  String? get officialWebsite => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;

  /// Serializes this Mu to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MuCopyWith<Mu> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MuCopyWith<$Res> {
  factory $MuCopyWith(Mu value, $Res Function(Mu) then) =
      _$MuCopyWithImpl<$Res, Mu>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String profileImage,
      String bannerImage,
      String country,
      String language,
      String topicLevel1,
      String topicLevel2,
      MuCategory? category,
      int memberCount,
      int postCount,
      bool isOfficial,
      bool isVerified,
      List<String> moderators,
      String? officialWebsite,
      Map<String, dynamic>? metadata,
      DateTime createdAt,
      DateTime? lastActivityAt});
}

/// @nodoc
class _$MuCopyWithImpl<$Res, $Val extends Mu> implements $MuCopyWith<$Res> {
  _$MuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? profileImage = null,
    Object? bannerImage = null,
    Object? country = null,
    Object? language = null,
    Object? topicLevel1 = null,
    Object? topicLevel2 = null,
    Object? category = freezed,
    Object? memberCount = null,
    Object? postCount = null,
    Object? isOfficial = null,
    Object? isVerified = null,
    Object? moderators = null,
    Object? officialWebsite = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      bannerImage: null == bannerImage
          ? _value.bannerImage
          : bannerImage // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      topicLevel1: null == topicLevel1
          ? _value.topicLevel1
          : topicLevel1 // ignore: cast_nullable_to_non_nullable
              as String,
      topicLevel2: null == topicLevel2
          ? _value.topicLevel2
          : topicLevel2 // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as MuCategory?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOfficial: null == isOfficial
          ? _value.isOfficial
          : isOfficial // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      moderators: null == moderators
          ? _value.moderators
          : moderators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      officialWebsite: freezed == officialWebsite
          ? _value.officialWebsite
          : officialWebsite // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MuImplCopyWith<$Res> implements $MuCopyWith<$Res> {
  factory _$$MuImplCopyWith(_$MuImpl value, $Res Function(_$MuImpl) then) =
      __$$MuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String profileImage,
      String bannerImage,
      String country,
      String language,
      String topicLevel1,
      String topicLevel2,
      MuCategory? category,
      int memberCount,
      int postCount,
      bool isOfficial,
      bool isVerified,
      List<String> moderators,
      String? officialWebsite,
      Map<String, dynamic>? metadata,
      DateTime createdAt,
      DateTime? lastActivityAt});
}

/// @nodoc
class __$$MuImplCopyWithImpl<$Res> extends _$MuCopyWithImpl<$Res, _$MuImpl>
    implements _$$MuImplCopyWith<$Res> {
  __$$MuImplCopyWithImpl(_$MuImpl _value, $Res Function(_$MuImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? profileImage = null,
    Object? bannerImage = null,
    Object? country = null,
    Object? language = null,
    Object? topicLevel1 = null,
    Object? topicLevel2 = null,
    Object? category = freezed,
    Object? memberCount = null,
    Object? postCount = null,
    Object? isOfficial = null,
    Object? isVerified = null,
    Object? moderators = null,
    Object? officialWebsite = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_$MuImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      bannerImage: null == bannerImage
          ? _value.bannerImage
          : bannerImage // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      topicLevel1: null == topicLevel1
          ? _value.topicLevel1
          : topicLevel1 // ignore: cast_nullable_to_non_nullable
              as String,
      topicLevel2: null == topicLevel2
          ? _value.topicLevel2
          : topicLevel2 // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as MuCategory?,
      memberCount: null == memberCount
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOfficial: null == isOfficial
          ? _value.isOfficial
          : isOfficial // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      moderators: null == moderators
          ? _value._moderators
          : moderators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      officialWebsite: freezed == officialWebsite
          ? _value.officialWebsite
          : officialWebsite // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MuImpl implements _Mu {
  const _$MuImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.profileImage,
      required this.bannerImage,
      required this.country,
      required this.language,
      required this.topicLevel1,
      required this.topicLevel2,
      this.category,
      this.memberCount = 0,
      this.postCount = 0,
      this.isOfficial = false,
      this.isVerified = false,
      final List<String> moderators = const [],
      this.officialWebsite,
      final Map<String, dynamic>? metadata,
      required this.createdAt,
      this.lastActivityAt})
      : _moderators = moderators,
        _metadata = metadata;

  factory _$MuImpl.fromJson(Map<String, dynamic> json) =>
      _$$MuImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String profileImage;
  @override
  final String bannerImage;
  @override
  final String country;
  @override
  final String language;
  @override
  final String topicLevel1;
  @override
  final String topicLevel2;
  @override
  final MuCategory? category;
  @override
  @JsonKey()
  final int memberCount;
  @override
  @JsonKey()
  final int postCount;
  @override
  @JsonKey()
  final bool isOfficial;
  @override
  @JsonKey()
  final bool isVerified;
  final List<String> _moderators;
  @override
  @JsonKey()
  List<String> get moderators {
    if (_moderators is EqualUnmodifiableListView) return _moderators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_moderators);
  }

  @override
  final String? officialWebsite;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? lastActivityAt;

  @override
  String toString() {
    return 'Mu(id: $id, name: $name, description: $description, profileImage: $profileImage, bannerImage: $bannerImage, country: $country, language: $language, topicLevel1: $topicLevel1, topicLevel2: $topicLevel2, category: $category, memberCount: $memberCount, postCount: $postCount, isOfficial: $isOfficial, isVerified: $isVerified, moderators: $moderators, officialWebsite: $officialWebsite, metadata: $metadata, createdAt: $createdAt, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MuImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.bannerImage, bannerImage) ||
                other.bannerImage == bannerImage) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.topicLevel1, topicLevel1) ||
                other.topicLevel1 == topicLevel1) &&
            (identical(other.topicLevel2, topicLevel2) ||
                other.topicLevel2 == topicLevel2) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.isOfficial, isOfficial) ||
                other.isOfficial == isOfficial) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            const DeepCollectionEquality()
                .equals(other._moderators, _moderators) &&
            (identical(other.officialWebsite, officialWebsite) ||
                other.officialWebsite == officialWebsite) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        profileImage,
        bannerImage,
        country,
        language,
        topicLevel1,
        topicLevel2,
        category,
        memberCount,
        postCount,
        isOfficial,
        isVerified,
        const DeepCollectionEquality().hash(_moderators),
        officialWebsite,
        const DeepCollectionEquality().hash(_metadata),
        createdAt,
        lastActivityAt
      ]);

  /// Create a copy of Mu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MuImplCopyWith<_$MuImpl> get copyWith =>
      __$$MuImplCopyWithImpl<_$MuImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MuImplToJson(
      this,
    );
  }
}

abstract class _Mu implements Mu {
  const factory _Mu(
      {required final String id,
      required final String name,
      required final String description,
      required final String profileImage,
      required final String bannerImage,
      required final String country,
      required final String language,
      required final String topicLevel1,
      required final String topicLevel2,
      final MuCategory? category,
      final int memberCount,
      final int postCount,
      final bool isOfficial,
      final bool isVerified,
      final List<String> moderators,
      final String? officialWebsite,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt,
      final DateTime? lastActivityAt}) = _$MuImpl;

  factory _Mu.fromJson(Map<String, dynamic> json) = _$MuImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get profileImage;
  @override
  String get bannerImage;
  @override
  String get country;
  @override
  String get language;
  @override
  String get topicLevel1;
  @override
  String get topicLevel2;
  @override
  MuCategory? get category;
  @override
  int get memberCount;
  @override
  int get postCount;
  @override
  bool get isOfficial;
  @override
  bool get isVerified;
  @override
  List<String> get moderators;
  @override
  String? get officialWebsite;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime? get lastActivityAt;

  /// Create a copy of Mu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MuImplCopyWith<_$MuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
