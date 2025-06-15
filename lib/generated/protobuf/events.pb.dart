//
//  Generated code. Do not modify.
//  source: protobuf/events.proto
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
import 'events.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'events.pbenum.dart';

class PlaybackEventLog extends $pb.GeneratedMessage {
  factory PlaybackEventLog({
    $fixnum.Int64? eventId,
    $core.String? roomId,
    $core.String? userId,
    $9.EventType? eventType,
    $core.String? eventPayload,
    $8.Timestamp? timestamp,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (eventType != null) result.eventType = eventType;
    if (eventPayload != null) result.eventPayload = eventPayload;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  PlaybackEventLog._();

  factory PlaybackEventLog.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlaybackEventLog.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaybackEventLog', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'roomId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..e<$9.EventType>(4, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE, defaultOrMaker: $9.EventType.PLAY, valueOf: $9.EventType.valueOf, enumValues: $9.EventType.values)
    ..aOS(5, _omitFieldNames ? '' : 'eventPayload')
    ..aOM<$8.Timestamp>(6, _omitFieldNames ? '' : 'timestamp', subBuilder: $8.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackEventLog clone() => PlaybackEventLog()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackEventLog copyWith(void Function(PlaybackEventLog) updates) => super.copyWith((message) => updates(message as PlaybackEventLog)) as PlaybackEventLog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackEventLog create() => PlaybackEventLog._();
  @$core.override
  PlaybackEventLog createEmptyInstance() => create();
  static $pb.PbList<PlaybackEventLog> createRepeated() => $pb.PbList<PlaybackEventLog>();
  @$core.pragma('dart2js:noInline')
  static PlaybackEventLog getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaybackEventLog>(create);
  static PlaybackEventLog? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get eventId => $_getI64(0);
  @$pb.TagNumber(1)
  set eventId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomId => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoomId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $9.EventType get eventType => $_getN(3);
  @$pb.TagNumber(4)
  set eventType($9.EventType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get eventPayload => $_getSZ(4);
  @$pb.TagNumber(5)
  set eventPayload($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEventPayload() => $_has(4);
  @$pb.TagNumber(5)
  void clearEventPayload() => $_clearField(5);

  @$pb.TagNumber(6)
  $8.Timestamp get timestamp => $_getN(5);
  @$pb.TagNumber(6)
  set timestamp($8.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => $_clearField(6);
  @$pb.TagNumber(6)
  $8.Timestamp ensureTimestamp() => $_ensure(5);
}

class StreamRoomEventsRequest extends $pb.GeneratedMessage {
  factory StreamRoomEventsRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  StreamRoomEventsRequest._();

  factory StreamRoomEventsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StreamRoomEventsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamRoomEventsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamRoomEventsRequest clone() => StreamRoomEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamRoomEventsRequest copyWith(void Function(StreamRoomEventsRequest) updates) => super.copyWith((message) => updates(message as StreamRoomEventsRequest)) as StreamRoomEventsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamRoomEventsRequest create() => StreamRoomEventsRequest._();
  @$core.override
  StreamRoomEventsRequest createEmptyInstance() => create();
  static $pb.PbList<StreamRoomEventsRequest> createRepeated() => $pb.PbList<StreamRoomEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamRoomEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamRoomEventsRequest>(create);
  static StreamRoomEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class RoomEvent extends $pb.GeneratedMessage {
  factory RoomEvent({
    $core.String? eventId,
    $core.String? roomId,
    RoomEvent_EventCategory? category,
    $core.String? userId,
    $core.String? detailsJson,
    $8.Timestamp? timestamp,
  }) {
    final result = create();
    if (eventId != null) result.eventId = eventId;
    if (roomId != null) result.roomId = roomId;
    if (category != null) result.category = category;
    if (userId != null) result.userId = userId;
    if (detailsJson != null) result.detailsJson = detailsJson;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  RoomEvent._();

  factory RoomEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventId')
    ..aOS(2, _omitFieldNames ? '' : 'roomId')
    ..e<RoomEvent_EventCategory>(3, _omitFieldNames ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: RoomEvent_EventCategory.EVENT_CATEGORY_UNSPECIFIED, valueOf: RoomEvent_EventCategory.valueOf, enumValues: RoomEvent_EventCategory.values)
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..aOS(5, _omitFieldNames ? '' : 'detailsJson')
    ..aOM<$8.Timestamp>(6, _omitFieldNames ? '' : 'timestamp', subBuilder: $8.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomEvent clone() => RoomEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomEvent copyWith(void Function(RoomEvent) updates) => super.copyWith((message) => updates(message as RoomEvent)) as RoomEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomEvent create() => RoomEvent._();
  @$core.override
  RoomEvent createEmptyInstance() => create();
  static $pb.PbList<RoomEvent> createRepeated() => $pb.PbList<RoomEvent>();
  @$core.pragma('dart2js:noInline')
  static RoomEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomEvent>(create);
  static RoomEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get eventId => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get roomId => $_getSZ(1);
  @$pb.TagNumber(2)
  set roomId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoomId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoomId() => $_clearField(2);

  @$pb.TagNumber(3)
  RoomEvent_EventCategory get category => $_getN(2);
  @$pb.TagNumber(3)
  set category(RoomEvent_EventCategory value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get detailsJson => $_getSZ(4);
  @$pb.TagNumber(5)
  set detailsJson($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDetailsJson() => $_has(4);
  @$pb.TagNumber(5)
  void clearDetailsJson() => $_clearField(5);

  @$pb.TagNumber(6)
  $8.Timestamp get timestamp => $_getN(5);
  @$pb.TagNumber(6)
  set timestamp($8.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => $_clearField(6);
  @$pb.TagNumber(6)
  $8.Timestamp ensureTimestamp() => $_ensure(5);
}

class StreamPlaybackEventsRequest extends $pb.GeneratedMessage {
  factory StreamPlaybackEventsRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  StreamPlaybackEventsRequest._();

  factory StreamPlaybackEventsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StreamPlaybackEventsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamPlaybackEventsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamPlaybackEventsRequest clone() => StreamPlaybackEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StreamPlaybackEventsRequest copyWith(void Function(StreamPlaybackEventsRequest) updates) => super.copyWith((message) => updates(message as StreamPlaybackEventsRequest)) as StreamPlaybackEventsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamPlaybackEventsRequest create() => StreamPlaybackEventsRequest._();
  @$core.override
  StreamPlaybackEventsRequest createEmptyInstance() => create();
  static $pb.PbList<StreamPlaybackEventsRequest> createRepeated() => $pb.PbList<StreamPlaybackEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static StreamPlaybackEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamPlaybackEventsRequest>(create);
  static StreamPlaybackEventsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class PlaybackEvent extends $pb.GeneratedMessage {
  factory PlaybackEvent({
    $core.String? roomId,
    $core.String? userId,
    $9.EventType? eventType,
    $core.String? trackId,
    $core.int? positionMs,
    $8.Timestamp? timestamp,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (eventType != null) result.eventType = eventType;
    if (trackId != null) result.trackId = trackId;
    if (positionMs != null) result.positionMs = positionMs;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  PlaybackEvent._();

  factory PlaybackEvent.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PlaybackEvent.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlaybackEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<$9.EventType>(3, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE, defaultOrMaker: $9.EventType.PLAY, valueOf: $9.EventType.valueOf, enumValues: $9.EventType.values)
    ..aOS(4, _omitFieldNames ? '' : 'trackId')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'positionMs', $pb.PbFieldType.O3)
    ..aOM<$8.Timestamp>(6, _omitFieldNames ? '' : 'timestamp', subBuilder: $8.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackEvent clone() => PlaybackEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaybackEvent copyWith(void Function(PlaybackEvent) updates) => super.copyWith((message) => updates(message as PlaybackEvent)) as PlaybackEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaybackEvent create() => PlaybackEvent._();
  @$core.override
  PlaybackEvent createEmptyInstance() => create();
  static $pb.PbList<PlaybackEvent> createRepeated() => $pb.PbList<PlaybackEvent>();
  @$core.pragma('dart2js:noInline')
  static PlaybackEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaybackEvent>(create);
  static PlaybackEvent? _defaultInstance;

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
  $9.EventType get eventType => $_getN(2);
  @$pb.TagNumber(3)
  set eventType($9.EventType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get trackId => $_getSZ(3);
  @$pb.TagNumber(4)
  set trackId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTrackId() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrackId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get positionMs => $_getIZ(4);
  @$pb.TagNumber(5)
  set positionMs($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPositionMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearPositionMs() => $_clearField(5);

  @$pb.TagNumber(6)
  $8.Timestamp get timestamp => $_getN(5);
  @$pb.TagNumber(6)
  set timestamp($8.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => $_clearField(6);
  @$pb.TagNumber(6)
  $8.Timestamp ensureTimestamp() => $_ensure(5);
}

class LogEventRequest extends $pb.GeneratedMessage {
  factory LogEventRequest({
    $core.String? roomId,
    $core.String? userId,
    $9.EventType? eventType,
    $core.String? eventPayload,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (userId != null) result.userId = userId;
    if (eventType != null) result.eventType = eventType;
    if (eventPayload != null) result.eventPayload = eventPayload;
    return result;
  }

  LogEventRequest._();

  factory LogEventRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory LogEventRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogEventRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..e<$9.EventType>(3, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE, defaultOrMaker: $9.EventType.PLAY, valueOf: $9.EventType.valueOf, enumValues: $9.EventType.values)
    ..aOS(4, _omitFieldNames ? '' : 'eventPayload')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEventRequest clone() => LogEventRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogEventRequest copyWith(void Function(LogEventRequest) updates) => super.copyWith((message) => updates(message as LogEventRequest)) as LogEventRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEventRequest create() => LogEventRequest._();
  @$core.override
  LogEventRequest createEmptyInstance() => create();
  static $pb.PbList<LogEventRequest> createRepeated() => $pb.PbList<LogEventRequest>();
  @$core.pragma('dart2js:noInline')
  static LogEventRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogEventRequest>(create);
  static LogEventRequest? _defaultInstance;

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
  $9.EventType get eventType => $_getN(2);
  @$pb.TagNumber(3)
  set eventType($9.EventType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEventType() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get eventPayload => $_getSZ(3);
  @$pb.TagNumber(4)
  set eventPayload($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEventPayload() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventPayload() => $_clearField(4);
}

class GetEventHistoryRequest extends $pb.GeneratedMessage {
  factory GetEventHistoryRequest({
    $core.String? roomId,
    $8.Timestamp? startTime,
    $8.Timestamp? endTime,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (startTime != null) result.startTime = startTime;
    if (endTime != null) result.endTime = endTime;
    if (pageSize != null) result.pageSize = pageSize;
    if (pageToken != null) result.pageToken = pageToken;
    return result;
  }

  GetEventHistoryRequest._();

  factory GetEventHistoryRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetEventHistoryRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEventHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOM<$8.Timestamp>(2, _omitFieldNames ? '' : 'startTime', subBuilder: $8.Timestamp.create)
    ..aOM<$8.Timestamp>(3, _omitFieldNames ? '' : 'endTime', subBuilder: $8.Timestamp.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventHistoryRequest clone() => GetEventHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventHistoryRequest copyWith(void Function(GetEventHistoryRequest) updates) => super.copyWith((message) => updates(message as GetEventHistoryRequest)) as GetEventHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEventHistoryRequest create() => GetEventHistoryRequest._();
  @$core.override
  GetEventHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetEventHistoryRequest> createRepeated() => $pb.PbList<GetEventHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEventHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventHistoryRequest>(create);
  static GetEventHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $8.Timestamp get startTime => $_getN(1);
  @$pb.TagNumber(2)
  set startTime($8.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => $_clearField(2);
  @$pb.TagNumber(2)
  $8.Timestamp ensureStartTime() => $_ensure(1);

  @$pb.TagNumber(3)
  $8.Timestamp get endTime => $_getN(2);
  @$pb.TagNumber(3)
  set endTime($8.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEndTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndTime() => $_clearField(3);
  @$pb.TagNumber(3)
  $8.Timestamp ensureEndTime() => $_ensure(2);

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

class GetEventHistoryResponse extends $pb.GeneratedMessage {
  factory GetEventHistoryResponse({
    $core.Iterable<PlaybackEventLog>? events,
    $core.String? nextPageToken,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (nextPageToken != null) result.nextPageToken = nextPageToken;
    return result;
  }

  GetEventHistoryResponse._();

  factory GetEventHistoryResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetEventHistoryResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEventHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..pc<PlaybackEventLog>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: PlaybackEventLog.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventHistoryResponse clone() => GetEventHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEventHistoryResponse copyWith(void Function(GetEventHistoryResponse) updates) => super.copyWith((message) => updates(message as GetEventHistoryResponse)) as GetEventHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEventHistoryResponse create() => GetEventHistoryResponse._();
  @$core.override
  GetEventHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetEventHistoryResponse> createRepeated() => $pb.PbList<GetEventHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEventHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEventHistoryResponse>(create);
  static GetEventHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PlaybackEventLog> get events => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
