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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $9;
import 'streaming.pbenum.dart';
import 'track.pb.dart' as $6;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'streaming.pbenum.dart';

class SyncMeasurement extends $pb.GeneratedMessage {
  factory SyncMeasurement({
    $fixnum.Int64? clientSendMs,
    $fixnum.Int64? serverReceiveMs,
    $fixnum.Int64? serverSendMs,
    $fixnum.Int64? clientReceiveMs,
    $core.String? clientId,
  }) {
    final result = create();
    if (clientSendMs != null) result.clientSendMs = clientSendMs;
    if (serverReceiveMs != null) result.serverReceiveMs = serverReceiveMs;
    if (serverSendMs != null) result.serverSendMs = serverSendMs;
    if (clientReceiveMs != null) result.clientReceiveMs = clientReceiveMs;
    if (clientId != null) result.clientId = clientId;
    return result;
  }

  SyncMeasurement._();

  factory SyncMeasurement.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SyncMeasurement.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncMeasurement', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'clientSendMs')
    ..aInt64(2, _omitFieldNames ? '' : 'serverReceiveMs')
    ..aInt64(3, _omitFieldNames ? '' : 'serverSendMs')
    ..aInt64(4, _omitFieldNames ? '' : 'clientReceiveMs')
    ..aOS(5, _omitFieldNames ? '' : 'clientId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncMeasurement clone() => SyncMeasurement()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncMeasurement copyWith(void Function(SyncMeasurement) updates) => super.copyWith((message) => updates(message as SyncMeasurement)) as SyncMeasurement;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncMeasurement create() => SyncMeasurement._();
  @$core.override
  SyncMeasurement createEmptyInstance() => create();
  static $pb.PbList<SyncMeasurement> createRepeated() => $pb.PbList<SyncMeasurement>();
  @$core.pragma('dart2js:noInline')
  static SyncMeasurement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncMeasurement>(create);
  static SyncMeasurement? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get clientSendMs => $_getI64(0);
  @$pb.TagNumber(1)
  set clientSendMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientSendMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientSendMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get serverReceiveMs => $_getI64(1);
  @$pb.TagNumber(2)
  set serverReceiveMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerReceiveMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerReceiveMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get serverSendMs => $_getI64(2);
  @$pb.TagNumber(3)
  set serverSendMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServerSendMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerSendMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get clientReceiveMs => $_getI64(3);
  @$pb.TagNumber(4)
  set clientReceiveMs($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasClientReceiveMs() => $_has(3);
  @$pb.TagNumber(4)
  void clearClientReceiveMs() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get clientId => $_getSZ(4);
  @$pb.TagNumber(5)
  set clientId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasClientId() => $_has(4);
  @$pb.TagNumber(5)
  void clearClientId() => $_clearField(5);
}

class SyncResponse extends $pb.GeneratedMessage {
  factory SyncResponse({
    $fixnum.Int64? serverTimestampMs,
    $core.double? recommendedAdjustment,
    $core.int? estimatedOffsetMs,
  }) {
    final result = create();
    if (serverTimestampMs != null) result.serverTimestampMs = serverTimestampMs;
    if (recommendedAdjustment != null) result.recommendedAdjustment = recommendedAdjustment;
    if (estimatedOffsetMs != null) result.estimatedOffsetMs = estimatedOffsetMs;
    return result;
  }

  SyncResponse._();

  factory SyncResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SyncResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'serverTimestampMs')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'recommendedAdjustment', $pb.PbFieldType.OF)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'estimatedOffsetMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncResponse clone() => SyncResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncResponse copyWith(void Function(SyncResponse) updates) => super.copyWith((message) => updates(message as SyncResponse)) as SyncResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncResponse create() => SyncResponse._();
  @$core.override
  SyncResponse createEmptyInstance() => create();
  static $pb.PbList<SyncResponse> createRepeated() => $pb.PbList<SyncResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncResponse>(create);
  static SyncResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serverTimestampMs => $_getI64(0);
  @$pb.TagNumber(1)
  set serverTimestampMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServerTimestampMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearServerTimestampMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get recommendedAdjustment => $_getN(1);
  @$pb.TagNumber(2)
  set recommendedAdjustment($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecommendedAdjustment() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecommendedAdjustment() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get estimatedOffsetMs => $_getIZ(2);
  @$pb.TagNumber(3)
  set estimatedOffsetMs($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEstimatedOffsetMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearEstimatedOffsetMs() => $_clearField(3);
}

class PlaybackCommand extends $pb.GeneratedMessage {
  factory PlaybackCommand({
    PlaybackCommand_CommandType? type,
    $fixnum.Int64? serverTimestampMs,
    $fixnum.Int64? positionMs,
    $6.Track? track,
    $core.double? playbackRate,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (serverTimestampMs != null) result.serverTimestampMs = serverTimestampMs;
    if (positionMs != null) result.positionMs = positionMs;
    if (track != null) result.track = track;
    if (playbackRate != null) result.playbackRate = playbackRate;
    return result;
  }

  PlaybackCommand._();

  factory PlaybackCommand.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlaybackCommand.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaybackCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..e<PlaybackCommand_CommandType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: PlaybackCommand_CommandType.PLAY, valueOf: PlaybackCommand_CommandType.valueOf, enumValues: PlaybackCommand_CommandType.values)
    ..aInt64(2, _omitFieldNames ? '' : 'serverTimestampMs')
    ..aInt64(3, _omitFieldNames ? '' : 'positionMs')
    ..aOM<$6.Track>(4, _omitFieldNames ? '' : 'track', subBuilder: $6.Track.create)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'playbackRate', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackCommand clone() => PlaybackCommand()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackCommand copyWith(void Function(PlaybackCommand) updates) => super.copyWith((message) => updates(message as PlaybackCommand)) as PlaybackCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackCommand create() => PlaybackCommand._();
  @$core.override
  PlaybackCommand createEmptyInstance() => create();
  static $pb.PbList<PlaybackCommand> createRepeated() => $pb.PbList<PlaybackCommand>();
  @$core.pragma('dart2js:noInline')
  static PlaybackCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaybackCommand>(create);
  static PlaybackCommand? _defaultInstance;

  @$pb.TagNumber(1)
  PlaybackCommand_CommandType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(PlaybackCommand_CommandType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get serverTimestampMs => $_getI64(1);
  @$pb.TagNumber(2)
  set serverTimestampMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerTimestampMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerTimestampMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get positionMs => $_getI64(2);
  @$pb.TagNumber(3)
  set positionMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPositionMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearPositionMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $6.Track get track => $_getN(3);
  @$pb.TagNumber(4)
  set track($6.Track value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTrack() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrack() => $_clearField(4);
  @$pb.TagNumber(4)
  $6.Track ensureTrack() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.double get playbackRate => $_getN(4);
  @$pb.TagNumber(5)
  set playbackRate($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPlaybackRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearPlaybackRate() => $_clearField(5);
}

class ClientState extends $pb.GeneratedMessage {
  factory ClientState({
    $fixnum.Int64? clientTimestampMs,
    $fixnum.Int64? playbackPositionMs,
    $core.String? currentTrackId,
    $9.PlaybackStatus? status,
    $core.double? currentPlaybackRate,
    $core.int? bufferHealthMs,
  }) {
    final result = create();
    if (clientTimestampMs != null) result.clientTimestampMs = clientTimestampMs;
    if (playbackPositionMs != null) result.playbackPositionMs = playbackPositionMs;
    if (currentTrackId != null) result.currentTrackId = currentTrackId;
    if (status != null) result.status = status;
    if (currentPlaybackRate != null) result.currentPlaybackRate = currentPlaybackRate;
    if (bufferHealthMs != null) result.bufferHealthMs = bufferHealthMs;
    return result;
  }

  ClientState._();

  factory ClientState.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ClientState.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientState', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'clientTimestampMs')
    ..aInt64(2, _omitFieldNames ? '' : 'playbackPositionMs')
    ..aOS(3, _omitFieldNames ? '' : 'currentTrackId')
    ..e<$9.PlaybackStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.PlaybackStatus.PLAYING, valueOf: $9.PlaybackStatus.valueOf, enumValues: $9.PlaybackStatus.values)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'currentPlaybackRate', $pb.PbFieldType.OF)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'bufferHealthMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClientState clone() => ClientState()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClientState copyWith(void Function(ClientState) updates) => super.copyWith((message) => updates(message as ClientState)) as ClientState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientState create() => ClientState._();
  @$core.override
  ClientState createEmptyInstance() => create();
  static $pb.PbList<ClientState> createRepeated() => $pb.PbList<ClientState>();
  @$core.pragma('dart2js:noInline')
  static ClientState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientState>(create);
  static ClientState? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get clientTimestampMs => $_getI64(0);
  @$pb.TagNumber(1)
  set clientTimestampMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientTimestampMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientTimestampMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get playbackPositionMs => $_getI64(1);
  @$pb.TagNumber(2)
  set playbackPositionMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPlaybackPositionMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlaybackPositionMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currentTrackId => $_getSZ(2);
  @$pb.TagNumber(3)
  set currentTrackId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentTrackId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTrackId() => $_clearField(3);

  @$pb.TagNumber(4)
  $9.PlaybackStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status($9.PlaybackStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentPlaybackRate => $_getN(4);
  @$pb.TagNumber(5)
  set currentPlaybackRate($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentPlaybackRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentPlaybackRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get bufferHealthMs => $_getIZ(5);
  @$pb.TagNumber(6)
  set bufferHealthMs($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBufferHealthMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearBufferHealthMs() => $_clearField(6);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
