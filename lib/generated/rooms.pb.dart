// This is a generated file - do not edit.
//
// Generated from rooms.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $2;

import 'rooms.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'rooms.pbenum.dart';

class Room extends $pb.GeneratedMessage {
  factory Room({
    $core.String? id,
    $core.String? name,
    $core.String? code,
    RoomStatus? status,
    RoomVisibility? visibility,
    $core.String? hostUserId,
    $2.Timestamp? createdAt,
    $2.Timestamp? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (code != null) result.code = code;
    if (status != null) result.status = status;
    if (visibility != null) result.visibility = visibility;
    if (hostUserId != null) result.hostUserId = hostUserId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Room._();

  factory Room.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Room.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Room',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aE<RoomStatus>(4, _omitFieldNames ? '' : 'status',
        enumValues: RoomStatus.values)
    ..aE<RoomVisibility>(5, _omitFieldNames ? '' : 'visibility',
        enumValues: RoomVisibility.values)
    ..aOS(6, _omitFieldNames ? '' : 'hostUserId')
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(8, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Room clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Room copyWith(void Function(Room) updates) =>
      super.copyWith((message) => updates(message as Room)) as Room;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Room create() => Room._();
  @$core.override
  Room createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Room getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Room>(create);
  static Room? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);

  @$pb.TagNumber(4)
  RoomStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(RoomStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  RoomVisibility get visibility => $_getN(4);
  @$pb.TagNumber(5)
  set visibility(RoomVisibility value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVisibility() => $_has(4);
  @$pb.TagNumber(5)
  void clearVisibility() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get hostUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set hostUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHostUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearHostUserId() => $_clearField(6);

  @$pb.TagNumber(7)
  $2.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($2.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $2.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($2.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $2.Timestamp ensureUpdatedAt() => $_ensure(7);
}

class RoomMember extends $pb.GeneratedMessage {
  factory RoomMember({
    $core.String? roomId,
    $core.String? userId,
    RoomMemberRole? role,
    $2.Timestamp? joinedAt,
    $2.Timestamp? leftAt,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (role != null) result.role = role;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (leftAt != null) result.leftAt = leftAt;
    return result;
  }

  RoomMember._();

  factory RoomMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RoomMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoomMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aE<RoomMemberRole>(3, _omitFieldNames ? '' : 'role',
        enumValues: RoomMemberRole.values)
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'joinedAt',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(5, _omitFieldNames ? '' : 'leftAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomMember clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomMember copyWith(void Function(RoomMember) updates) =>
      super.copyWith((message) => updates(message as RoomMember)) as RoomMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomMember create() => RoomMember._();
  @$core.override
  RoomMember createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RoomMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoomMember>(create);
  static RoomMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  RoomMemberRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(RoomMemberRole value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get joinedAt => $_getN(3);
  @$pb.TagNumber(4)
  set joinedAt($2.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasJoinedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearJoinedAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureJoinedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.Timestamp get leftAt => $_getN(4);
  @$pb.TagNumber(5)
  set leftAt($2.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLeftAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearLeftAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureLeftAt() => $_ensure(4);
}

class RoomSummary extends $pb.GeneratedMessage {
  factory RoomSummary({
    $core.String? roomId,
    $core.String? roomName,
    $core.String? trackId,
    $core.String? trackTitle,
    $core.String? trackArtist,
    $core.String? artworkUrl,
    $core.String? hostUserId,
    $core.String? hostDisplayName,
    $core.int? listenerCount,
    $core.bool? isLive,
    RoomVisibility? visibility,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (roomName != null) result.roomName = roomName;
    if (trackId != null) result.trackId = trackId;
    if (trackTitle != null) result.trackTitle = trackTitle;
    if (trackArtist != null) result.trackArtist = trackArtist;
    if (artworkUrl != null) result.artworkUrl = artworkUrl;
    if (hostUserId != null) result.hostUserId = hostUserId;
    if (hostDisplayName != null) result.hostDisplayName = hostDisplayName;
    if (listenerCount != null) result.listenerCount = listenerCount;
    if (isLive != null) result.isLive = isLive;
    if (visibility != null) result.visibility = visibility;
    return result;
  }

  RoomSummary._();

  factory RoomSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RoomSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoomSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'roomName')
    ..aOS(3, _omitFieldNames ? '' : 'trackId')
    ..aOS(4, _omitFieldNames ? '' : 'trackTitle')
    ..aOS(5, _omitFieldNames ? '' : 'trackArtist')
    ..aOS(6, _omitFieldNames ? '' : 'artworkUrl')
    ..aOS(7, _omitFieldNames ? '' : 'hostUserId')
    ..aOS(8, _omitFieldNames ? '' : 'hostDisplayName')
    ..aI(9, _omitFieldNames ? '' : 'listenerCount')
    ..aOB(10, _omitFieldNames ? '' : 'isLive')
    ..aE<RoomVisibility>(11, _omitFieldNames ? '' : 'visibility',
        enumValues: RoomVisibility.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomSummary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomSummary copyWith(void Function(RoomSummary) updates) =>
      super.copyWith((message) => updates(message as RoomSummary))
          as RoomSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomSummary create() => RoomSummary._();
  @$core.override
  RoomSummary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RoomSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoomSummary>(create);
  static RoomSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomName => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoomName() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get trackId => $_getSZ(2);
  @$pb.TagNumber(3)
  set trackId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTrackId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrackId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get trackTitle => $_getSZ(3);
  @$pb.TagNumber(4)
  set trackTitle($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTrackTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrackTitle() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get trackArtist => $_getSZ(4);
  @$pb.TagNumber(5)
  set trackArtist($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTrackArtist() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrackArtist() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get artworkUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set artworkUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasArtworkUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearArtworkUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get hostUserId => $_getSZ(6);
  @$pb.TagNumber(7)
  set hostUserId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHostUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearHostUserId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get hostDisplayName => $_getSZ(7);
  @$pb.TagNumber(8)
  set hostDisplayName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasHostDisplayName() => $_has(7);
  @$pb.TagNumber(8)
  void clearHostDisplayName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get listenerCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set listenerCount($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasListenerCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearListenerCount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isLive => $_getBF(9);
  @$pb.TagNumber(10)
  set isLive($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsLive() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsLive() => $_clearField(10);

  @$pb.TagNumber(11)
  RoomVisibility get visibility => $_getN(10);
  @$pb.TagNumber(11)
  set visibility(RoomVisibility value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasVisibility() => $_has(10);
  @$pb.TagNumber(11)
  void clearVisibility() => $_clearField(11);
}

class SearchRoomsRequest extends $pb.GeneratedMessage {
  factory SearchRoomsRequest({
    $core.String? query,
    RoomVisibility? visibility,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (visibility != null) result.visibility = visibility;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  SearchRoomsRequest._();

  factory SearchRoomsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRoomsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRoomsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aE<RoomVisibility>(2, _omitFieldNames ? '' : 'visibility',
        enumValues: RoomVisibility.values)
    ..aI(3, _omitFieldNames ? '' : 'pageSize')
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRoomsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRoomsRequest copyWith(void Function(SearchRoomsRequest) updates) =>
      super.copyWith((message) => updates(message as SearchRoomsRequest))
          as SearchRoomsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRoomsRequest create() => SearchRoomsRequest._();
  @$core.override
  SearchRoomsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchRoomsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRoomsRequest>(create);
  static SearchRoomsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  RoomVisibility get visibility => $_getN(1);
  @$pb.TagNumber(2)
  set visibility(RoomVisibility value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasVisibility() => $_has(1);
  @$pb.TagNumber(2)
  void clearVisibility() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => $_clearField(4);
}

class SearchRoomsResponse extends $pb.GeneratedMessage {
  factory SearchRoomsResponse({
    $core.Iterable<RoomSummary>? rooms,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (rooms != null) result.rooms.addAll(rooms);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  SearchRoomsResponse._();

  factory SearchRoomsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchRoomsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchRoomsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..pPM<RoomSummary>(1, _omitFieldNames ? '' : 'rooms',
        subBuilder: RoomSummary.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRoomsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchRoomsResponse copyWith(void Function(SearchRoomsResponse) updates) =>
      super.copyWith((message) => updates(message as SearchRoomsResponse))
          as SearchRoomsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchRoomsResponse create() => SearchRoomsResponse._();
  @$core.override
  SearchRoomsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchRoomsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchRoomsResponse>(create);
  static SearchRoomsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RoomSummary> get rooms => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class CreateRoomRequest extends $pb.GeneratedMessage {
  factory CreateRoomRequest({
    $core.String? name,
    RoomVisibility? visibility,
    $core.bool? inviteOnly,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (visibility != null) result.visibility = visibility;
    if (inviteOnly != null) result.inviteOnly = inviteOnly;
    return result;
  }

  CreateRoomRequest._();

  factory CreateRoomRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateRoomRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRoomRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aE<RoomVisibility>(2, _omitFieldNames ? '' : 'visibility',
        enumValues: RoomVisibility.values)
    ..aOB(3, _omitFieldNames ? '' : 'inviteOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRoomRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRoomRequest copyWith(void Function(CreateRoomRequest) updates) =>
      super.copyWith((message) => updates(message as CreateRoomRequest))
          as CreateRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRoomRequest create() => CreateRoomRequest._();
  @$core.override
  CreateRoomRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateRoomRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRoomRequest>(create);
  static CreateRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  RoomVisibility get visibility => $_getN(1);
  @$pb.TagNumber(2)
  set visibility(RoomVisibility value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasVisibility() => $_has(1);
  @$pb.TagNumber(2)
  void clearVisibility() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get inviteOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set inviteOnly($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInviteOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearInviteOnly() => $_clearField(3);
}

class GetRoomRequest extends $pb.GeneratedMessage {
  factory GetRoomRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  GetRoomRequest._();

  factory GetRoomRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRoomRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRoomRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRoomRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRoomRequest copyWith(void Function(GetRoomRequest) updates) =>
      super.copyWith((message) => updates(message as GetRoomRequest))
          as GetRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRoomRequest create() => GetRoomRequest._();
  @$core.override
  GetRoomRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRoomRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRoomRequest>(create);
  static GetRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class DeleteRoomRequest extends $pb.GeneratedMessage {
  factory DeleteRoomRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  DeleteRoomRequest._();

  factory DeleteRoomRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteRoomRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRoomRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRoomRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRoomRequest copyWith(void Function(DeleteRoomRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteRoomRequest))
          as DeleteRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRoomRequest create() => DeleteRoomRequest._();
  @$core.override
  DeleteRoomRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteRoomRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRoomRequest>(create);
  static DeleteRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

enum JoinRoomRequest_Identifier { roomId, roomCode, notSet }

class JoinRoomRequest extends $pb.GeneratedMessage {
  factory JoinRoomRequest({
    $core.String? roomId,
    $core.String? roomCode,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (roomCode != null) result.roomCode = roomCode;
    return result;
  }

  JoinRoomRequest._();

  factory JoinRoomRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JoinRoomRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, JoinRoomRequest_Identifier>
      _JoinRoomRequest_IdentifierByTag = {
    1: JoinRoomRequest_Identifier.roomId,
    2: JoinRoomRequest_Identifier.roomCode,
    0: JoinRoomRequest_Identifier.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinRoomRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'roomCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRoomRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRoomRequest copyWith(void Function(JoinRoomRequest) updates) =>
      super.copyWith((message) => updates(message as JoinRoomRequest))
          as JoinRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinRoomRequest create() => JoinRoomRequest._();
  @$core.override
  JoinRoomRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JoinRoomRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinRoomRequest>(create);
  static JoinRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  JoinRoomRequest_Identifier whichIdentifier() =>
      _JoinRoomRequest_IdentifierByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearIdentifier() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoomCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomCode() => $_clearField(2);
}

class LeaveRoomRequest extends $pb.GeneratedMessage {
  factory LeaveRoomRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  LeaveRoomRequest._();

  factory LeaveRoomRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeaveRoomRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveRoomRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveRoomRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveRoomRequest copyWith(void Function(LeaveRoomRequest) updates) =>
      super.copyWith((message) => updates(message as LeaveRoomRequest))
          as LeaveRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveRoomRequest create() => LeaveRoomRequest._();
  @$core.override
  LeaveRoomRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LeaveRoomRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveRoomRequest>(create);
  static LeaveRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class ListRoomsRequest extends $pb.GeneratedMessage {
  factory ListRoomsRequest({
    RoomVisibility? visibility,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (visibility != null) result.visibility = visibility;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  ListRoomsRequest._();

  factory ListRoomsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRoomsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRoomsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aE<RoomVisibility>(1, _omitFieldNames ? '' : 'visibility',
        enumValues: RoomVisibility.values)
    ..aI(2, _omitFieldNames ? '' : 'pageSize')
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsRequest copyWith(void Function(ListRoomsRequest) updates) =>
      super.copyWith((message) => updates(message as ListRoomsRequest))
          as ListRoomsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRoomsRequest create() => ListRoomsRequest._();
  @$core.override
  ListRoomsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListRoomsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRoomsRequest>(create);
  static ListRoomsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RoomVisibility get visibility => $_getN(0);
  @$pb.TagNumber(1)
  set visibility(RoomVisibility value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVisibility() => $_has(0);
  @$pb.TagNumber(1)
  void clearVisibility() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => $_clearField(3);
}

class ListRoomsResponse extends $pb.GeneratedMessage {
  factory ListRoomsResponse({
    $core.Iterable<RoomSummary>? rooms,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (rooms != null) result.rooms.addAll(rooms);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListRoomsResponse._();

  factory ListRoomsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRoomsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRoomsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..pPM<RoomSummary>(1, _omitFieldNames ? '' : 'rooms',
        subBuilder: RoomSummary.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsResponse copyWith(void Function(ListRoomsResponse) updates) =>
      super.copyWith((message) => updates(message as ListRoomsResponse))
          as ListRoomsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRoomsResponse create() => ListRoomsResponse._();
  @$core.override
  ListRoomsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListRoomsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRoomsResponse>(create);
  static ListRoomsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RoomSummary> get rooms => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

class SubscribeRequest extends $pb.GeneratedMessage {
  factory SubscribeRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  SubscribeRequest._();

  factory SubscribeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubscribeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubscribeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubscribeRequest copyWith(void Function(SubscribeRequest) updates) =>
      super.copyWith((message) => updates(message as SubscribeRequest))
          as SubscribeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeRequest create() => SubscribeRequest._();
  @$core.override
  SubscribeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SubscribeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubscribeRequest>(create);
  static SubscribeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class GetListenersRequest extends $pb.GeneratedMessage {
  factory GetListenersRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  GetListenersRequest._();

  factory GetListenersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetListenersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetListenersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetListenersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetListenersRequest copyWith(void Function(GetListenersRequest) updates) =>
      super.copyWith((message) => updates(message as GetListenersRequest))
          as GetListenersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetListenersRequest create() => GetListenersRequest._();
  @$core.override
  GetListenersRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetListenersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetListenersRequest>(create);
  static GetListenersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class GetListenersResponse extends $pb.GeneratedMessage {
  factory GetListenersResponse({
    $core.Iterable<JoinedMember>? members,
    $core.int? totalListeners,
  }) {
    final result = create();
    if (members != null) result.members.addAll(members);
    if (totalListeners != null) result.totalListeners = totalListeners;
    return result;
  }

  GetListenersResponse._();

  factory GetListenersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetListenersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetListenersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..pPM<JoinedMember>(1, _omitFieldNames ? '' : 'members',
        subBuilder: JoinedMember.create)
    ..aI(2, _omitFieldNames ? '' : 'totalListeners')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetListenersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetListenersResponse copyWith(void Function(GetListenersResponse) updates) =>
      super.copyWith((message) => updates(message as GetListenersResponse))
          as GetListenersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetListenersResponse create() => GetListenersResponse._();
  @$core.override
  GetListenersResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetListenersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetListenersResponse>(create);
  static GetListenersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<JoinedMember> get members => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalListeners => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalListeners($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalListeners() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalListeners() => $_clearField(2);
}

class JoinedMember extends $pb.GeneratedMessage {
  factory JoinedMember({
    $core.String? userId,
    $core.String? username,
    $core.String? displayName,
    $core.String? avatarUrl,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (displayName != null) result.displayName = displayName;
    if (avatarUrl != null) result.avatarUrl = avatarUrl;
    return result;
  }

  JoinedMember._();

  factory JoinedMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory JoinedMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinedMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'avatarUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinedMember clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinedMember copyWith(void Function(JoinedMember) updates) =>
      super.copyWith((message) => updates(message as JoinedMember))
          as JoinedMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinedMember create() => JoinedMember._();
  @$core.override
  JoinedMember createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static JoinedMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinedMember>(create);
  static JoinedMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get avatarUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set avatarUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAvatarUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAvatarUrl() => $_clearField(4);
}

class LeftMember extends $pb.GeneratedMessage {
  factory LeftMember({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  LeftMember._();

  factory LeftMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeftMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeftMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeftMember clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeftMember copyWith(void Function(LeftMember) updates) =>
      super.copyWith((message) => updates(message as LeftMember)) as LeftMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeftMember create() => LeftMember._();
  @$core.override
  LeftMember createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LeftMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeftMember>(create);
  static LeftMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class LiveChatMessage extends $pb.GeneratedMessage {
  factory LiveChatMessage({
    $core.String? userId,
    $core.String? text,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (text != null) result.text = text;
    return result;
  }

  LiveChatMessage._();

  factory LiveChatMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LiveChatMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LiveChatMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveChatMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LiveChatMessage copyWith(void Function(LiveChatMessage) updates) =>
      super.copyWith((message) => updates(message as LiveChatMessage))
          as LiveChatMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveChatMessage create() => LiveChatMessage._();
  @$core.override
  LiveChatMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LiveChatMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LiveChatMessage>(create);
  static LiveChatMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);
}

class RoomEvent extends $pb.GeneratedMessage {
  factory RoomEvent({
    RoomEventType? type,
    $core.String? roomId,
    JoinedMember? joinedMember,
    LeftMember? leftMember,
    LiveChatMessage? liveChatMessage,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (roomId != null) result.roomId = roomId;
    if (joinedMember != null) result.joinedMember = joinedMember;
    if (leftMember != null) result.leftMember = leftMember;
    if (liveChatMessage != null) result.liveChatMessage = liveChatMessage;
    return result;
  }

  RoomEvent._();

  factory RoomEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RoomEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoomEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aE<RoomEventType>(1, _omitFieldNames ? '' : 'type',
        enumValues: RoomEventType.values)
    ..aOS(2, _omitFieldNames ? '' : 'roomId')
    ..aOM<JoinedMember>(3, _omitFieldNames ? '' : 'joinedMember',
        subBuilder: JoinedMember.create)
    ..aOM<LeftMember>(4, _omitFieldNames ? '' : 'leftMember',
        subBuilder: LeftMember.create)
    ..aOM<LiveChatMessage>(5, _omitFieldNames ? '' : 'liveChatMessage',
        subBuilder: LiveChatMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomEvent copyWith(void Function(RoomEvent) updates) =>
      super.copyWith((message) => updates(message as RoomEvent)) as RoomEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomEvent create() => RoomEvent._();
  @$core.override
  RoomEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RoomEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomEvent>(create);
  static RoomEvent? _defaultInstance;

  @$pb.TagNumber(1)
  RoomEventType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(RoomEventType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomId => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoomId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomId() => $_clearField(2);

  @$pb.TagNumber(3)
  JoinedMember get joinedMember => $_getN(2);
  @$pb.TagNumber(3)
  set joinedMember(JoinedMember value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasJoinedMember() => $_has(2);
  @$pb.TagNumber(3)
  void clearJoinedMember() => $_clearField(3);
  @$pb.TagNumber(3)
  JoinedMember ensureJoinedMember() => $_ensure(2);

  @$pb.TagNumber(4)
  LeftMember get leftMember => $_getN(3);
  @$pb.TagNumber(4)
  set leftMember(LeftMember value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLeftMember() => $_has(3);
  @$pb.TagNumber(4)
  void clearLeftMember() => $_clearField(4);
  @$pb.TagNumber(4)
  LeftMember ensureLeftMember() => $_ensure(3);

  @$pb.TagNumber(5)
  LiveChatMessage get liveChatMessage => $_getN(4);
  @$pb.TagNumber(5)
  set liveChatMessage(LiveChatMessage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLiveChatMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearLiveChatMessage() => $_clearField(5);
  @$pb.TagNumber(5)
  LiveChatMessage ensureLiveChatMessage() => $_ensure(4);
}

class SendLiveChatMessageRequest extends $pb.GeneratedMessage {
  factory SendLiveChatMessageRequest({
    $core.String? roomId,
    $core.String? text,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (text != null) result.text = text;
    return result;
  }

  SendLiveChatMessageRequest._();

  factory SendLiveChatMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendLiveChatMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendLiveChatMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'room'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(3, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendLiveChatMessageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendLiveChatMessageRequest copyWith(
          void Function(SendLiveChatMessageRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SendLiveChatMessageRequest))
          as SendLiveChatMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendLiveChatMessageRequest create() => SendLiveChatMessageRequest._();
  @$core.override
  SendLiveChatMessageRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SendLiveChatMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendLiveChatMessageRequest>(create);
  static SendLiveChatMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  /// string user_id = 2;
  @$pb.TagNumber(3)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(3)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(3)
  void clearText() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
