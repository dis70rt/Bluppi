// This is a generated file - do not edit.
//
// Generated from playback.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum ClientCommand_Payload { play, pause, trackChange, bufferReady, notSet }

class ClientCommand extends $pb.GeneratedMessage {
  factory ClientCommand({
    $core.String? roomId,
    $core.String? userId,
    PlayCommand? play,
    PauseCommand? pause,
    TrackChangeCommand? trackChange,
    BufferReady? bufferReady,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (play != null) result.play = play;
    if (pause != null) result.pause = pause;
    if (trackChange != null) result.trackChange = trackChange;
    if (bufferReady != null) result.bufferReady = bufferReady;
    return result;
  }

  ClientCommand._();

  factory ClientCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClientCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ClientCommand_Payload>
      _ClientCommand_PayloadByTag = {
    3: ClientCommand_Payload.play,
    4: ClientCommand_Payload.pause,
    5: ClientCommand_Payload.trackChange,
    6: ClientCommand_Payload.bufferReady,
    0: ClientCommand_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClientCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOM<PlayCommand>(3, _omitFieldNames ? '' : 'play',
        subBuilder: PlayCommand.create)
    ..aOM<PauseCommand>(4, _omitFieldNames ? '' : 'pause',
        subBuilder: PauseCommand.create)
    ..aOM<TrackChangeCommand>(5, _omitFieldNames ? '' : 'trackChange',
        subBuilder: TrackChangeCommand.create)
    ..aOM<BufferReady>(6, _omitFieldNames ? '' : 'bufferReady',
        subBuilder: BufferReady.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClientCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClientCommand copyWith(void Function(ClientCommand) updates) =>
      super.copyWith((message) => updates(message as ClientCommand))
          as ClientCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientCommand create() => ClientCommand._();
  @$core.override
  ClientCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ClientCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClientCommand>(create);
  static ClientCommand? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  ClientCommand_Payload whichPayload() =>
      _ClientCommand_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  void clearPayload() => $_clearField($_whichOneof(0));

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
  PlayCommand get play => $_getN(2);
  @$pb.TagNumber(3)
  set play(PlayCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPlay() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlay() => $_clearField(3);
  @$pb.TagNumber(3)
  PlayCommand ensurePlay() => $_ensure(2);

  @$pb.TagNumber(4)
  PauseCommand get pause => $_getN(3);
  @$pb.TagNumber(4)
  set pause(PauseCommand value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPause() => $_has(3);
  @$pb.TagNumber(4)
  void clearPause() => $_clearField(4);
  @$pb.TagNumber(4)
  PauseCommand ensurePause() => $_ensure(3);

  @$pb.TagNumber(5)
  TrackChangeCommand get trackChange => $_getN(4);
  @$pb.TagNumber(5)
  set trackChange(TrackChangeCommand value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTrackChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearTrackChange() => $_clearField(5);
  @$pb.TagNumber(5)
  TrackChangeCommand ensureTrackChange() => $_ensure(4);

  @$pb.TagNumber(6)
  BufferReady get bufferReady => $_getN(5);
  @$pb.TagNumber(6)
  set bufferReady(BufferReady value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasBufferReady() => $_has(5);
  @$pb.TagNumber(6)
  void clearBufferReady() => $_clearField(6);
  @$pb.TagNumber(6)
  BufferReady ensureBufferReady() => $_ensure(5);
}

class PlayCommand extends $pb.GeneratedMessage {
  factory PlayCommand() => create();

  PlayCommand._();

  factory PlayCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlayCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlayCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayCommand copyWith(void Function(PlayCommand) updates) =>
      super.copyWith((message) => updates(message as PlayCommand))
          as PlayCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayCommand create() => PlayCommand._();
  @$core.override
  PlayCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlayCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlayCommand>(create);
  static PlayCommand? _defaultInstance;
}

class PauseCommand extends $pb.GeneratedMessage {
  factory PauseCommand() => create();

  PauseCommand._();

  factory PauseCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PauseCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PauseCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseCommand copyWith(void Function(PauseCommand) updates) =>
      super.copyWith((message) => updates(message as PauseCommand))
          as PauseCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseCommand create() => PauseCommand._();
  @$core.override
  PauseCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PauseCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PauseCommand>(create);
  static PauseCommand? _defaultInstance;
}

class TrackChangeCommand extends $pb.GeneratedMessage {
  factory TrackChangeCommand({
    $core.String? trackId,
    $core.String? title,
    $core.String? artist,
    $core.String? audioUrl,
    $core.String? artworkUrl,
    $fixnum.Int64? durationMs,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (audioUrl != null) result.audioUrl = audioUrl;
    if (artworkUrl != null) result.artworkUrl = artworkUrl;
    if (durationMs != null) result.durationMs = durationMs;
    return result;
  }

  TrackChangeCommand._();

  factory TrackChangeCommand.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackChangeCommand.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackChangeCommand',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aOS(4, _omitFieldNames ? '' : 'audioUrl')
    ..aOS(5, _omitFieldNames ? '' : 'artworkUrl')
    ..aInt64(6, _omitFieldNames ? '' : 'durationMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackChangeCommand clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackChangeCommand copyWith(void Function(TrackChangeCommand) updates) =>
      super.copyWith((message) => updates(message as TrackChangeCommand))
          as TrackChangeCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackChangeCommand create() => TrackChangeCommand._();
  @$core.override
  TrackChangeCommand createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackChangeCommand getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackChangeCommand>(create);
  static TrackChangeCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get audioUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set audioUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAudioUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAudioUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get artworkUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set artworkUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasArtworkUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearArtworkUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get durationMs => $_getI64(5);
  @$pb.TagNumber(6)
  set durationMs($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDurationMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearDurationMs() => $_clearField(6);
}

class BufferReady extends $pb.GeneratedMessage {
  factory BufferReady({
    $fixnum.Int64? version,
  }) {
    final result = create();
    if (version != null) result.version = version;
    return result;
  }

  BufferReady._();

  factory BufferReady.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BufferReady.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BufferReady',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BufferReady clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BufferReady copyWith(void Function(BufferReady) updates) =>
      super.copyWith((message) => updates(message as BufferReady))
          as BufferReady;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BufferReady create() => BufferReady._();
  @$core.override
  BufferReady createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static BufferReady getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BufferReady>(create);
  static BufferReady? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get version => $_getI64(0);
  @$pb.TagNumber(1)
  set version($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
}

enum ServerEvent_Payload { playbackState, roomClosed, notSet }

/// --- SERVER -> CLIENT ---
class ServerEvent extends $pb.GeneratedMessage {
  factory ServerEvent({
    PlaybackState? playbackState,
    RoomClosed? roomClosed,
  }) {
    final result = create();
    if (playbackState != null) result.playbackState = playbackState;
    if (roomClosed != null) result.roomClosed = roomClosed;
    return result;
  }

  ServerEvent._();

  factory ServerEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ServerEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ServerEvent_Payload>
      _ServerEvent_PayloadByTag = {
    1: ServerEvent_Payload.playbackState,
    2: ServerEvent_Payload.roomClosed,
    0: ServerEvent_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServerEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<PlaybackState>(1, _omitFieldNames ? '' : 'playbackState',
        subBuilder: PlaybackState.create)
    ..aOM<RoomClosed>(2, _omitFieldNames ? '' : 'roomClosed',
        subBuilder: RoomClosed.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerEvent copyWith(void Function(ServerEvent) updates) =>
      super.copyWith((message) => updates(message as ServerEvent))
          as ServerEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerEvent create() => ServerEvent._();
  @$core.override
  ServerEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ServerEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServerEvent>(create);
  static ServerEvent? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  ServerEvent_Payload whichPayload() =>
      _ServerEvent_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PlaybackState get playbackState => $_getN(0);
  @$pb.TagNumber(1)
  set playbackState(PlaybackState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPlaybackState() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlaybackState() => $_clearField(1);
  @$pb.TagNumber(1)
  PlaybackState ensurePlaybackState() => $_ensure(0);

  @$pb.TagNumber(2)
  RoomClosed get roomClosed => $_getN(1);
  @$pb.TagNumber(2)
  set roomClosed(RoomClosed value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRoomClosed() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomClosed() => $_clearField(2);
  @$pb.TagNumber(2)
  RoomClosed ensureRoomClosed() => $_ensure(1);
}

class RoomClosed extends $pb.GeneratedMessage {
  factory RoomClosed() => create();

  RoomClosed._();

  factory RoomClosed.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RoomClosed.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RoomClosed',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomClosed clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomClosed copyWith(void Function(RoomClosed) updates) =>
      super.copyWith((message) => updates(message as RoomClosed)) as RoomClosed;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomClosed create() => RoomClosed._();
  @$core.override
  RoomClosed createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RoomClosed getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RoomClosed>(create);
  static RoomClosed? _defaultInstance;
}

class PlaybackState extends $pb.GeneratedMessage {
  factory PlaybackState({
    TrackInfo? track,
    $core.bool? isPlaying,
    $fixnum.Int64? positionMs,
    $fixnum.Int64? lastUpdateServerUs,
    $fixnum.Int64? scheduledStartServerUs,
    $fixnum.Int64? version,
  }) {
    final result = create();
    if (track != null) result.track = track;
    if (isPlaying != null) result.isPlaying = isPlaying;
    if (positionMs != null) result.positionMs = positionMs;
    if (lastUpdateServerUs != null)
      result.lastUpdateServerUs = lastUpdateServerUs;
    if (scheduledStartServerUs != null)
      result.scheduledStartServerUs = scheduledStartServerUs;
    if (version != null) result.version = version;
    return result;
  }

  PlaybackState._();

  factory PlaybackState.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlaybackState.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlaybackState',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..aOM<TrackInfo>(1, _omitFieldNames ? '' : 'track',
        subBuilder: TrackInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'isPlaying')
    ..aInt64(3, _omitFieldNames ? '' : 'positionMs')
    ..aInt64(4, _omitFieldNames ? '' : 'lastUpdateServerUs')
    ..aInt64(5, _omitFieldNames ? '' : 'scheduledStartServerUs')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackState clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackState copyWith(void Function(PlaybackState) updates) =>
      super.copyWith((message) => updates(message as PlaybackState))
          as PlaybackState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackState create() => PlaybackState._();
  @$core.override
  PlaybackState createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PlaybackState getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlaybackState>(create);
  static PlaybackState? _defaultInstance;

  @$pb.TagNumber(1)
  TrackInfo get track => $_getN(0);
  @$pb.TagNumber(1)
  set track(TrackInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  TrackInfo ensureTrack() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get isPlaying => $_getBF(1);
  @$pb.TagNumber(2)
  set isPlaying($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsPlaying() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsPlaying() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get positionMs => $_getI64(2);
  @$pb.TagNumber(3)
  set positionMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPositionMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearPositionMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get lastUpdateServerUs => $_getI64(3);
  @$pb.TagNumber(4)
  set lastUpdateServerUs($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastUpdateServerUs() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastUpdateServerUs() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get scheduledStartServerUs => $_getI64(4);
  @$pb.TagNumber(5)
  set scheduledStartServerUs($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasScheduledStartServerUs() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduledStartServerUs() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get version => $_getI64(5);
  @$pb.TagNumber(6)
  set version($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);
}

class TrackInfo extends $pb.GeneratedMessage {
  factory TrackInfo({
    $core.String? trackId,
    $core.String? title,
    $core.String? artist,
    $core.String? audioUrl,
    $core.String? artworkUrl,
    $fixnum.Int64? durationMs,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (audioUrl != null) result.audioUrl = audioUrl;
    if (artworkUrl != null) result.artworkUrl = artworkUrl;
    if (durationMs != null) result.durationMs = durationMs;
    return result;
  }

  TrackInfo._();

  factory TrackInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'playback'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aOS(4, _omitFieldNames ? '' : 'audioUrl')
    ..aOS(5, _omitFieldNames ? '' : 'artworkUrl')
    ..aInt64(6, _omitFieldNames ? '' : 'durationMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackInfo copyWith(void Function(TrackInfo) updates) =>
      super.copyWith((message) => updates(message as TrackInfo)) as TrackInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackInfo create() => TrackInfo._();
  @$core.override
  TrackInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackInfo>(create);
  static TrackInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get audioUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set audioUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAudioUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearAudioUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get artworkUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set artworkUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasArtworkUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearArtworkUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get durationMs => $_getI64(5);
  @$pb.TagNumber(6)
  set durationMs($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDurationMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearDurationMs() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
