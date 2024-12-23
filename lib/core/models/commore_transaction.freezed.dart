// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commore_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommoreTransaction _$CommoreTransactionFromJson(Map<String, dynamic> json) {
  return _CommoreTransaction.fromJson(json);
}

/// @nodoc
mixin _$CommoreTransaction {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  CommoreActionType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get relatedId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CommoreTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommoreTransactionCopyWith<CommoreTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommoreTransactionCopyWith<$Res> {
  factory $CommoreTransactionCopyWith(
          CommoreTransaction value, $Res Function(CommoreTransaction) then) =
      _$CommoreTransactionCopyWithImpl<$Res, CommoreTransaction>;
  @useResult
  $Res call(
      {String id,
      String userId,
      CommoreActionType type,
      int amount,
      String? relatedId,
      String? description,
      Map<String, dynamic>? metadata,
      DateTime createdAt});
}

/// @nodoc
class _$CommoreTransactionCopyWithImpl<$Res, $Val extends CommoreTransaction>
    implements $CommoreTransactionCopyWith<$Res> {
  _$CommoreTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? amount = null,
    Object? relatedId = freezed,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommoreActionType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      relatedId: freezed == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommoreTransactionImplCopyWith<$Res>
    implements $CommoreTransactionCopyWith<$Res> {
  factory _$$CommoreTransactionImplCopyWith(_$CommoreTransactionImpl value,
          $Res Function(_$CommoreTransactionImpl) then) =
      __$$CommoreTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      CommoreActionType type,
      int amount,
      String? relatedId,
      String? description,
      Map<String, dynamic>? metadata,
      DateTime createdAt});
}

/// @nodoc
class __$$CommoreTransactionImplCopyWithImpl<$Res>
    extends _$CommoreTransactionCopyWithImpl<$Res, _$CommoreTransactionImpl>
    implements _$$CommoreTransactionImplCopyWith<$Res> {
  __$$CommoreTransactionImplCopyWithImpl(_$CommoreTransactionImpl _value,
      $Res Function(_$CommoreTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? amount = null,
    Object? relatedId = freezed,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$CommoreTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommoreActionType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      relatedId: freezed == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommoreTransactionImpl implements _CommoreTransaction {
  const _$CommoreTransactionImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.amount,
      this.relatedId,
      this.description,
      final Map<String, dynamic>? metadata,
      required this.createdAt})
      : _metadata = metadata;

  factory _$CommoreTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommoreTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final CommoreActionType type;
  @override
  final int amount;
  @override
  final String? relatedId;
  @override
  final String? description;
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
  String toString() {
    return 'CommoreTransaction(id: $id, userId: $userId, type: $type, amount: $amount, relatedId: $relatedId, description: $description, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommoreTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      type,
      amount,
      relatedId,
      description,
      const DeepCollectionEquality().hash(_metadata),
      createdAt);

  /// Create a copy of CommoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommoreTransactionImplCopyWith<_$CommoreTransactionImpl> get copyWith =>
      __$$CommoreTransactionImplCopyWithImpl<_$CommoreTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommoreTransactionImplToJson(
      this,
    );
  }
}

abstract class _CommoreTransaction implements CommoreTransaction {
  const factory _CommoreTransaction(
      {required final String id,
      required final String userId,
      required final CommoreActionType type,
      required final int amount,
      final String? relatedId,
      final String? description,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt}) = _$CommoreTransactionImpl;

  factory _CommoreTransaction.fromJson(Map<String, dynamic> json) =
      _$CommoreTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  CommoreActionType get type;
  @override
  int get amount;
  @override
  String? get relatedId;
  @override
  String? get description;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get createdAt;

  /// Create a copy of CommoreTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommoreTransactionImplCopyWith<_$CommoreTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
