//
//  Generated code. Do not modify.
//  source: protobuf/streaming.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $8;
import 'common.pbenum.dart' as $9;
import 'playback.pb.dart' as $1;
import 'room.pb.dart' as $4;
import 'track.pb.dart' as $6;
import 'user.pb.dart' as $7;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum RoomStreamUpdate_UpdateType {
  playbackUpdate, 
  memberUpdate, 
  roomSettingsUpdate, 
  roomStatusUpdate, 
  notSet
}

class RoomStreamUpdate extends $pb.GeneratedMessage {
  factory RoomStreamUpdate({
    $core.String? roomId,
    $8.Timestamp? timestamp,
    PlaybackUpdate? playbackUpdate,
    MemberUpdate? memberUpdate,
    RoomSettingsUpdate? roomSettingsUpdate,
    RoomStatusUpdate? roomStatusUpdate,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (timestamp != null) result.timestamp = timestamp;
    if (playbackUpdate != null) result.playbackUpdate = playbackUpdate;
    if (memberUpdate != null) result.memberUpdate = memberUpdate;
    if (roomSettingsUpdate != null) result.roomSettingsUpdate = roomSettingsUpdate;
    if (roomStatusUpdate != null) result.roomStatusUpdate = roomStatusUpdate;
    return result;
  }

  RoomStreamUpdate._();

  factory RoomStreamUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomStreamUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RoomStreamUpdate_UpdateType> _RoomStreamUpdate_UpdateTypeByTag = {
    3 : RoomStreamUpdate_UpdateType.playbackUpdate,
    4 : RoomStreamUpdate_UpdateType.memberUpdate,
    5 : RoomStreamUpdate_UpdateType.roomSettingsUpdate,
    6 : RoomStreamUpdate_UpdateType.roomStatusUpdate,
    0 : RoomStreamUpdate_UpdateType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomStreamUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOM<$8.Timestamp>(2, _omitFieldNames ? '' : 'timestamp', subBuilder: $8.Timestamp.create)
    ..aOM<PlaybackUpdate>(3, _omitFieldNames ? '' : 'playbackUpdate', subBuilder: PlaybackUpdate.create)
    ..aOM<MemberUpdate>(4, _omitFieldNames ? '' : 'memberUpdate', subBuilder: MemberUpdate.create)
    ..aOM<RoomSettingsUpdate>(5, _omitFieldNames ? '' : 'roomSettingsUpdate', subBuilder: RoomSettingsUpdate.create)
    ..aOM<RoomStatusUpdate>(6, _omitFieldNames ? '' : 'roomStatusUpdate', subBuilder: RoomStatusUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomStreamUpdate clone() => RoomStreamUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomStreamUpdate copyWith(void Function(RoomStreamUpdate) updates) => super.copyWith((message) => updates(message as RoomStreamUpdate)) as RoomStreamUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomStreamUpdate create() => RoomStreamUpdate._();
  @$core.override
  RoomStreamUpdate createEmptyInstance() => create();
  static $pb.PbList<RoomStreamUpdate> createRepeated() => $pb.PbList<RoomStreamUpdate>();
  @$core.pragma('dart2js:noInline')
  static RoomStreamUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomStreamUpdate>(create);
  static RoomStreamUpdate? _defaultInstance;

  RoomStreamUpdate_UpdateType whichUpdateType() => _RoomStreamUpdate_UpdateTypeByTag[$_whichOneof(0)]!;
  void clearUpdateType() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $8.Timestamp get timestamp => $_getN(1);
  @$pb.TagNumber(2)
  set timestamp($8.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => $_clearField(2);
  @$pb.TagNumber(2)
  $8.Timestamp ensureTimestamp() => $_ensure(1);

  @$pb.TagNumber(3)
  PlaybackUpdate get playbackUpdate => $_getN(2);
  @$pb.TagNumber(3)
  set playbackUpdate(PlaybackUpdate value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPlaybackUpdate() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlaybackUpdate() => $_clearField(3);
  @$pb.TagNumber(3)
  PlaybackUpdate ensurePlaybackUpdate() => $_ensure(2);

  @$pb.TagNumber(4)
  MemberUpdate get memberUpdate => $_getN(3);
  @$pb.TagNumber(4)
  set memberUpdate(MemberUpdate value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMemberUpdate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMemberUpdate() => $_clearField(4);
  @$pb.TagNumber(4)
  MemberUpdate ensureMemberUpdate() => $_ensure(3);

  @$pb.TagNumber(5)
  RoomSettingsUpdate get roomSettingsUpdate => $_getN(4);
  @$pb.TagNumber(5)
  set roomSettingsUpdate(RoomSettingsUpdate value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasRoomSettingsUpdate() => $_has(4);
  @$pb.TagNumber(5)
  void clearRoomSettingsUpdate() => $_clearField(5);
  @$pb.TagNumber(5)
  RoomSettingsUpdate ensureRoomSettingsUpdate() => $_ensure(4);

  @$pb.TagNumber(6)
  RoomStatusUpdate get roomStatusUpdate => $_getN(5);
  @$pb.TagNumber(6)
  set roomStatusUpdate(RoomStatusUpdate value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasRoomStatusUpdate() => $_has(5);
  @$pb.TagNumber(6)
  void clearRoomStatusUpdate() => $_clearField(6);
  @$pb.TagNumber(6)
  RoomStatusUpdate ensureRoomStatusUpdate() => $_ensure(5);
}

enum PlaybackUpdate_PlaybackEvent {
  trackChange, 
  playState, 
  seek, 
  skip, 
  notSet
}

class PlaybackUpdate extends $pb.GeneratedMessage {
  factory PlaybackUpdate({
    TrackChangeEvent? trackChange,
    PlayStateEvent? playState,
    SeekEvent? seek,
    SkipEvent? skip,
  }) {
    final result = create();
    if (trackChange != null) result.trackChange = trackChange;
    if (playState != null) result.playState = playState;
    if (seek != null) result.seek = seek;
    if (skip != null) result.skip = skip;
    return result;
  }

  PlaybackUpdate._();

  factory PlaybackUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlaybackUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, PlaybackUpdate_PlaybackEvent> _PlaybackUpdate_PlaybackEventByTag = {
    1 : PlaybackUpdate_PlaybackEvent.trackChange,
    2 : PlaybackUpdate_PlaybackEvent.playState,
    3 : PlaybackUpdate_PlaybackEvent.seek,
    4 : PlaybackUpdate_PlaybackEvent.skip,
    0 : PlaybackUpdate_PlaybackEvent.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaybackUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<TrackChangeEvent>(1, _omitFieldNames ? '' : 'trackChange', subBuilder: TrackChangeEvent.create)
    ..aOM<PlayStateEvent>(2, _omitFieldNames ? '' : 'playState', subBuilder: PlayStateEvent.create)
    ..aOM<SeekEvent>(3, _omitFieldNames ? '' : 'seek', subBuilder: SeekEvent.create)
    ..aOM<SkipEvent>(4, _omitFieldNames ? '' : 'skip', subBuilder: SkipEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackUpdate clone() => PlaybackUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackUpdate copyWith(void Function(PlaybackUpdate) updates) => super.copyWith((message) => updates(message as PlaybackUpdate)) as PlaybackUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackUpdate create() => PlaybackUpdate._();
  @$core.override
  PlaybackUpdate createEmptyInstance() => create();
  static $pb.PbList<PlaybackUpdate> createRepeated() => $pb.PbList<PlaybackUpdate>();
  @$core.pragma('dart2js:noInline')
  static PlaybackUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaybackUpdate>(create);
  static PlaybackUpdate? _defaultInstance;

  PlaybackUpdate_PlaybackEvent whichPlaybackEvent() => _PlaybackUpdate_PlaybackEventByTag[$_whichOneof(0)]!;
  void clearPlaybackEvent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  TrackChangeEvent get trackChange => $_getN(0);
  @$pb.TagNumber(1)
  set trackChange(TrackChangeEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackChange() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackChange() => $_clearField(1);
  @$pb.TagNumber(1)
  TrackChangeEvent ensureTrackChange() => $_ensure(0);

  @$pb.TagNumber(2)
  PlayStateEvent get playState => $_getN(1);
  @$pb.TagNumber(2)
  set playState(PlayStateEvent value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPlayState() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlayState() => $_clearField(2);
  @$pb.TagNumber(2)
  PlayStateEvent ensurePlayState() => $_ensure(1);

  @$pb.TagNumber(3)
  SeekEvent get seek => $_getN(2);
  @$pb.TagNumber(3)
  set seek(SeekEvent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSeek() => $_has(2);
  @$pb.TagNumber(3)
  void clearSeek() => $_clearField(3);
  @$pb.TagNumber(3)
  SeekEvent ensureSeek() => $_ensure(2);

  @$pb.TagNumber(4)
  SkipEvent get skip => $_getN(3);
  @$pb.TagNumber(4)
  set skip(SkipEvent value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSkip() => $_has(3);
  @$pb.TagNumber(4)
  void clearSkip() => $_clearField(4);
  @$pb.TagNumber(4)
  SkipEvent ensureSkip() => $_ensure(3);
}

class TrackChangeEvent extends $pb.GeneratedMessage {
  factory TrackChangeEvent({
    $6.Track? currentTrack,
    $core.int? positionMs,
  }) {
    final result = create();
    if (currentTrack != null) result.currentTrack = currentTrack;
    if (positionMs != null) result.positionMs = positionMs;
    return result;
  }

  TrackChangeEvent._();

  factory TrackChangeEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TrackChangeEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TrackChangeEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOM<$6.Track>(1, _omitFieldNames ? '' : 'currentTrack', subBuilder: $6.Track.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackChangeEvent clone() => TrackChangeEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackChangeEvent copyWith(void Function(TrackChangeEvent) updates) => super.copyWith((message) => updates(message as TrackChangeEvent)) as TrackChangeEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackChangeEvent create() => TrackChangeEvent._();
  @$core.override
  TrackChangeEvent createEmptyInstance() => create();
  static $pb.PbList<TrackChangeEvent> createRepeated() => $pb.PbList<TrackChangeEvent>();
  @$core.pragma('dart2js:noInline')
  static TrackChangeEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackChangeEvent>(create);
  static TrackChangeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $6.Track get currentTrack => $_getN(0);
  @$pb.TagNumber(1)
  set currentTrack($6.Track value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  $6.Track ensureCurrentTrack() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get positionMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionMs($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionMs() => $_clearField(2);
}

class PlayStateEvent extends $pb.GeneratedMessage {
  factory PlayStateEvent({
    $9.PlaybackStatus? status,
    $core.int? positionMs,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (positionMs != null) result.positionMs = positionMs;
    return result;
  }

  PlayStateEvent._();

  factory PlayStateEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlayStateEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayStateEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..e<$9.PlaybackStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.PlaybackStatus.PLAYING, valueOf: $9.PlaybackStatus.valueOf, enumValues: $9.PlaybackStatus.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayStateEvent clone() => PlayStateEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayStateEvent copyWith(void Function(PlayStateEvent) updates) => super.copyWith((message) => updates(message as PlayStateEvent)) as PlayStateEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayStateEvent create() => PlayStateEvent._();
  @$core.override
  PlayStateEvent createEmptyInstance() => create();
  static $pb.PbList<PlayStateEvent> createRepeated() => $pb.PbList<PlayStateEvent>();
  @$core.pragma('dart2js:noInline')
  static PlayStateEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayStateEvent>(create);
  static PlayStateEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $9.PlaybackStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status($9.PlaybackStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get positionMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionMs($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionMs() => $_clearField(2);
}

class SeekEvent extends $pb.GeneratedMessage {
  factory SeekEvent({
    $core.int? positionMs,
  }) {
    final result = create();
    if (positionMs != null) result.positionMs = positionMs;
    return result;
  }

  SeekEvent._();

  factory SeekEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SeekEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SeekEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeekEvent clone() => SeekEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeekEvent copyWith(void Function(SeekEvent) updates) => super.copyWith((message) => updates(message as SeekEvent)) as SeekEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeekEvent create() => SeekEvent._();
  @$core.override
  SeekEvent createEmptyInstance() => create();
  static $pb.PbList<SeekEvent> createRepeated() => $pb.PbList<SeekEvent>();
  @$core.pragma('dart2js:noInline')
  static SeekEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeekEvent>(create);
  static SeekEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get positionMs => $_getIZ(0);
  @$pb.TagNumber(1)
  set positionMs($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPositionMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearPositionMs() => $_clearField(1);
}

class SkipEvent extends $pb.GeneratedMessage {
  factory SkipEvent({
    $6.Track? newTrack,
  }) {
    final result = create();
    if (newTrack != null) result.newTrack = newTrack;
    return result;
  }

  SkipEvent._();

  factory SkipEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SkipEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SkipEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOM<$6.Track>(1, _omitFieldNames ? '' : 'newTrack', subBuilder: $6.Track.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipEvent clone() => SkipEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipEvent copyWith(void Function(SkipEvent) updates) => super.copyWith((message) => updates(message as SkipEvent)) as SkipEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SkipEvent create() => SkipEvent._();
  @$core.override
  SkipEvent createEmptyInstance() => create();
  static $pb.PbList<SkipEvent> createRepeated() => $pb.PbList<SkipEvent>();
  @$core.pragma('dart2js:noInline')
  static SkipEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SkipEvent>(create);
  static SkipEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $6.Track get newTrack => $_getN(0);
  @$pb.TagNumber(1)
  set newTrack($6.Track value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasNewTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  $6.Track ensureNewTrack() => $_ensure(0);
}

enum MemberUpdate_MemberEvent {
  memberJoin, 
  memberLeave, 
  roleChange, 
  notSet
}

class MemberUpdate extends $pb.GeneratedMessage {
  factory MemberUpdate({
    MemberJoinEvent? memberJoin,
    MemberLeaveEvent? memberLeave,
    MemberRoleChangeEvent? roleChange,
  }) {
    final result = create();
    if (memberJoin != null) result.memberJoin = memberJoin;
    if (memberLeave != null) result.memberLeave = memberLeave;
    if (roleChange != null) result.roleChange = roleChange;
    return result;
  }

  MemberUpdate._();

  factory MemberUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MemberUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, MemberUpdate_MemberEvent> _MemberUpdate_MemberEventByTag = {
    1 : MemberUpdate_MemberEvent.memberJoin,
    2 : MemberUpdate_MemberEvent.memberLeave,
    3 : MemberUpdate_MemberEvent.roleChange,
    0 : MemberUpdate_MemberEvent.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemberUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<MemberJoinEvent>(1, _omitFieldNames ? '' : 'memberJoin', subBuilder: MemberJoinEvent.create)
    ..aOM<MemberLeaveEvent>(2, _omitFieldNames ? '' : 'memberLeave', subBuilder: MemberLeaveEvent.create)
    ..aOM<MemberRoleChangeEvent>(3, _omitFieldNames ? '' : 'roleChange', subBuilder: MemberRoleChangeEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberUpdate clone() => MemberUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberUpdate copyWith(void Function(MemberUpdate) updates) => super.copyWith((message) => updates(message as MemberUpdate)) as MemberUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberUpdate create() => MemberUpdate._();
  @$core.override
  MemberUpdate createEmptyInstance() => create();
  static $pb.PbList<MemberUpdate> createRepeated() => $pb.PbList<MemberUpdate>();
  @$core.pragma('dart2js:noInline')
  static MemberUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberUpdate>(create);
  static MemberUpdate? _defaultInstance;

  MemberUpdate_MemberEvent whichMemberEvent() => _MemberUpdate_MemberEventByTag[$_whichOneof(0)]!;
  void clearMemberEvent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  MemberJoinEvent get memberJoin => $_getN(0);
  @$pb.TagNumber(1)
  set memberJoin(MemberJoinEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberJoin() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberJoin() => $_clearField(1);
  @$pb.TagNumber(1)
  MemberJoinEvent ensureMemberJoin() => $_ensure(0);

  @$pb.TagNumber(2)
  MemberLeaveEvent get memberLeave => $_getN(1);
  @$pb.TagNumber(2)
  set memberLeave(MemberLeaveEvent value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberLeave() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberLeave() => $_clearField(2);
  @$pb.TagNumber(2)
  MemberLeaveEvent ensureMemberLeave() => $_ensure(1);

  @$pb.TagNumber(3)
  MemberRoleChangeEvent get roleChange => $_getN(2);
  @$pb.TagNumber(3)
  set roleChange(MemberRoleChangeEvent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRoleChange() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoleChange() => $_clearField(3);
  @$pb.TagNumber(3)
  MemberRoleChangeEvent ensureRoleChange() => $_ensure(2);
}

class MemberJoinEvent extends $pb.GeneratedMessage {
  factory MemberJoinEvent({
    $7.User? user,
    $9.RoomMemberRole? role,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (role != null) result.role = role;
    return result;
  }

  MemberJoinEvent._();

  factory MemberJoinEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MemberJoinEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemberJoinEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOM<$7.User>(1, _omitFieldNames ? '' : 'user', subBuilder: $7.User.create)
    ..e<$9.RoomMemberRole>(2, _omitFieldNames ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomMemberRole.HOST, valueOf: $9.RoomMemberRole.valueOf, enumValues: $9.RoomMemberRole.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberJoinEvent clone() => MemberJoinEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberJoinEvent copyWith(void Function(MemberJoinEvent) updates) => super.copyWith((message) => updates(message as MemberJoinEvent)) as MemberJoinEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberJoinEvent create() => MemberJoinEvent._();
  @$core.override
  MemberJoinEvent createEmptyInstance() => create();
  static $pb.PbList<MemberJoinEvent> createRepeated() => $pb.PbList<MemberJoinEvent>();
  @$core.pragma('dart2js:noInline')
  static MemberJoinEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberJoinEvent>(create);
  static MemberJoinEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $7.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($7.User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  $7.User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $9.RoomMemberRole get role => $_getN(1);
  @$pb.TagNumber(2)
  set role($9.RoomMemberRole value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);
}

class MemberLeaveEvent extends $pb.GeneratedMessage {
  factory MemberLeaveEvent({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  MemberLeaveEvent._();

  factory MemberLeaveEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MemberLeaveEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemberLeaveEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberLeaveEvent clone() => MemberLeaveEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberLeaveEvent copyWith(void Function(MemberLeaveEvent) updates) => super.copyWith((message) => updates(message as MemberLeaveEvent)) as MemberLeaveEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberLeaveEvent create() => MemberLeaveEvent._();
  @$core.override
  MemberLeaveEvent createEmptyInstance() => create();
  static $pb.PbList<MemberLeaveEvent> createRepeated() => $pb.PbList<MemberLeaveEvent>();
  @$core.pragma('dart2js:noInline')
  static MemberLeaveEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberLeaveEvent>(create);
  static MemberLeaveEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class MemberRoleChangeEvent extends $pb.GeneratedMessage {
  factory MemberRoleChangeEvent({
    $core.String? userId,
    $9.RoomMemberRole? newRole,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (newRole != null) result.newRole = newRole;
    return result;
  }

  MemberRoleChangeEvent._();

  factory MemberRoleChangeEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MemberRoleChangeEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemberRoleChangeEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<$9.RoomMemberRole>(2, _omitFieldNames ? '' : 'newRole', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomMemberRole.HOST, valueOf: $9.RoomMemberRole.valueOf, enumValues: $9.RoomMemberRole.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberRoleChangeEvent clone() => MemberRoleChangeEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberRoleChangeEvent copyWith(void Function(MemberRoleChangeEvent) updates) => super.copyWith((message) => updates(message as MemberRoleChangeEvent)) as MemberRoleChangeEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberRoleChangeEvent create() => MemberRoleChangeEvent._();
  @$core.override
  MemberRoleChangeEvent createEmptyInstance() => create();
  static $pb.PbList<MemberRoleChangeEvent> createRepeated() => $pb.PbList<MemberRoleChangeEvent>();
  @$core.pragma('dart2js:noInline')
  static MemberRoleChangeEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberRoleChangeEvent>(create);
  static MemberRoleChangeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $9.RoomMemberRole get newRole => $_getN(1);
  @$pb.TagNumber(2)
  set newRole($9.RoomMemberRole value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNewRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewRole() => $_clearField(2);
}

class RoomSettingsUpdate extends $pb.GeneratedMessage {
  factory RoomSettingsUpdate({
    $core.String? name,
    $core.String? description,
    $9.RoomVisibility? visibility,
    $core.bool? inviteOnly,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (visibility != null) result.visibility = visibility;
    if (inviteOnly != null) result.inviteOnly = inviteOnly;
    return result;
  }

  RoomSettingsUpdate._();

  factory RoomSettingsUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomSettingsUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomSettingsUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..e<$9.RoomVisibility>(3, _omitFieldNames ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomVisibility.PUBLIC, valueOf: $9.RoomVisibility.valueOf, enumValues: $9.RoomVisibility.values)
    ..aOB(4, _omitFieldNames ? '' : 'inviteOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomSettingsUpdate clone() => RoomSettingsUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomSettingsUpdate copyWith(void Function(RoomSettingsUpdate) updates) => super.copyWith((message) => updates(message as RoomSettingsUpdate)) as RoomSettingsUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomSettingsUpdate create() => RoomSettingsUpdate._();
  @$core.override
  RoomSettingsUpdate createEmptyInstance() => create();
  static $pb.PbList<RoomSettingsUpdate> createRepeated() => $pb.PbList<RoomSettingsUpdate>();
  @$core.pragma('dart2js:noInline')
  static RoomSettingsUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomSettingsUpdate>(create);
  static RoomSettingsUpdate? _defaultInstance;

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
  $9.RoomVisibility get visibility => $_getN(2);
  @$pb.TagNumber(3)
  set visibility($9.RoomVisibility value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasVisibility() => $_has(2);
  @$pb.TagNumber(3)
  void clearVisibility() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get inviteOnly => $_getBF(3);
  @$pb.TagNumber(4)
  set inviteOnly($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInviteOnly() => $_has(3);
  @$pb.TagNumber(4)
  void clearInviteOnly() => $_clearField(4);
}

class RoomStatusUpdate extends $pb.GeneratedMessage {
  factory RoomStatusUpdate({
    $9.RoomStatus? status,
    $core.String? reason,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (reason != null) result.reason = reason;
    return result;
  }

  RoomStatusUpdate._();

  factory RoomStatusUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomStatusUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomStatusUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..e<$9.RoomStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.RoomStatus.ACTIVE, valueOf: $9.RoomStatus.valueOf, enumValues: $9.RoomStatus.values)
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomStatusUpdate clone() => RoomStatusUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomStatusUpdate copyWith(void Function(RoomStatusUpdate) updates) => super.copyWith((message) => updates(message as RoomStatusUpdate)) as RoomStatusUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomStatusUpdate create() => RoomStatusUpdate._();
  @$core.override
  RoomStatusUpdate createEmptyInstance() => create();
  static $pb.PbList<RoomStatusUpdate> createRepeated() => $pb.PbList<RoomStatusUpdate>();
  @$core.pragma('dart2js:noInline')
  static RoomStatusUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomStatusUpdate>(create);
  static RoomStatusUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $9.RoomStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status($9.RoomStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class JoinRoomStreamRequest extends $pb.GeneratedMessage {
  factory JoinRoomStreamRequest({
    $core.String? roomId,
    $core.String? userId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    return result;
  }

  JoinRoomStreamRequest._();

  factory JoinRoomStreamRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory JoinRoomStreamRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinRoomStreamRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRoomStreamRequest clone() => JoinRoomStreamRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinRoomStreamRequest copyWith(void Function(JoinRoomStreamRequest) updates) => super.copyWith((message) => updates(message as JoinRoomStreamRequest)) as JoinRoomStreamRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinRoomStreamRequest create() => JoinRoomStreamRequest._();
  @$core.override
  JoinRoomStreamRequest createEmptyInstance() => create();
  static $pb.PbList<JoinRoomStreamRequest> createRepeated() => $pb.PbList<JoinRoomStreamRequest>();
  @$core.pragma('dart2js:noInline')
  static JoinRoomStreamRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinRoomStreamRequest>(create);
  static JoinRoomStreamRequest? _defaultInstance;

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

class RoomStreamSnapshot extends $pb.GeneratedMessage {
  factory RoomStreamSnapshot({
    $4.Room? roomInfo,
    $1.PlaybackState? currentPlayback,
    $6.Track? currentTrack,
    $core.Iterable<$7.User>? members,
    $core.int? memberCount,
  }) {
    final result = create();
    if (roomInfo != null) result.roomInfo = roomInfo;
    if (currentPlayback != null) result.currentPlayback = currentPlayback;
    if (currentTrack != null) result.currentTrack = currentTrack;
    if (members != null) result.members.addAll(members);
    if (memberCount != null) result.memberCount = memberCount;
    return result;
  }

  RoomStreamSnapshot._();

  factory RoomStreamSnapshot.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomStreamSnapshot.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomStreamSnapshot', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOM<$4.Room>(1, _omitFieldNames ? '' : 'roomInfo', subBuilder: $4.Room.create)
    ..aOM<$1.PlaybackState>(2, _omitFieldNames ? '' : 'currentPlayback', subBuilder: $1.PlaybackState.create)
    ..aOM<$6.Track>(3, _omitFieldNames ? '' : 'currentTrack', subBuilder: $6.Track.create)
    ..pc<$7.User>(4, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM, subBuilder: $7.User.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'memberCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomStreamSnapshot clone() => RoomStreamSnapshot()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomStreamSnapshot copyWith(void Function(RoomStreamSnapshot) updates) => super.copyWith((message) => updates(message as RoomStreamSnapshot)) as RoomStreamSnapshot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomStreamSnapshot create() => RoomStreamSnapshot._();
  @$core.override
  RoomStreamSnapshot createEmptyInstance() => create();
  static $pb.PbList<RoomStreamSnapshot> createRepeated() => $pb.PbList<RoomStreamSnapshot>();
  @$core.pragma('dart2js:noInline')
  static RoomStreamSnapshot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomStreamSnapshot>(create);
  static RoomStreamSnapshot? _defaultInstance;

  @$pb.TagNumber(1)
  $4.Room get roomInfo => $_getN(0);
  @$pb.TagNumber(1)
  set roomInfo($4.Room value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  $4.Room ensureRoomInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.PlaybackState get currentPlayback => $_getN(1);
  @$pb.TagNumber(2)
  set currentPlayback($1.PlaybackState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentPlayback() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPlayback() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PlaybackState ensureCurrentPlayback() => $_ensure(1);

  @$pb.TagNumber(3)
  $6.Track get currentTrack => $_getN(2);
  @$pb.TagNumber(3)
  set currentTrack($6.Track value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentTrack() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTrack() => $_clearField(3);
  @$pb.TagNumber(3)
  $6.Track ensureCurrentTrack() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<$7.User> get members => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get memberCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set memberCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMemberCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMemberCount() => $_clearField(5);
}

class StreamRoomUpdatesRequest extends $pb.GeneratedMessage {
  factory StreamRoomUpdatesRequest({
    $core.String? roomId,
    $core.String? userId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    return result;
  }

  StreamRoomUpdatesRequest._();

  factory StreamRoomUpdatesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StreamRoomUpdatesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamRoomUpdatesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamRoomUpdatesRequest clone() => StreamRoomUpdatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamRoomUpdatesRequest copyWith(void Function(StreamRoomUpdatesRequest) updates) => super.copyWith((message) => updates(message as StreamRoomUpdatesRequest)) as StreamRoomUpdatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamRoomUpdatesRequest create() => StreamRoomUpdatesRequest._();
  @$core.override
  StreamRoomUpdatesRequest createEmptyInstance() => create();
  static $pb.PbList<StreamRoomUpdatesRequest> createRepeated() => $pb.PbList<StreamRoomUpdatesRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamRoomUpdatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamRoomUpdatesRequest>(create);
  static StreamRoomUpdatesRequest? _defaultInstance;

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


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
