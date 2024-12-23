// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  int get commorePoints => throw _privateConstructorUsedError;
  List<String> get joinedMus => throw _privateConstructorUsedError;
  List<String> get recentMus => throw _privateConstructorUsedError;
  List<String> get savedPosts => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  bool get isModerator => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String email,
      String username,
      String? displayName,
      String? profileImage,
      int commorePoints,
      List<String> joinedMus,
      List<String> recentMus,
      List<String> savedPosts,
      bool isAdmin,
      bool isModerator,
      bool isVerified,
      DateTime? lastLoginAt,
      DateTime createdAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? profileImage = freezed,
    Object? commorePoints = null,
    Object? joinedMus = null,
    Object? recentMus = null,
    Object? savedPosts = null,
    Object? isAdmin = null,
    Object? isModerator = null,
    Object? isVerified = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      commorePoints: null == commorePoints
          ? _value.commorePoints
          : commorePoints // ignore: cast_nullable_to_non_nullable
              as int,
      joinedMus: null == joinedMus
          ? _value.joinedMus
          : joinedMus // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recentMus: null == recentMus
          ? _value.recentMus
          : recentMus // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedPosts: null == savedPosts
          ? _value.savedPosts
          : savedPosts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isModerator: null == isModerator
          ? _value.isModerator
          : isModerator // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String username,
      String? displayName,
      String? profileImage,
      int commorePoints,
      List<String> joinedMus,
      List<String> recentMus,
      List<String> savedPosts,
      bool isAdmin,
      bool isModerator,
      bool isVerified,
      DateTime? lastLoginAt,
      DateTime createdAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? profileImage = freezed,
    Object? commorePoints = null,
    Object? joinedMus = null,
    Object? recentMus = null,
    Object? savedPosts = null,
    Object? isAdmin = null,
    Object? isModerator = null,
    Object? isVerified = null,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      commorePoints: null == commorePoints
          ? _value.commorePoints
          : commorePoints // ignore: cast_nullable_to_non_nullable
              as int,
      joinedMus: null == joinedMus
          ? _value._joinedMus
          : joinedMus // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recentMus: null == recentMus
          ? _value._recentMus
          : recentMus // ignore: cast_nullable_to_non_nullable
              as List<String>,
      savedPosts: null == savedPosts
          ? _value._savedPosts
          : savedPosts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      isModerator: null == isModerator
          ? _value.isModerator
          : isModerator // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.email,
      required this.username,
      this.displayName,
      this.profileImage,
      this.commorePoints = 0,
      final List<String> joinedMus = const [],
      final List<String> recentMus = const [],
      final List<String> savedPosts = const [],
      this.isAdmin = false,
      this.isModerator = false,
      this.isVerified = false,
      this.lastLoginAt,
      required this.createdAt})
      : _joinedMus = joinedMus,
        _recentMus = recentMus,
        _savedPosts = savedPosts;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String username;
  @override
  final String? displayName;
  @override
  final String? profileImage;
  @override
  @JsonKey()
  final int commorePoints;
  final List<String> _joinedMus;
  @override
  @JsonKey()
  List<String> get joinedMus {
    if (_joinedMus is EqualUnmodifiableListView) return _joinedMus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_joinedMus);
  }

  final List<String> _recentMus;
  @override
  @JsonKey()
  List<String> get recentMus {
    if (_recentMus is EqualUnmodifiableListView) return _recentMus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentMus);
  }

  final List<String> _savedPosts;
  @override
  @JsonKey()
  List<String> get savedPosts {
    if (_savedPosts is EqualUnmodifiableListView) return _savedPosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedPosts);
  }

  @override
  @JsonKey()
  final bool isAdmin;
  @override
  @JsonKey()
  final bool isModerator;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  final DateTime? lastLoginAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, displayName: $displayName, profileImage: $profileImage, commorePoints: $commorePoints, joinedMus: $joinedMus, recentMus: $recentMus, savedPosts: $savedPosts, isAdmin: $isAdmin, isModerator: $isModerator, isVerified: $isVerified, lastLoginAt: $lastLoginAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.commorePoints, commorePoints) ||
                other.commorePoints == commorePoints) &&
            const DeepCollectionEquality()
                .equals(other._joinedMus, _joinedMus) &&
            const DeepCollectionEquality()
                .equals(other._recentMus, _recentMus) &&
            const DeepCollectionEquality()
                .equals(other._savedPosts, _savedPosts) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isModerator, isModerator) ||
                other.isModerator == isModerator) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      username,
      displayName,
      profileImage,
      commorePoints,
      const DeepCollectionEquality().hash(_joinedMus),
      const DeepCollectionEquality().hash(_recentMus),
      const DeepCollectionEquality().hash(_savedPosts),
      isAdmin,
      isModerator,
      isVerified,
      lastLoginAt,
      createdAt);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String email,
      required final String username,
      final String? displayName,
      final String? profileImage,
      final int commorePoints,
      final List<String> joinedMus,
      final List<String> recentMus,
      final List<String> savedPosts,
      final bool isAdmin,
      final bool isModerator,
      final bool isVerified,
      final DateTime? lastLoginAt,
      required final DateTime createdAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get username;
  @override
  String? get displayName;
  @override
  String? get profileImage;
  @override
  int get commorePoints;
  @override
  List<String> get joinedMus;
  @override
  List<String> get recentMus;
  @override
  List<String> get savedPosts;
  @override
  bool get isAdmin;
  @override
  bool get isModerator;
  @override
  bool get isVerified;
  @override
  DateTime? get lastLoginAt;
  @override
  DateTime get createdAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
