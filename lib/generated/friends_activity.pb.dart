// This is a generated file - do not edit.
//
// Generated from friends_activity.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class FriendActivity extends $pb.GeneratedMessage {
  factory FriendActivity({
    $core.String? friendId,
    $core.String? friendName,
    $core.String? friendAvatarUrl,
    $core.String? status,
    $core.String? trackId,
    $core.String? trackTitle,
    $core.String? trackArtist,
    $core.String? trackCoverUrl,
    $core.String? trackPreviewUrl,
    $1.Timestamp? lastSeen,
  }) {
    final result = create();
    if (friendId != null) result.friendId = friendId;
    if (friendName != null) result.friendName = friendName;
    if (friendAvatarUrl != null) result.friendAvatarUrl = friendAvatarUrl;
    if (status != null) result.status = status;
    if (trackId != null) result.trackId = trackId;
    if (trackTitle != null) result.trackTitle = trackTitle;
    if (trackArtist != null) result.trackArtist = trackArtist;
    if (trackCoverUrl != null) result.trackCoverUrl = trackCoverUrl;
    if (trackPreviewUrl != null) result.trackPreviewUrl = trackPreviewUrl;
    if (lastSeen != null) result.lastSeen = lastSeen;
    return result;
  }

  FriendActivity._();

  factory FriendActivity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FriendActivity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FriendActivity',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'friends_activity'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'friendId')
    ..aOS(2, _omitFieldNames ? '' : 'friendName')
    ..aOS(3, _omitFieldNames ? '' : 'friendAvatarUrl')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'trackId')
    ..aOS(6, _omitFieldNames ? '' : 'trackTitle')
    ..aOS(7, _omitFieldNames ? '' : 'trackArtist')
    ..aOS(8, _omitFieldNames ? '' : 'trackCoverUrl')
    ..aOS(9, _omitFieldNames ? '' : 'trackPreviewUrl')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'lastSeen',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendActivity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FriendActivity copyWith(void Function(FriendActivity) updates) =>
      super.copyWith((message) => updates(message as FriendActivity))
          as FriendActivity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FriendActivity create() => FriendActivity._();
  @$core.override
  FriendActivity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FriendActivity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FriendActivity>(create);
  static FriendActivity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get friendId => $_getSZ(0);
  @$pb.TagNumber(1)
  set friendId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFriendId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFriendId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get friendName => $_getSZ(1);
  @$pb.TagNumber(2)
  set friendName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFriendName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFriendName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get friendAvatarUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set friendAvatarUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFriendAvatarUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFriendAvatarUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  /// Track metadata (can be empty if they have no history)
  @$pb.TagNumber(5)
  $core.String get trackId => $_getSZ(4);
  @$pb.TagNumber(5)
  set trackId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTrackId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrackId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get trackTitle => $_getSZ(5);
  @$pb.TagNumber(6)
  set trackTitle($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTrackTitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTrackTitle() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get trackArtist => $_getSZ(6);
  @$pb.TagNumber(7)
  set trackArtist($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTrackArtist() => $_has(6);
  @$pb.TagNumber(7)
  void clearTrackArtist() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get trackCoverUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set trackCoverUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTrackCoverUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearTrackCoverUrl() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get trackPreviewUrl => $_getSZ(8);
  @$pb.TagNumber(9)
  set trackPreviewUrl($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTrackPreviewUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearTrackPreviewUrl() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get lastSeen => $_getN(9);
  @$pb.TagNumber(10)
  set lastSeen($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasLastSeen() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastSeen() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureLastSeen() => $_ensure(9);
}

class GetFriendsFeedRequest extends $pb.GeneratedMessage {
  factory GetFriendsFeedRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetFriendsFeedRequest._();

  factory GetFriendsFeedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFriendsFeedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFriendsFeedRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'friends_activity'),
      createEmptyInstance: create)
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFriendsFeedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFriendsFeedRequest copyWith(
          void Function(GetFriendsFeedRequest) updates) =>
      super.copyWith((message) => updates(message as GetFriendsFeedRequest))
          as GetFriendsFeedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFriendsFeedRequest create() => GetFriendsFeedRequest._();
  @$core.override
  GetFriendsFeedRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFriendsFeedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFriendsFeedRequest>(create);
  static GetFriendsFeedRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetFriendsFeedResponse extends $pb.GeneratedMessage {
  factory GetFriendsFeedResponse({
    $core.Iterable<FriendActivity>? activities,
  }) {
    final result = create();
    if (activities != null) result.activities.addAll(activities);
    return result;
  }

  GetFriendsFeedResponse._();

  factory GetFriendsFeedResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFriendsFeedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFriendsFeedResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'friends_activity'),
      createEmptyInstance: create)
    ..pPM<FriendActivity>(1, _omitFieldNames ? '' : 'activities',
        subBuilder: FriendActivity.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFriendsFeedResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFriendsFeedResponse copyWith(
          void Function(GetFriendsFeedResponse) updates) =>
      super.copyWith((message) => updates(message as GetFriendsFeedResponse))
          as GetFriendsFeedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFriendsFeedResponse create() => GetFriendsFeedResponse._();
  @$core.override
  GetFriendsFeedResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFriendsFeedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFriendsFeedResponse>(create);
  static GetFriendsFeedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FriendActivity> get activities => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
