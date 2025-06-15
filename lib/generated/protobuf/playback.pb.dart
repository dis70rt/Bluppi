//
//  Generated code. Do not modify.
//  source: protobuf/playback.proto
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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PlaybackState extends $pb.GeneratedMessage {
  factory PlaybackState({
    $core.String? roomId,
    $core.String? currentTrackId,
    $core.int? positionMs,
    $9.PlaybackStatus? status,
    $8.Timestamp? updatedAt,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (currentTrackId != null) result.currentTrackId = currentTrackId;
    if (positionMs != null) result.positionMs = positionMs;
    if (status != null) result.status = status;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  PlaybackState._();

  factory PlaybackState.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlaybackState.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaybackState', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'currentTrackId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..e<$9.PlaybackStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $9.PlaybackStatus.PLAYING, valueOf: $9.PlaybackStatus.valueOf, enumValues: $9.PlaybackStatus.values)
    ..aOM<$8.Timestamp>(5, _omitFieldNames ? '' : 'updatedAt', subBuilder: $8.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackState clone() => PlaybackState()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackState copyWith(void Function(PlaybackState) updates) => super.copyWith((message) => updates(message as PlaybackState)) as PlaybackState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackState create() => PlaybackState._();
  @$core.override
  PlaybackState createEmptyInstance() => create();
  static $pb.PbList<PlaybackState> createRepeated() => $pb.PbList<PlaybackState>();
  @$core.pragma('dart2js:noInline')
  static PlaybackState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaybackState>(create);
  static PlaybackState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currentTrackId => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentTrackId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentTrackId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentTrackId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get positionMs => $_getIZ(2);
  @$pb.TagNumber(3)
  set positionMs($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPositionMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearPositionMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $9.PlaybackStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status($9.PlaybackStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $8.Timestamp get updatedAt => $_getN(4);
  @$pb.TagNumber(5)
  set updatedAt($8.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $8.Timestamp ensureUpdatedAt() => $_ensure(4);
}

class PlayRequest extends $pb.GeneratedMessage {
  factory PlayRequest({
    $core.String? roomId,
    $core.String? trackId,
    $core.int? positionMs,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (trackId != null) result.trackId = trackId;
    if (positionMs != null) result.positionMs = positionMs;
    return result;
  }

  PlayRequest._();

  factory PlayRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlayRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayRequest clone() => PlayRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlayRequest copyWith(void Function(PlayRequest) updates) => super.copyWith((message) => updates(message as PlayRequest)) as PlayRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayRequest create() => PlayRequest._();
  @$core.override
  PlayRequest createEmptyInstance() => create();
  static $pb.PbList<PlayRequest> createRepeated() => $pb.PbList<PlayRequest>();
  @$core.pragma('dart2js:noInline')
  static PlayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayRequest>(create);
  static PlayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get trackId => $_getSZ(1);
  @$pb.TagNumber(2)
  set trackId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get positionMs => $_getIZ(2);
  @$pb.TagNumber(3)
  set positionMs($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPositionMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearPositionMs() => $_clearField(3);
}

class PauseRequest extends $pb.GeneratedMessage {
  factory PauseRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  PauseRequest._();

  factory PauseRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PauseRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PauseRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseRequest clone() => PauseRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PauseRequest copyWith(void Function(PauseRequest) updates) => super.copyWith((message) => updates(message as PauseRequest)) as PauseRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PauseRequest create() => PauseRequest._();
  @$core.override
  PauseRequest createEmptyInstance() => create();
  static $pb.PbList<PauseRequest> createRepeated() => $pb.PbList<PauseRequest>();
  @$core.pragma('dart2js:noInline')
  static PauseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PauseRequest>(create);
  static PauseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class SeekRequest extends $pb.GeneratedMessage {
  factory SeekRequest({
    $core.String? roomId,
    $core.int? positionMs,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (positionMs != null) result.positionMs = positionMs;
    return result;
  }

  SeekRequest._();

  factory SeekRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SeekRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SeekRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeekRequest clone() => SeekRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SeekRequest copyWith(void Function(SeekRequest) updates) => super.copyWith((message) => updates(message as SeekRequest)) as SeekRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SeekRequest create() => SeekRequest._();
  @$core.override
  SeekRequest createEmptyInstance() => create();
  static $pb.PbList<SeekRequest> createRepeated() => $pb.PbList<SeekRequest>();
  @$core.pragma('dart2js:noInline')
  static SeekRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SeekRequest>(create);
  static SeekRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get positionMs => $_getIZ(1);
  @$pb.TagNumber(2)
  set positionMs($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionMs() => $_clearField(2);
}

class SkipRequest extends $pb.GeneratedMessage {
  factory SkipRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  SkipRequest._();

  factory SkipRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SkipRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SkipRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipRequest clone() => SkipRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipRequest copyWith(void Function(SkipRequest) updates) => super.copyWith((message) => updates(message as SkipRequest)) as SkipRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SkipRequest create() => SkipRequest._();
  @$core.override
  SkipRequest createEmptyInstance() => create();
  static $pb.PbList<SkipRequest> createRepeated() => $pb.PbList<SkipRequest>();
  @$core.pragma('dart2js:noInline')
  static SkipRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SkipRequest>(create);
  static SkipRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class GetPlaybackStateRequest extends $pb.GeneratedMessage {
  factory GetPlaybackStateRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  GetPlaybackStateRequest._();

  factory GetPlaybackStateRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetPlaybackStateRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlaybackStateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPlaybackStateRequest clone() => GetPlaybackStateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPlaybackStateRequest copyWith(void Function(GetPlaybackStateRequest) updates) => super.copyWith((message) => updates(message as GetPlaybackStateRequest)) as GetPlaybackStateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlaybackStateRequest create() => GetPlaybackStateRequest._();
  @$core.override
  GetPlaybackStateRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlaybackStateRequest> createRepeated() => $pb.PbList<GetPlaybackStateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlaybackStateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlaybackStateRequest>(create);
  static GetPlaybackStateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class SyncPlaybackRequest extends $pb.GeneratedMessage {
  factory SyncPlaybackRequest({
    $core.String? roomId,
    $core.String? userId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    return result;
  }

  SyncPlaybackRequest._();

  factory SyncPlaybackRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SyncPlaybackRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncPlaybackRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPlaybackRequest clone() => SyncPlaybackRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPlaybackRequest copyWith(void Function(SyncPlaybackRequest) updates) => super.copyWith((message) => updates(message as SyncPlaybackRequest)) as SyncPlaybackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncPlaybackRequest create() => SyncPlaybackRequest._();
  @$core.override
  SyncPlaybackRequest createEmptyInstance() => create();
  static $pb.PbList<SyncPlaybackRequest> createRepeated() => $pb.PbList<SyncPlaybackRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncPlaybackRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncPlaybackRequest>(create);
  static SyncPlaybackRequest? _defaultInstance;

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
