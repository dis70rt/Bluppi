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

import 'streaming.pbenum.dart';
import 'track.pb.dart' as $6;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'streaming.pbenum.dart';

class SyncRequest extends $pb.GeneratedMessage {
  factory SyncRequest({
    $fixnum.Int64? clientSendMs,
  }) {
    final result = create();
    if (clientSendMs != null) result.clientSendMs = clientSendMs;
    return result;
  }

  SyncRequest._();

  factory SyncRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SyncRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'clientSendMs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncRequest clone() => SyncRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncRequest copyWith(void Function(SyncRequest) updates) => super.copyWith((message) => updates(message as SyncRequest)) as SyncRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncRequest create() => SyncRequest._();
  @$core.override
  SyncRequest createEmptyInstance() => create();
  static $pb.PbList<SyncRequest> createRepeated() => $pb.PbList<SyncRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncRequest>(create);
  static SyncRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get clientSendMs => $_getI64(0);
  @$pb.TagNumber(1)
  set clientSendMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientSendMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientSendMs() => $_clearField(1);
}

class SyncReply extends $pb.GeneratedMessage {
  factory SyncReply({
    $fixnum.Int64? serverReceiveMs,
    $fixnum.Int64? serverSendMs,
  }) {
    final result = create();
    if (serverReceiveMs != null) result.serverReceiveMs = serverReceiveMs;
    if (serverSendMs != null) result.serverSendMs = serverSendMs;
    return result;
  }

  SyncReply._();

  factory SyncReply.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SyncReply.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncReply', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'serverReceiveMs')
    ..aInt64(2, _omitFieldNames ? '' : 'serverSendMs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncReply clone() => SyncReply()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncReply copyWith(void Function(SyncReply) updates) => super.copyWith((message) => updates(message as SyncReply)) as SyncReply;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncReply create() => SyncReply._();
  @$core.override
  SyncReply createEmptyInstance() => create();
  static $pb.PbList<SyncReply> createRepeated() => $pb.PbList<SyncReply>();
  @$core.pragma('dart2js:noInline')
  static SyncReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncReply>(create);
  static SyncReply? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serverReceiveMs => $_getI64(0);
  @$pb.TagNumber(1)
  set serverReceiveMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServerReceiveMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearServerReceiveMs() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get serverSendMs => $_getI64(1);
  @$pb.TagNumber(2)
  set serverSendMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasServerSendMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearServerSendMs() => $_clearField(2);
}

/// Host Playback
class HostTrackCommand extends $pb.GeneratedMessage {
  factory HostTrackCommand({
    $core.String? roomId,
    $6.Track? track,
    $fixnum.Int64? startAtServerMs,
    $fixnum.Int64? startPosition,
    $core.String? hostUserId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (track != null) result.track = track;
    if (startAtServerMs != null) result.startAtServerMs = startAtServerMs;
    if (startPosition != null) result.startPosition = startPosition;
    if (hostUserId != null) result.hostUserId = hostUserId;
    return result;
  }

  HostTrackCommand._();

  factory HostTrackCommand.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory HostTrackCommand.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HostTrackCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOM<$6.Track>(2, _omitFieldNames ? '' : 'track', subBuilder: $6.Track.create)
    ..aInt64(3, _omitFieldNames ? '' : 'startAtServerMs')
    ..aInt64(4, _omitFieldNames ? '' : 'startPosition')
    ..aOS(6, _omitFieldNames ? '' : 'hostUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostTrackCommand clone() => HostTrackCommand()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostTrackCommand copyWith(void Function(HostTrackCommand) updates) => super.copyWith((message) => updates(message as HostTrackCommand)) as HostTrackCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HostTrackCommand create() => HostTrackCommand._();
  @$core.override
  HostTrackCommand createEmptyInstance() => create();
  static $pb.PbList<HostTrackCommand> createRepeated() => $pb.PbList<HostTrackCommand>();
  @$core.pragma('dart2js:noInline')
  static HostTrackCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HostTrackCommand>(create);
  static HostTrackCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $6.Track get track => $_getN(1);
  @$pb.TagNumber(2)
  set track($6.Track value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTrack() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrack() => $_clearField(2);
  @$pb.TagNumber(2)
  $6.Track ensureTrack() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get startAtServerMs => $_getI64(2);
  @$pb.TagNumber(3)
  set startAtServerMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartAtServerMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartAtServerMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get startPosition => $_getI64(3);
  @$pb.TagNumber(4)
  set startPosition($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartPosition() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartPosition() => $_clearField(4);

  @$pb.TagNumber(6)
  $core.String get hostUserId => $_getSZ(4);
  @$pb.TagNumber(6)
  set hostUserId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasHostUserId() => $_has(4);
  @$pb.TagNumber(6)
  void clearHostUserId() => $_clearField(6);
}

class HostPositionUpdate extends $pb.GeneratedMessage {
  factory HostPositionUpdate({
    $core.String? roomId,
    $fixnum.Int64? currentPositionMs,
    $fixnum.Int64? serverTimestampMs,
    $core.String? hostUserId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (currentPositionMs != null) result.currentPositionMs = currentPositionMs;
    if (serverTimestampMs != null) result.serverTimestampMs = serverTimestampMs;
    if (hostUserId != null) result.hostUserId = hostUserId;
    return result;
  }

  HostPositionUpdate._();

  factory HostPositionUpdate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory HostPositionUpdate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HostPositionUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aInt64(2, _omitFieldNames ? '' : 'currentPositionMs')
    ..aInt64(3, _omitFieldNames ? '' : 'serverTimestampMs')
    ..aOS(4, _omitFieldNames ? '' : 'hostUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostPositionUpdate clone() => HostPositionUpdate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostPositionUpdate copyWith(void Function(HostPositionUpdate) updates) => super.copyWith((message) => updates(message as HostPositionUpdate)) as HostPositionUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HostPositionUpdate create() => HostPositionUpdate._();
  @$core.override
  HostPositionUpdate createEmptyInstance() => create();
  static $pb.PbList<HostPositionUpdate> createRepeated() => $pb.PbList<HostPositionUpdate>();
  @$core.pragma('dart2js:noInline')
  static HostPositionUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HostPositionUpdate>(create);
  static HostPositionUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get currentPositionMs => $_getI64(1);
  @$pb.TagNumber(2)
  set currentPositionMs($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentPositionMs() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPositionMs() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get serverTimestampMs => $_getI64(2);
  @$pb.TagNumber(3)
  set serverTimestampMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasServerTimestampMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerTimestampMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get hostUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set hostUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHostUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearHostUserId() => $_clearField(4);
}

class HostPlaybackCommand extends $pb.GeneratedMessage {
  factory HostPlaybackCommand({
    $core.String? roomId,
    HostPlaybackCommand_CommandType? type,
    $fixnum.Int64? executeAtServerMs,
    $fixnum.Int64? positionMs,
    $core.String? hostUserId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (type != null) result.type = type;
    if (executeAtServerMs != null) result.executeAtServerMs = executeAtServerMs;
    if (positionMs != null) result.positionMs = positionMs;
    if (hostUserId != null) result.hostUserId = hostUserId;
    return result;
  }

  HostPlaybackCommand._();

  factory HostPlaybackCommand.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory HostPlaybackCommand.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HostPlaybackCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..e<HostPlaybackCommand_CommandType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: HostPlaybackCommand_CommandType.PLAY, valueOf: HostPlaybackCommand_CommandType.valueOf, enumValues: HostPlaybackCommand_CommandType.values)
    ..aInt64(3, _omitFieldNames ? '' : 'executeAtServerMs')
    ..aInt64(4, _omitFieldNames ? '' : 'positionMs')
    ..aOS(5, _omitFieldNames ? '' : 'hostUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostPlaybackCommand clone() => HostPlaybackCommand()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostPlaybackCommand copyWith(void Function(HostPlaybackCommand) updates) => super.copyWith((message) => updates(message as HostPlaybackCommand)) as HostPlaybackCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HostPlaybackCommand create() => HostPlaybackCommand._();
  @$core.override
  HostPlaybackCommand createEmptyInstance() => create();
  static $pb.PbList<HostPlaybackCommand> createRepeated() => $pb.PbList<HostPlaybackCommand>();
  @$core.pragma('dart2js:noInline')
  static HostPlaybackCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HostPlaybackCommand>(create);
  static HostPlaybackCommand? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  HostPlaybackCommand_CommandType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(HostPlaybackCommand_CommandType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get executeAtServerMs => $_getI64(2);
  @$pb.TagNumber(3)
  set executeAtServerMs($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExecuteAtServerMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearExecuteAtServerMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get positionMs => $_getI64(3);
  @$pb.TagNumber(4)
  set positionMs($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPositionMs() => $_has(3);
  @$pb.TagNumber(4)
  void clearPositionMs() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get hostUserId => $_getSZ(4);
  @$pb.TagNumber(5)
  set hostUserId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHostUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearHostUserId() => $_clearField(5);
}

enum HostCommand_Command {
  trackCommand, 
  positionUpdate, 
  controlCommand, 
  notSet
}

class HostCommand extends $pb.GeneratedMessage {
  factory HostCommand({
    HostTrackCommand? trackCommand,
    HostPositionUpdate? positionUpdate,
    HostPlaybackCommand? controlCommand,
  }) {
    final result = create();
    if (trackCommand != null) result.trackCommand = trackCommand;
    if (positionUpdate != null) result.positionUpdate = positionUpdate;
    if (controlCommand != null) result.controlCommand = controlCommand;
    return result;
  }

  HostCommand._();

  factory HostCommand.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory HostCommand.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, HostCommand_Command> _HostCommand_CommandByTag = {
    1 : HostCommand_Command.trackCommand,
    2 : HostCommand_Command.positionUpdate,
    3 : HostCommand_Command.controlCommand,
    0 : HostCommand_Command.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HostCommand', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<HostTrackCommand>(1, _omitFieldNames ? '' : 'trackCommand', subBuilder: HostTrackCommand.create)
    ..aOM<HostPositionUpdate>(2, _omitFieldNames ? '' : 'positionUpdate', subBuilder: HostPositionUpdate.create)
    ..aOM<HostPlaybackCommand>(3, _omitFieldNames ? '' : 'controlCommand', subBuilder: HostPlaybackCommand.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostCommand clone() => HostCommand()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HostCommand copyWith(void Function(HostCommand) updates) => super.copyWith((message) => updates(message as HostCommand)) as HostCommand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HostCommand create() => HostCommand._();
  @$core.override
  HostCommand createEmptyInstance() => create();
  static $pb.PbList<HostCommand> createRepeated() => $pb.PbList<HostCommand>();
  @$core.pragma('dart2js:noInline')
  static HostCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HostCommand>(create);
  static HostCommand? _defaultInstance;

  HostCommand_Command whichCommand() => _HostCommand_CommandByTag[$_whichOneof(0)]!;
  void clearCommand() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  HostTrackCommand get trackCommand => $_getN(0);
  @$pb.TagNumber(1)
  set trackCommand(HostTrackCommand value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackCommand() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackCommand() => $_clearField(1);
  @$pb.TagNumber(1)
  HostTrackCommand ensureTrackCommand() => $_ensure(0);

  @$pb.TagNumber(2)
  HostPositionUpdate get positionUpdate => $_getN(1);
  @$pb.TagNumber(2)
  set positionUpdate(HostPositionUpdate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPositionUpdate() => $_has(1);
  @$pb.TagNumber(2)
  void clearPositionUpdate() => $_clearField(2);
  @$pb.TagNumber(2)
  HostPositionUpdate ensurePositionUpdate() => $_ensure(1);

  @$pb.TagNumber(3)
  HostPlaybackCommand get controlCommand => $_getN(2);
  @$pb.TagNumber(3)
  set controlCommand(HostPlaybackCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasControlCommand() => $_has(2);
  @$pb.TagNumber(3)
  void clearControlCommand() => $_clearField(3);
  @$pb.TagNumber(3)
  HostPlaybackCommand ensureControlCommand() => $_ensure(2);
}

class MemberStatus extends $pb.GeneratedMessage {
  factory MemberStatus({
    $core.String? roomId,
    $core.String? userId,
    MemberStatus_StatusType? status,
    $fixnum.Int64? actualPositionMs,
    $fixnum.Int64? clientTimestampMs,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (status != null) result.status = status;
    if (actualPositionMs != null) result.actualPositionMs = actualPositionMs;
    if (clientTimestampMs != null) result.clientTimestampMs = clientTimestampMs;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  MemberStatus._();

  factory MemberStatus.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MemberStatus.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MemberStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<MemberStatus_StatusType>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: MemberStatus_StatusType.JOINED, valueOf: MemberStatus_StatusType.valueOf, enumValues: MemberStatus_StatusType.values)
    ..aInt64(4, _omitFieldNames ? '' : 'actualPositionMs')
    ..aInt64(5, _omitFieldNames ? '' : 'clientTimestampMs')
    ..aOS(6, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberStatus clone() => MemberStatus()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberStatus copyWith(void Function(MemberStatus) updates) => super.copyWith((message) => updates(message as MemberStatus)) as MemberStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberStatus create() => MemberStatus._();
  @$core.override
  MemberStatus createEmptyInstance() => create();
  static $pb.PbList<MemberStatus> createRepeated() => $pb.PbList<MemberStatus>();
  @$core.pragma('dart2js:noInline')
  static MemberStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberStatus>(create);
  static MemberStatus? _defaultInstance;

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
  MemberStatus_StatusType get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(MemberStatus_StatusType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get actualPositionMs => $_getI64(3);
  @$pb.TagNumber(4)
  set actualPositionMs($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActualPositionMs() => $_has(3);
  @$pb.TagNumber(4)
  void clearActualPositionMs() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get clientTimestampMs => $_getI64(4);
  @$pb.TagNumber(5)
  set clientTimestampMs($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasClientTimestampMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearClientTimestampMs() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get errorMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set errorMessage($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasErrorMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearErrorMessage() => $_clearField(6);
}

class ServerBroadcast extends $pb.GeneratedMessage {
  factory ServerBroadcast({
    $core.String? roomId,
    ServerBroadcast_BroadcastType? type,
    HostTrackCommand? trackCommand,
    HostPositionUpdate? positionUpdate,
    HostPlaybackCommand? controlCommand,
    $core.String? newHostUserId,
    $core.String? affectedUserId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (type != null) result.type = type;
    if (trackCommand != null) result.trackCommand = trackCommand;
    if (positionUpdate != null) result.positionUpdate = positionUpdate;
    if (controlCommand != null) result.controlCommand = controlCommand;
    if (newHostUserId != null) result.newHostUserId = newHostUserId;
    if (affectedUserId != null) result.affectedUserId = affectedUserId;
    return result;
  }

  ServerBroadcast._();

  factory ServerBroadcast.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ServerBroadcast.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ServerBroadcast', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..e<ServerBroadcast_BroadcastType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ServerBroadcast_BroadcastType.TRACK_COMMAND, valueOf: ServerBroadcast_BroadcastType.valueOf, enumValues: ServerBroadcast_BroadcastType.values)
    ..aOM<HostTrackCommand>(3, _omitFieldNames ? '' : 'trackCommand', subBuilder: HostTrackCommand.create)
    ..aOM<HostPositionUpdate>(4, _omitFieldNames ? '' : 'positionUpdate', subBuilder: HostPositionUpdate.create)
    ..aOM<HostPlaybackCommand>(5, _omitFieldNames ? '' : 'controlCommand', subBuilder: HostPlaybackCommand.create)
    ..aOS(6, _omitFieldNames ? '' : 'newHostUserId')
    ..aOS(7, _omitFieldNames ? '' : 'affectedUserId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerBroadcast clone() => ServerBroadcast()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerBroadcast copyWith(void Function(ServerBroadcast) updates) => super.copyWith((message) => updates(message as ServerBroadcast)) as ServerBroadcast;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerBroadcast create() => ServerBroadcast._();
  @$core.override
  ServerBroadcast createEmptyInstance() => create();
  static $pb.PbList<ServerBroadcast> createRepeated() => $pb.PbList<ServerBroadcast>();
  @$core.pragma('dart2js:noInline')
  static ServerBroadcast getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerBroadcast>(create);
  static ServerBroadcast? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  ServerBroadcast_BroadcastType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(ServerBroadcast_BroadcastType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  HostTrackCommand get trackCommand => $_getN(2);
  @$pb.TagNumber(3)
  set trackCommand(HostTrackCommand value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTrackCommand() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrackCommand() => $_clearField(3);
  @$pb.TagNumber(3)
  HostTrackCommand ensureTrackCommand() => $_ensure(2);

  @$pb.TagNumber(4)
  HostPositionUpdate get positionUpdate => $_getN(3);
  @$pb.TagNumber(4)
  set positionUpdate(HostPositionUpdate value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPositionUpdate() => $_has(3);
  @$pb.TagNumber(4)
  void clearPositionUpdate() => $_clearField(4);
  @$pb.TagNumber(4)
  HostPositionUpdate ensurePositionUpdate() => $_ensure(3);

  @$pb.TagNumber(5)
  HostPlaybackCommand get controlCommand => $_getN(4);
  @$pb.TagNumber(5)
  set controlCommand(HostPlaybackCommand value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasControlCommand() => $_has(4);
  @$pb.TagNumber(5)
  void clearControlCommand() => $_clearField(5);
  @$pb.TagNumber(5)
  HostPlaybackCommand ensureControlCommand() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get newHostUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set newHostUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNewHostUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearNewHostUserId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get affectedUserId => $_getSZ(6);
  @$pb.TagNumber(7)
  set affectedUserId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAffectedUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearAffectedUserId() => $_clearField(7);
}

class ServerResponse extends $pb.GeneratedMessage {
  factory ServerResponse({
    ServerResponse_ResponseType? type,
    $core.int? readyMemberCount,
    $core.int? totalMemberCount,
    $core.Iterable<MemberStatus>? memberStatuses,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (readyMemberCount != null) result.readyMemberCount = readyMemberCount;
    if (totalMemberCount != null) result.totalMemberCount = totalMemberCount;
    if (memberStatuses != null) result.memberStatuses.addAll(memberStatuses);
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  ServerResponse._();

  factory ServerResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ServerResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ServerResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..e<ServerResponse_ResponseType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ServerResponse_ResponseType.ACKNOWLEDGED, valueOf: ServerResponse_ResponseType.valueOf, enumValues: ServerResponse_ResponseType.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'readyMemberCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalMemberCount', $pb.PbFieldType.O3)
    ..pc<MemberStatus>(4, _omitFieldNames ? '' : 'memberStatuses', $pb.PbFieldType.PM, subBuilder: MemberStatus.create)
    ..aOS(5, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerResponse clone() => ServerResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServerResponse copyWith(void Function(ServerResponse) updates) => super.copyWith((message) => updates(message as ServerResponse)) as ServerResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerResponse create() => ServerResponse._();
  @$core.override
  ServerResponse createEmptyInstance() => create();
  static $pb.PbList<ServerResponse> createRepeated() => $pb.PbList<ServerResponse>();
  @$core.pragma('dart2js:noInline')
  static ServerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerResponse>(create);
  static ServerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ServerResponse_ResponseType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ServerResponse_ResponseType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get readyMemberCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set readyMemberCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReadyMemberCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadyMemberCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalMemberCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalMemberCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalMemberCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalMemberCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<MemberStatus> get memberStatuses => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get errorMessage => $_getSZ(4);
  @$pb.TagNumber(5)
  set errorMessage($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasErrorMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearErrorMessage() => $_clearField(5);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
