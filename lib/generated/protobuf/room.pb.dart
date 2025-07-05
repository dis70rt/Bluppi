//
//  Generated code. Do not modify.
//  source: protobuf/room.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $8;
import 'common.pbenum.dart' as $9;
import 'playback.pb.dart' as $1;
import 'track.pb.dart' as $6;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Room extends $pb.GeneratedMessage {
  factory Room({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? roomCode,
    $9.RoomStatus? status,
    $9.RoomVisibility? visibility,
    $core.bool? inviteOnly,
    $core.Iterable<RoomMember>? members,
    $core.String? hostUserId,
    $1.PlaybackState? playbackState,
    $6.Track? currentTrack,
    $fixnum.Int64? currentPositionMs,
    $fixnum.Int64? lastPositionUpdate,
    $fixnum.Int64? trackStartTime,
    $core.bool? isPlaying,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (roomCode != null) result.roomCode = roomCode;
    if (status != null) result.status = status;
    if (visibility != null) result.visibility = visibility;
    if (inviteOnly != null) result.inviteOnly = inviteOnly;
    if (members != null) result.members.addAll(members);
    if (hostUserId != null) result.hostUserId = hostUserId;
    if (playbackState != null) result.playbackState = playbackState;
    if (currentTrack != null) result.currentTrack = currentTrack;
    if (currentPositionMs != null) result.currentPositionMs = currentPositionMs;
    if (lastPositionUpdate != null) result.lastPositionUpdate = lastPositionUpdate;
    if (trackStartTime != null) result.trackStartTime = trackStartTime;
    if (isPlaying != null) result.isPlaying = isPlaying;
    return result;
  }

  Room._();

  factory Room.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Room.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Room', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'roomCode')
    ..e<$9.RoomStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomStatus.ACTIVE, valueOf: $9.RoomStatus.valueOf, enumValues: $9.RoomStatus.values)
    ..e<$9.RoomVisibility>(6, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomVisibility.PUBLIC, valueOf: $9.RoomVisibility.valueOf, enumValues: $9.RoomVisibility.values)
    ..aOB(7, _omitFieldNames ? '' : 'inviteOnly')
    ..pc<RoomMember>(8, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: RoomMember.create)
    ..aOS(9, _omitFieldNames ? '' : 'hostUserId')
    ..aOM<$1.PlaybackState>(10, _omitFieldNames ? '' : 'playbackState', subBuilder: $1.PlaybackState.create)
    ..aOM<$6.Track>(11, _omitFieldNames ? '' : 'currentTrack', subBuilder: $6.Track.create)
    ..aInt64(12, _omitFieldNames ? '' : 'currentPositionMs')
    ..aInt64(13, _omitFieldNames ? '' : 'lastPositionUpdate')
    ..aInt64(14, _omitFieldNames ? '' : 'trackStartTime')
    ..aOB(15, _omitFieldNames ? '' : 'isPlaying')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Room clone() => Room()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Room copyWith(void Function(Room) updates) => super.copyWith((message) => updates(message as Room)) as Room;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Room create() => Room._();
  @$core.override
  Room createEmptyInstance() => create();
  static $pb.PbList<Room> createRepeated() => $pb.PbList<Room>();
  @$core.pragma('dart2js:noInline')
  static Room getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Room>(create);
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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get roomCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set roomCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRoomCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoomCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $9.RoomStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status($9.RoomStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $9.RoomVisibility get visibility => $_getN(5);
  @$pb.TagNumber(6)
  set visibility($9.RoomVisibility value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVisibility() => $_has(5);
  @$pb.TagNumber(6)
  void clearVisibility() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get inviteOnly => $_getBF(6);
  @$pb.TagNumber(7)
  set inviteOnly($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasInviteOnly() => $_has(6);
  @$pb.TagNumber(7)
  void clearInviteOnly() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<RoomMember> get members => $_getList(7);

  @$pb.TagNumber(9)
  $core.String get hostUserId => $_getSZ(8);
  @$pb.TagNumber(9)
  set hostUserId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasHostUserId() => $_has(8);
  @$pb.TagNumber(9)
  void clearHostUserId() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.PlaybackState get playbackState => $_getN(9);
  @$pb.TagNumber(10)
  set playbackState($1.PlaybackState value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasPlaybackState() => $_has(9);
  @$pb.TagNumber(10)
  void clearPlaybackState() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.PlaybackState ensurePlaybackState() => $_ensure(9);

  @$pb.TagNumber(11)
  $6.Track get currentTrack => $_getN(10);
  @$pb.TagNumber(11)
  set currentTrack($6.Track value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrentTrack() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrentTrack() => $_clearField(11);
  @$pb.TagNumber(11)
  $6.Track ensureCurrentTrack() => $_ensure(10);

  @$pb.TagNumber(12)
  $fixnum.Int64 get currentPositionMs => $_getI64(11);
  @$pb.TagNumber(12)
  set currentPositionMs($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCurrentPositionMs() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrentPositionMs() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get lastPositionUpdate => $_getI64(12);
  @$pb.TagNumber(13)
  set lastPositionUpdate($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLastPositionUpdate() => $_has(12);
  @$pb.TagNumber(13)
  void clearLastPositionUpdate() => $_clearField(13);

  @$pb.TagNumber(14)
  $fixnum.Int64 get trackStartTime => $_getI64(13);
  @$pb.TagNumber(14)
  set trackStartTime($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasTrackStartTime() => $_has(13);
  @$pb.TagNumber(14)
  void clearTrackStartTime() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.bool get isPlaying => $_getBF(14);
  @$pb.TagNumber(15)
  set isPlaying($core.bool value) => $_setBool(14, value);
  @$pb.TagNumber(15)
  $core.bool hasIsPlaying() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsPlaying() => $_clearField(15);
}

class CreateRoomRequest extends $pb.GeneratedMessage {
  factory CreateRoomRequest({
    $core.String? name,
    $core.String? description,
    $core.String? roomCode,
    $9.RoomVisibility? visibility,
    $core.bool? inviteOnly,
    $core.String? hostUserId,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (roomCode != null) result.roomCode = roomCode;
    if (visibility != null) result.visibility = visibility;
    if (inviteOnly != null) result.inviteOnly = inviteOnly;
    if (hostUserId != null) result.hostUserId = hostUserId;
    return result;
  }

  CreateRoomRequest._();

  factory CreateRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CreateRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'roomCode')
    ..e<$9.RoomVisibility>(4, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomVisibility.PUBLIC, valueOf: $9.RoomVisibility.valueOf, enumValues: $9.RoomVisibility.values)
    ..aOB(5, _omitFieldNames ? '' : 'inviteOnly')
    ..aOS(6, _omitFieldNames ? '' : 'hostUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRoomRequest clone() => CreateRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateRoomRequest copyWith(void Function(CreateRoomRequest) updates) => super.copyWith((message) => updates(message as CreateRoomRequest)) as CreateRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRoomRequest create() => CreateRoomRequest._();
  @$core.override
  CreateRoomRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRoomRequest> createRepeated() => $pb.PbList<CreateRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateRoomRequest>(create);
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
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get roomCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set roomCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRoomCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoomCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $9.RoomVisibility get visibility => $_getN(3);
  @$pb.TagNumber(4)
  set visibility($9.RoomVisibility value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVisibility() => $_has(3);
  @$pb.TagNumber(4)
  void clearVisibility() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get inviteOnly => $_getBF(4);
  @$pb.TagNumber(5)
  set inviteOnly($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInviteOnly() => $_has(4);
  @$pb.TagNumber(5)
  void clearInviteOnly() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get hostUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set hostUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHostUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearHostUserId() => $_clearField(6);
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

  factory GetRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRoomRequest clone() => GetRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRoomRequest copyWith(void Function(GetRoomRequest) updates) => super.copyWith((message) => updates(message as GetRoomRequest)) as GetRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRoomRequest create() => GetRoomRequest._();
  @$core.override
  GetRoomRequest createEmptyInstance() => create();
  static $pb.PbList<GetRoomRequest> createRepeated() => $pb.PbList<GetRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRoomRequest>(create);
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

class GetRoomByCodeRequest extends $pb.GeneratedMessage {
  factory GetRoomByCodeRequest({
    $core.String? roomCode,
  }) {
    final result = create();
    if (roomCode != null) result.roomCode = roomCode;
    return result;
  }

  GetRoomByCodeRequest._();

  factory GetRoomByCodeRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetRoomByCodeRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRoomByCodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRoomByCodeRequest clone() => GetRoomByCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRoomByCodeRequest copyWith(void Function(GetRoomByCodeRequest) updates) => super.copyWith((message) => updates(message as GetRoomByCodeRequest)) as GetRoomByCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRoomByCodeRequest create() => GetRoomByCodeRequest._();
  @$core.override
  GetRoomByCodeRequest createEmptyInstance() => create();
  static $pb.PbList<GetRoomByCodeRequest> createRepeated() => $pb.PbList<GetRoomByCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRoomByCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRoomByCodeRequest>(create);
  static GetRoomByCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomCode() => $_clearField(1);
}

class UpdateRoomRequest extends $pb.GeneratedMessage {
  factory UpdateRoomRequest({
    $core.String? roomId,
    $core.String? name,
    $core.String? description,
    $9.RoomVisibility? visibility,
    $core.bool? inviteOnly,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (visibility != null) result.visibility = visibility;
    if (inviteOnly != null) result.inviteOnly = inviteOnly;
    return result;
  }

  UpdateRoomRequest._();

  factory UpdateRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<$9.RoomVisibility>(4, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomVisibility.PUBLIC, valueOf: $9.RoomVisibility.valueOf, enumValues: $9.RoomVisibility.values)
    ..aOB(5, _omitFieldNames ? '' : 'inviteOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRoomRequest clone() => UpdateRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRoomRequest copyWith(void Function(UpdateRoomRequest) updates) => super.copyWith((message) => updates(message as UpdateRoomRequest)) as UpdateRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRoomRequest create() => UpdateRoomRequest._();
  @$core.override
  UpdateRoomRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateRoomRequest> createRepeated() => $pb.PbList<UpdateRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateRoomRequest>(create);
  static UpdateRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $9.RoomVisibility get visibility => $_getN(3);
  @$pb.TagNumber(4)
  set visibility($9.RoomVisibility value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVisibility() => $_has(3);
  @$pb.TagNumber(4)
  void clearVisibility() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get inviteOnly => $_getBF(4);
  @$pb.TagNumber(5)
  set inviteOnly($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInviteOnly() => $_has(4);
  @$pb.TagNumber(5)
  void clearInviteOnly() => $_clearField(5);
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

  factory DeleteRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory DeleteRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRoomRequest clone() => DeleteRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteRoomRequest copyWith(void Function(DeleteRoomRequest) updates) => super.copyWith((message) => updates(message as DeleteRoomRequest)) as DeleteRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRoomRequest create() => DeleteRoomRequest._();
  @$core.override
  DeleteRoomRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRoomRequest> createRepeated() => $pb.PbList<DeleteRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteRoomRequest>(create);
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

class ListRoomsRequest extends $pb.GeneratedMessage {
  factory ListRoomsRequest({
    $9.RoomVisibility? visibilityFilter,
    $core.String? hostUserIdFilter,
    $core.bool? includePrivateRoomsIfMember,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (visibilityFilter != null) result.visibilityFilter = visibilityFilter;
    if (hostUserIdFilter != null) result.hostUserIdFilter = hostUserIdFilter;
    if (includePrivateRoomsIfMember != null) result.includePrivateRoomsIfMember = includePrivateRoomsIfMember;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  ListRoomsRequest._();

  factory ListRoomsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListRoomsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRoomsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..e<$9.RoomVisibility>(1, _omitFieldNames ? '' : 'visibilityFilter', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomVisibility.PUBLIC, valueOf: $9.RoomVisibility.valueOf, enumValues: $9.RoomVisibility.values)
    ..aOS(2, _omitFieldNames ? '' : 'hostUserIdFilter')
    ..aOB(3, _omitFieldNames ? '' : 'includePrivateRoomsIfMember')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsRequest clone() => ListRoomsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsRequest copyWith(void Function(ListRoomsRequest) updates) => super.copyWith((message) => updates(message as ListRoomsRequest)) as ListRoomsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRoomsRequest create() => ListRoomsRequest._();
  @$core.override
  ListRoomsRequest createEmptyInstance() => create();
  static $pb.PbList<ListRoomsRequest> createRepeated() => $pb.PbList<ListRoomsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRoomsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRoomsRequest>(create);
  static ListRoomsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $9.RoomVisibility get visibilityFilter => $_getN(0);
  @$pb.TagNumber(1)
  set visibilityFilter($9.RoomVisibility value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasVisibilityFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearVisibilityFilter() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get hostUserIdFilter => $_getSZ(1);
  @$pb.TagNumber(2)
  set hostUserIdFilter($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHostUserIdFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearHostUserIdFilter() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includePrivateRoomsIfMember => $_getBF(2);
  @$pb.TagNumber(3)
  set includePrivateRoomsIfMember($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIncludePrivateRoomsIfMember() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludePrivateRoomsIfMember() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get pageToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set pageToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageToken() => $_clearField(5);
}

class ListRoomsResponse extends $pb.GeneratedMessage {
  factory ListRoomsResponse({
    $core.Iterable<Room>? rooms,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (rooms != null) result.rooms.addAll(rooms);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  ListRoomsResponse._();

  factory ListRoomsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListRoomsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListRoomsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..pc<Room>(1, _omitFieldNames ? '' : 'rooms', $pb.PbFieldType.PM, subBuilder: Room.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsResponse clone() => ListRoomsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRoomsResponse copyWith(void Function(ListRoomsResponse) updates) => super.copyWith((message) => updates(message as ListRoomsResponse)) as ListRoomsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRoomsResponse create() => ListRoomsResponse._();
  @$core.override
  ListRoomsResponse createEmptyInstance() => create();
  static $pb.PbList<ListRoomsResponse> createRepeated() => $pb.PbList<ListRoomsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListRoomsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListRoomsResponse>(create);
  static ListRoomsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Room> get rooms => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}

enum JoinRoomRequest_Identifier {
  roomId, 
  roomCode, 
  notSet
}

class JoinRoomRequest extends $pb.GeneratedMessage {
  factory JoinRoomRequest({
    $core.String? roomId,
    $core.String? roomCode,
    $core.String? userId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (roomCode != null) result.roomCode = roomCode;
    if (userId != null) result.userId = userId;
    return result;
  }

  JoinRoomRequest._();

  factory JoinRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory JoinRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, JoinRoomRequest_Identifier> _JoinRoomRequest_IdentifierByTag = {
    1 : JoinRoomRequest_Identifier.roomId,
    2 : JoinRoomRequest_Identifier.roomCode,
    0 : JoinRoomRequest_Identifier.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'roomCode')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRoomRequest clone() => JoinRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRoomRequest copyWith(void Function(JoinRoomRequest) updates) => super.copyWith((message) => updates(message as JoinRoomRequest)) as JoinRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinRoomRequest create() => JoinRoomRequest._();
  @$core.override
  JoinRoomRequest createEmptyInstance() => create();
  static $pb.PbList<JoinRoomRequest> createRepeated() => $pb.PbList<JoinRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinRoomRequest>(create);
  static JoinRoomRequest? _defaultInstance;

  JoinRoomRequest_Identifier whichIdentifier() => _JoinRoomRequest_IdentifierByTag[$_whichOneof(0)]!;
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

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);
}

class LeaveRoomRequest extends $pb.GeneratedMessage {
  factory LeaveRoomRequest({
    $core.String? roomId,
    $core.String? userId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    return result;
  }

  LeaveRoomRequest._();

  factory LeaveRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory LeaveRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaveRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveRoomRequest clone() => LeaveRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveRoomRequest copyWith(void Function(LeaveRoomRequest) updates) => super.copyWith((message) => updates(message as LeaveRoomRequest)) as LeaveRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveRoomRequest create() => LeaveRoomRequest._();
  @$core.override
  LeaveRoomRequest createEmptyInstance() => create();
  static $pb.PbList<LeaveRoomRequest> createRepeated() => $pb.PbList<LeaveRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static LeaveRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveRoomRequest>(create);
  static LeaveRoomRequest? _defaultInstance;

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
}

class InviteToRoomRequest extends $pb.GeneratedMessage {
  factory InviteToRoomRequest({
    $core.String? roomId,
    $core.String? inviterUserId,
    $core.String? inviteeUserId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (inviterUserId != null) result.inviterUserId = inviterUserId;
    if (inviteeUserId != null) result.inviteeUserId = inviteeUserId;
    return result;
  }

  InviteToRoomRequest._();

  factory InviteToRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory InviteToRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InviteToRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'inviterUserId')
    ..aOS(3, _omitFieldNames ? '' : 'inviteeUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteToRoomRequest clone() => InviteToRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteToRoomRequest copyWith(void Function(InviteToRoomRequest) updates) => super.copyWith((message) => updates(message as InviteToRoomRequest)) as InviteToRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InviteToRoomRequest create() => InviteToRoomRequest._();
  @$core.override
  InviteToRoomRequest createEmptyInstance() => create();
  static $pb.PbList<InviteToRoomRequest> createRepeated() => $pb.PbList<InviteToRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static InviteToRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InviteToRoomRequest>(create);
  static InviteToRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get inviterUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set inviterUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInviterUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInviterUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get inviteeUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set inviteeUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInviteeUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInviteeUserId() => $_clearField(3);
}

class KickFromRoomRequest extends $pb.GeneratedMessage {
  factory KickFromRoomRequest({
    $core.String? roomId,
    $core.String? performingUserId,
    $core.String? kickedUserId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (performingUserId != null) result.performingUserId = performingUserId;
    if (kickedUserId != null) result.kickedUserId = kickedUserId;
    return result;
  }

  KickFromRoomRequest._();

  factory KickFromRoomRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory KickFromRoomRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KickFromRoomRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'performingUserId')
    ..aOS(3, _omitFieldNames ? '' : 'kickedUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KickFromRoomRequest clone() => KickFromRoomRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KickFromRoomRequest copyWith(void Function(KickFromRoomRequest) updates) => super.copyWith((message) => updates(message as KickFromRoomRequest)) as KickFromRoomRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KickFromRoomRequest create() => KickFromRoomRequest._();
  @$core.override
  KickFromRoomRequest createEmptyInstance() => create();
  static $pb.PbList<KickFromRoomRequest> createRepeated() => $pb.PbList<KickFromRoomRequest>();
  @$core.pragma('dart2js:noInline')
  static KickFromRoomRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KickFromRoomRequest>(create);
  static KickFromRoomRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get performingUserId => $_getSZ(1);
  @$pb.TagNumber(2)
  set performingUserId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerformingUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerformingUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get kickedUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set kickedUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasKickedUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearKickedUserId() => $_clearField(3);
}

class RoomMember extends $pb.GeneratedMessage {
  factory RoomMember({
    $core.String? roomId,
    $core.String? userId,
    $9.RoomMemberRole? role,
    $core.String? invitedBy,
    $8.Timestamp? joinedAt,
    $8.Timestamp? leftAt,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (role != null) result.role = role;
    if (invitedBy != null) result.invitedBy = invitedBy;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (leftAt != null) result.leftAt = leftAt;
    return result;
  }

  RoomMember._();

  factory RoomMember.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomMember.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomMember', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<$9.RoomMemberRole>(3, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomMemberRole.HOST, valueOf: $9.RoomMemberRole.valueOf, enumValues: $9.RoomMemberRole.values)
    ..aOS(4, _omitFieldNames ? '' : 'invitedBy')
    ..aOM<$8.Timestamp>(5, _omitFieldNames ? '' : 'joinedAt', subBuilder: $8.Timestamp.create)
    ..aOM<$8.Timestamp>(6, _omitFieldNames ? '' : 'leftAt', subBuilder: $8.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomMember clone() => RoomMember()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomMember copyWith(void Function(RoomMember) updates) => super.copyWith((message) => updates(message as RoomMember)) as RoomMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomMember create() => RoomMember._();
  @$core.override
  RoomMember createEmptyInstance() => create();
  static $pb.PbList<RoomMember> createRepeated() => $pb.PbList<RoomMember>();
  @$core.pragma('dart2js:noInline')
  static RoomMember getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomMember>(create);
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
  $9.RoomMemberRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role($9.RoomMemberRole value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get invitedBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set invitedBy($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInvitedBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvitedBy() => $_clearField(4);

  @$pb.TagNumber(5)
  $8.Timestamp get joinedAt => $_getN(4);
  @$pb.TagNumber(5)
  set joinedAt($8.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasJoinedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearJoinedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $8.Timestamp ensureJoinedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $8.Timestamp get leftAt => $_getN(5);
  @$pb.TagNumber(6)
  set leftAt($8.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLeftAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLeftAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $8.Timestamp ensureLeftAt() => $_ensure(5);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
