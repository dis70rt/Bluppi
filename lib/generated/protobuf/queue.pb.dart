//
//  Generated code. Do not modify.
//  source: protobuf/queue.proto
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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RoomQueueItem extends $pb.GeneratedMessage {
  factory RoomQueueItem({
    $core.String? roomId,
    $core.int? position,
    $core.String? trackId,
    $core.String? addedBy,
    $8.Timestamp? addedAt,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (position != null) result.position = position;
    if (trackId != null) result.trackId = trackId;
    if (addedBy != null) result.addedBy = addedBy;
    if (addedAt != null) result.addedAt = addedAt;
    return result;
  }

  RoomQueueItem._();

  factory RoomQueueItem.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RoomQueueItem.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoomQueueItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'position', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'trackId')
    ..aOS(4, _omitFieldNames ? '' : 'addedBy')
    ..aOM<$8.Timestamp>(5, _omitFieldNames ? '' : 'addedAt', subBuilder: $8.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomQueueItem clone() => RoomQueueItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RoomQueueItem copyWith(void Function(RoomQueueItem) updates) => super.copyWith((message) => updates(message as RoomQueueItem)) as RoomQueueItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoomQueueItem create() => RoomQueueItem._();
  @$core.override
  RoomQueueItem createEmptyInstance() => create();
  static $pb.PbList<RoomQueueItem> createRepeated() => $pb.PbList<RoomQueueItem>();
  @$core.pragma('dart2js:noInline')
  static RoomQueueItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomQueueItem>(create);
  static RoomQueueItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get position => $_getIZ(1);
  @$pb.TagNumber(2)
  set position($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get trackId => $_getSZ(2);
  @$pb.TagNumber(3)
  set trackId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTrackId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTrackId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get addedBy => $_getSZ(3);
  @$pb.TagNumber(4)
  set addedBy($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAddedBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddedBy() => $_clearField(4);

  @$pb.TagNumber(5)
  $8.Timestamp get addedAt => $_getN(4);
  @$pb.TagNumber(5)
  set addedAt($8.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAddedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $8.Timestamp ensureAddedAt() => $_ensure(4);
}

class AddToQueueRequest extends $pb.GeneratedMessage {
  factory AddToQueueRequest({
    $core.String? roomId,
    $core.String? trackId,
    $core.String? userId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (trackId != null) result.trackId = trackId;
    if (userId != null) result.userId = userId;
    return result;
  }

  AddToQueueRequest._();

  factory AddToQueueRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AddToQueueRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddToQueueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddToQueueRequest clone() => AddToQueueRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddToQueueRequest copyWith(void Function(AddToQueueRequest) updates) => super.copyWith((message) => updates(message as AddToQueueRequest)) as AddToQueueRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddToQueueRequest create() => AddToQueueRequest._();
  @$core.override
  AddToQueueRequest createEmptyInstance() => create();
  static $pb.PbList<AddToQueueRequest> createRepeated() => $pb.PbList<AddToQueueRequest>();
  @$core.pragma('dart2js:noInline')
  static AddToQueueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddToQueueRequest>(create);
  static AddToQueueRequest? _defaultInstance;

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
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);
}

class RemoveFromQueueRequest extends $pb.GeneratedMessage {
  factory RemoveFromQueueRequest({
    $core.String? roomId,
    $core.String? trackId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (trackId != null) result.trackId = trackId;
    return result;
  }

  RemoveFromQueueRequest._();

  factory RemoveFromQueueRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RemoveFromQueueRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveFromQueueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFromQueueRequest clone() => RemoveFromQueueRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFromQueueRequest copyWith(void Function(RemoveFromQueueRequest) updates) => super.copyWith((message) => updates(message as RemoveFromQueueRequest)) as RemoveFromQueueRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFromQueueRequest create() => RemoveFromQueueRequest._();
  @$core.override
  RemoveFromQueueRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveFromQueueRequest> createRepeated() => $pb.PbList<RemoveFromQueueRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveFromQueueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveFromQueueRequest>(create);
  static RemoveFromQueueRequest? _defaultInstance;

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
}

class GetQueueRequest extends $pb.GeneratedMessage {
  factory GetQueueRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  GetQueueRequest._();

  factory GetQueueRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetQueueRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQueueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQueueRequest clone() => GetQueueRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQueueRequest copyWith(void Function(GetQueueRequest) updates) => super.copyWith((message) => updates(message as GetQueueRequest)) as GetQueueRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQueueRequest create() => GetQueueRequest._();
  @$core.override
  GetQueueRequest createEmptyInstance() => create();
  static $pb.PbList<GetQueueRequest> createRepeated() => $pb.PbList<GetQueueRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQueueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQueueRequest>(create);
  static GetQueueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}

class GetQueueResponse extends $pb.GeneratedMessage {
  factory GetQueueResponse({
    $core.Iterable<RoomQueueItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  GetQueueResponse._();

  factory GetQueueResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetQueueResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetQueueResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..pc<RoomQueueItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: RoomQueueItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQueueResponse clone() => GetQueueResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQueueResponse copyWith(void Function(GetQueueResponse) updates) => super.copyWith((message) => updates(message as GetQueueResponse)) as GetQueueResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQueueResponse create() => GetQueueResponse._();
  @$core.override
  GetQueueResponse createEmptyInstance() => create();
  static $pb.PbList<GetQueueResponse> createRepeated() => $pb.PbList<GetQueueResponse>();
  @$core.pragma('dart2js:noInline')
  static GetQueueResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQueueResponse>(create);
  static GetQueueResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RoomQueueItem> get items => $_getList(0);
}

class ClearQueueRequest extends $pb.GeneratedMessage {
  factory ClearQueueRequest({
    $core.String? roomId,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    return result;
  }

  ClearQueueRequest._();

  factory ClearQueueRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ClearQueueRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClearQueueRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'ListeningParty'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearQueueRequest clone() => ClearQueueRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearQueueRequest copyWith(void Function(ClearQueueRequest) updates) => super.copyWith((message) => updates(message as ClearQueueRequest)) as ClearQueueRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClearQueueRequest create() => ClearQueueRequest._();
  @$core.override
  ClearQueueRequest createEmptyInstance() => create();
  static $pb.PbList<ClearQueueRequest> createRepeated() => $pb.PbList<ClearQueueRequest>();
  @$core.pragma('dart2js:noInline')
  static ClearQueueRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClearQueueRequest>(create);
  static ClearQueueRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get roomId => $_getSZ(0);
  @$pb.TagNumber(1)
  set roomId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoomId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoomId() => $_clearField(1);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
