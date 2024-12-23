// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get id => throw _privateConstructorUsedError;
  String get muId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  PostType get type => throw _privateConstructorUsedError;
  PostStatus get status => throw _privateConstructorUsedError;
  List<String> get mediaUrls => throw _privateConstructorUsedError;
  Map<String, dynamic>? get mediaMetadata => throw _privateConstructorUsedError;
  String? get linkUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get linkMetadata => throw _privateConstructorUsedError;
  Map<String, dynamic>? get pollData => throw _privateConstructorUsedError;
  List<String> get mentions => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  bool get isOfficial => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get thumbsUp => throw _privateConstructorUsedError;
  int get thumbsDown => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  int get shareCount => throw _privateConstructorUsedError;
  int get saveCount => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get scheduledFor => throw _privateConstructorUsedError;
  DateTime? get editedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String id,
      String muId,
      String userId,
      String title,
      String content,
      PostType type,
      PostStatus status,
      List<String> mediaUrls,
      Map<String, dynamic>? mediaMetadata,
      String? linkUrl,
      Map<String, dynamic>? linkMetadata,
      Map<String, dynamic>? pollData,
      List<String> mentions,
      List<String> hashtags,
      bool isOfficial,
      bool isPinned,
      int viewCount,
      int thumbsUp,
      int thumbsDown,
      int commentCount,
      int shareCount,
      int saveCount,
      Map<String, dynamic>? metadata,
      DateTime? scheduledFor,
      DateTime? editedAt,
      DateTime createdAt});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? muId = null,
    Object? userId = null,
    Object? title = null,
    Object? content = null,
    Object? type = null,
    Object? status = null,
    Object? mediaUrls = null,
    Object? mediaMetadata = freezed,
    Object? linkUrl = freezed,
    Object? linkMetadata = freezed,
    Object? pollData = freezed,
    Object? mentions = null,
    Object? hashtags = null,
    Object? isOfficial = null,
    Object? isPinned = null,
    Object? viewCount = null,
    Object? thumbsUp = null,
    Object? thumbsDown = null,
    Object? commentCount = null,
    Object? shareCount = null,
    Object? saveCount = null,
    Object? metadata = freezed,
    Object? scheduledFor = freezed,
    Object? editedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      muId: null == muId
          ? _value.muId
          : muId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PostType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
      mediaUrls: null == mediaUrls
          ? _value.mediaUrls
          : mediaUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mediaMetadata: freezed == mediaMetadata
          ? _value.mediaMetadata
          : mediaMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      linkUrl: freezed == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkMetadata: freezed == linkMetadata
          ? _value.linkMetadata
          : linkMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      pollData: freezed == pollData
          ? _value.pollData
          : pollData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      mentions: null == mentions
          ? _value.mentions
          : mentions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOfficial: null == isOfficial
          ? _value.isOfficial
          : isOfficial // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      thumbsUp: null == thumbsUp
          ? _value.thumbsUp
          : thumbsUp // ignore: cast_nullable_to_non_nullable
              as int,
      thumbsDown: null == thumbsDown
          ? _value.thumbsDown
          : thumbsDown // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      shareCount: null == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int,
      saveCount: null == saveCount
          ? _value.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String muId,
      String userId,
      String title,
      String content,
      PostType type,
      PostStatus status,
      List<String> mediaUrls,
      Map<String, dynamic>? mediaMetadata,
      String? linkUrl,
      Map<String, dynamic>? linkMetadata,
      Map<String, dynamic>? pollData,
      List<String> mentions,
      List<String> hashtags,
      bool isOfficial,
      bool isPinned,
      int viewCount,
      int thumbsUp,
      int thumbsDown,
      int commentCount,
      int shareCount,
      int saveCount,
      Map<String, dynamic>? metadata,
      DateTime? scheduledFor,
      DateTime? editedAt,
      DateTime createdAt});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? muId = null,
    Object? userId = null,
    Object? title = null,
    Object? content = null,
    Object? type = null,
    Object? status = null,
    Object? mediaUrls = null,
    Object? mediaMetadata = freezed,
    Object? linkUrl = freezed,
    Object? linkMetadata = freezed,
    Object? pollData = freezed,
    Object? mentions = null,
    Object? hashtags = null,
    Object? isOfficial = null,
    Object? isPinned = null,
    Object? viewCount = null,
    Object? thumbsUp = null,
    Object? thumbsDown = null,
    Object? commentCount = null,
    Object? shareCount = null,
    Object? saveCount = null,
    Object? metadata = freezed,
    Object? scheduledFor = freezed,
    Object? editedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      muId: null == muId
          ? _value.muId
          : muId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PostType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
      mediaUrls: null == mediaUrls
          ? _value._mediaUrls
          : mediaUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mediaMetadata: freezed == mediaMetadata
          ? _value._mediaMetadata
          : mediaMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      linkUrl: freezed == linkUrl
          ? _value.linkUrl
          : linkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkMetadata: freezed == linkMetadata
          ? _value._linkMetadata
          : linkMetadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      pollData: freezed == pollData
          ? _value._pollData
          : pollData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      mentions: null == mentions
          ? _value._mentions
          : mentions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOfficial: null == isOfficial
          ? _value.isOfficial
          : isOfficial // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      thumbsUp: null == thumbsUp
          ? _value.thumbsUp
          : thumbsUp // ignore: cast_nullable_to_non_nullable
              as int,
      thumbsDown: null == thumbsDown
          ? _value.thumbsDown
          : thumbsDown // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      shareCount: null == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int,
      saveCount: null == saveCount
          ? _value.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
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
class _$PostImpl implements _Post {
  const _$PostImpl(
      {required this.id,
      required this.muId,
      required this.userId,
      required this.title,
      required this.content,
      required this.type,
      this.status = PostStatus.published,
      final List<String> mediaUrls = const [],
      final Map<String, dynamic>? mediaMetadata,
      this.linkUrl,
      final Map<String, dynamic>? linkMetadata,
      final Map<String, dynamic>? pollData,
      final List<String> mentions = const [],
      final List<String> hashtags = const [],
      this.isOfficial = false,
      this.isPinned = false,
      this.viewCount = 0,
      this.thumbsUp = 0,
      this.thumbsDown = 0,
      this.commentCount = 0,
      this.shareCount = 0,
      this.saveCount = 0,
      final Map<String, dynamic>? metadata,
      this.scheduledFor,
      this.editedAt,
      required this.createdAt})
      : _mediaUrls = mediaUrls,
        _mediaMetadata = mediaMetadata,
        _linkMetadata = linkMetadata,
        _pollData = pollData,
        _mentions = mentions,
        _hashtags = hashtags,
        _metadata = metadata;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String id;
  @override
  final String muId;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String content;
  @override
  final PostType type;
  @override
  @JsonKey()
  final PostStatus status;
  final List<String> _mediaUrls;
  @override
  @JsonKey()
  List<String> get mediaUrls {
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaUrls);
  }

  final Map<String, dynamic>? _mediaMetadata;
  @override
  Map<String, dynamic>? get mediaMetadata {
    final value = _mediaMetadata;
    if (value == null) return null;
    if (_mediaMetadata is EqualUnmodifiableMapView) return _mediaMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? linkUrl;
  final Map<String, dynamic>? _linkMetadata;
  @override
  Map<String, dynamic>? get linkMetadata {
    final value = _linkMetadata;
    if (value == null) return null;
    if (_linkMetadata is EqualUnmodifiableMapView) return _linkMetadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _pollData;
  @override
  Map<String, dynamic>? get pollData {
    final value = _pollData;
    if (value == null) return null;
    if (_pollData is EqualUnmodifiableMapView) return _pollData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _mentions;
  @override
  @JsonKey()
  List<String> get mentions {
    if (_mentions is EqualUnmodifiableListView) return _mentions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mentions);
  }

  final List<String> _hashtags;
  @override
  @JsonKey()
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  @JsonKey()
  final bool isOfficial;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int thumbsUp;
  @override
  @JsonKey()
  final int thumbsDown;
  @override
  @JsonKey()
  final int commentCount;
  @override
  @JsonKey()
  final int shareCount;
  @override
  @JsonKey()
  final int saveCount;
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
  final DateTime? scheduledFor;
  @override
  final DateTime? editedAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Post(id: $id, muId: $muId, userId: $userId, title: $title, content: $content, type: $type, status: $status, mediaUrls: $mediaUrls, mediaMetadata: $mediaMetadata, linkUrl: $linkUrl, linkMetadata: $linkMetadata, pollData: $pollData, mentions: $mentions, hashtags: $hashtags, isOfficial: $isOfficial, isPinned: $isPinned, viewCount: $viewCount, thumbsUp: $thumbsUp, thumbsDown: $thumbsDown, commentCount: $commentCount, shareCount: $shareCount, saveCount: $saveCount, metadata: $metadata, scheduledFor: $scheduledFor, editedAt: $editedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.muId, muId) || other.muId == muId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._mediaUrls, _mediaUrls) &&
            const DeepCollectionEquality()
                .equals(other._mediaMetadata, _mediaMetadata) &&
            (identical(other.linkUrl, linkUrl) || other.linkUrl == linkUrl) &&
            const DeepCollectionEquality()
                .equals(other._linkMetadata, _linkMetadata) &&
            const DeepCollectionEquality().equals(other._pollData, _pollData) &&
            const DeepCollectionEquality().equals(other._mentions, _mentions) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.isOfficial, isOfficial) ||
                other.isOfficial == isOfficial) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.thumbsUp, thumbsUp) ||
                other.thumbsUp == thumbsUp) &&
            (identical(other.thumbsDown, thumbsDown) ||
                other.thumbsDown == thumbsDown) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        muId,
        userId,
        title,
        content,
        type,
        status,
        const DeepCollectionEquality().hash(_mediaUrls),
        const DeepCollectionEquality().hash(_mediaMetadata),
        linkUrl,
        const DeepCollectionEquality().hash(_linkMetadata),
        const DeepCollectionEquality().hash(_pollData),
        const DeepCollectionEquality().hash(_mentions),
        const DeepCollectionEquality().hash(_hashtags),
        isOfficial,
        isPinned,
        viewCount,
        thumbsUp,
        thumbsDown,
        commentCount,
        shareCount,
        saveCount,
        const DeepCollectionEquality().hash(_metadata),
        scheduledFor,
        editedAt,
        createdAt
      ]);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {required final String id,
      required final String muId,
      required final String userId,
      required final String title,
      required final String content,
      required final PostType type,
      final PostStatus status,
      final List<String> mediaUrls,
      final Map<String, dynamic>? mediaMetadata,
      final String? linkUrl,
      final Map<String, dynamic>? linkMetadata,
      final Map<String, dynamic>? pollData,
      final List<String> mentions,
      final List<String> hashtags,
      final bool isOfficial,
      final bool isPinned,
      final int viewCount,
      final int thumbsUp,
      final int thumbsDown,
      final int commentCount,
      final int shareCount,
      final int saveCount,
      final Map<String, dynamic>? metadata,
      final DateTime? scheduledFor,
      final DateTime? editedAt,
      required final DateTime createdAt}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String get id;
  @override
  String get muId;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get content;
  @override
  PostType get type;
  @override
  PostStatus get status;
  @override
  List<String> get mediaUrls;
  @override
  Map<String, dynamic>? get mediaMetadata;
  @override
  String? get linkUrl;
  @override
  Map<String, dynamic>? get linkMetadata;
  @override
  Map<String, dynamic>? get pollData;
  @override
  List<String> get mentions;
  @override
  List<String> get hashtags;
  @override
  bool get isOfficial;
  @override
  bool get isPinned;
  @override
  int get viewCount;
  @override
  int get thumbsUp;
  @override
  int get thumbsDown;
  @override
  int get commentCount;
  @override
  int get shareCount;
  @override
  int get saveCount;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get scheduledFor;
  @override
  DateTime? get editedAt;
  @override
  DateTime get createdAt;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
