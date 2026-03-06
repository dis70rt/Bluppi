// This is a generated file - do not edit.
//
// Generated from notifications.proto.

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

import 'notifications.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'notifications.pbenum.dart';

class RegisterDeviceRequest extends $pb.GeneratedMessage {
  factory RegisterDeviceRequest({
    $core.String? fcmToken,
    DeviceType? deviceType,
  }) {
    final result = create();
    if (fcmToken != null) result.fcmToken = fcmToken;
    if (deviceType != null) result.deviceType = deviceType;
    return result;
  }

  RegisterDeviceRequest._();

  factory RegisterDeviceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterDeviceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterDeviceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fcmToken')
    ..aE<DeviceType>(2, _omitFieldNames ? '' : 'deviceType',
        enumValues: DeviceType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterDeviceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterDeviceRequest copyWith(
          void Function(RegisterDeviceRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterDeviceRequest))
          as RegisterDeviceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterDeviceRequest create() => RegisterDeviceRequest._();
  @$core.override
  RegisterDeviceRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RegisterDeviceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterDeviceRequest>(create);
  static RegisterDeviceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fcmToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set fcmToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFcmToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearFcmToken() => $_clearField(1);

  @$pb.TagNumber(2)
  DeviceType get deviceType => $_getN(1);
  @$pb.TagNumber(2)
  set deviceType(DeviceType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceType() => $_clearField(2);
}

class UnregisterDeviceRequest extends $pb.GeneratedMessage {
  factory UnregisterDeviceRequest({
    $core.String? fcmToken,
  }) {
    final result = create();
    if (fcmToken != null) result.fcmToken = fcmToken;
    return result;
  }

  UnregisterDeviceRequest._();

  factory UnregisterDeviceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnregisterDeviceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnregisterDeviceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fcmToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnregisterDeviceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnregisterDeviceRequest copyWith(
          void Function(UnregisterDeviceRequest) updates) =>
      super.copyWith((message) => updates(message as UnregisterDeviceRequest))
          as UnregisterDeviceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnregisterDeviceRequest create() => UnregisterDeviceRequest._();
  @$core.override
  UnregisterDeviceRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UnregisterDeviceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnregisterDeviceRequest>(create);
  static UnregisterDeviceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fcmToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set fcmToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFcmToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearFcmToken() => $_clearField(1);
}

class NotificationPreferences extends $pb.GeneratedMessage {
  factory NotificationPreferences({
    $core.bool? pushNotificationsEnabled,
    $core.bool? emailNotificationsEnabled,
    $core.bool? partyInvitesEnabled,
    $core.bool? newFollowersEnabled,
    $core.bool? followRequestEnabled,
    $core.bool? followerListeningEnabled,
  }) {
    final result = create();
    if (pushNotificationsEnabled != null)
      result.pushNotificationsEnabled = pushNotificationsEnabled;
    if (emailNotificationsEnabled != null)
      result.emailNotificationsEnabled = emailNotificationsEnabled;
    if (partyInvitesEnabled != null)
      result.partyInvitesEnabled = partyInvitesEnabled;
    if (newFollowersEnabled != null)
      result.newFollowersEnabled = newFollowersEnabled;
    if (followRequestEnabled != null)
      result.followRequestEnabled = followRequestEnabled;
    if (followerListeningEnabled != null)
      result.followerListeningEnabled = followerListeningEnabled;
    return result;
  }

  NotificationPreferences._();

  factory NotificationPreferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationPreferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPreferences',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'pushNotificationsEnabled')
    ..aOB(2, _omitFieldNames ? '' : 'emailNotificationsEnabled')
    ..aOB(3, _omitFieldNames ? '' : 'partyInvitesEnabled')
    ..aOB(4, _omitFieldNames ? '' : 'newFollowersEnabled')
    ..aOB(5, _omitFieldNames ? '' : 'followRequestEnabled')
    ..aOB(6, _omitFieldNames ? '' : 'followerListeningEnabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreferences clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreferences copyWith(
          void Function(NotificationPreferences) updates) =>
      super.copyWith((message) => updates(message as NotificationPreferences))
          as NotificationPreferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPreferences create() => NotificationPreferences._();
  @$core.override
  NotificationPreferences createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static NotificationPreferences getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationPreferences>(create);
  static NotificationPreferences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get pushNotificationsEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set pushNotificationsEnabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPushNotificationsEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearPushNotificationsEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get emailNotificationsEnabled => $_getBF(1);
  @$pb.TagNumber(2)
  set emailNotificationsEnabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmailNotificationsEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmailNotificationsEnabled() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get partyInvitesEnabled => $_getBF(2);
  @$pb.TagNumber(3)
  set partyInvitesEnabled($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPartyInvitesEnabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearPartyInvitesEnabled() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get newFollowersEnabled => $_getBF(3);
  @$pb.TagNumber(4)
  set newFollowersEnabled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewFollowersEnabled() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewFollowersEnabled() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get followRequestEnabled => $_getBF(4);
  @$pb.TagNumber(5)
  set followRequestEnabled($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFollowRequestEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearFollowRequestEnabled() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get followerListeningEnabled => $_getBF(5);
  @$pb.TagNumber(6)
  set followerListeningEnabled($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFollowerListeningEnabled() => $_has(5);
  @$pb.TagNumber(6)
  void clearFollowerListeningEnabled() => $_clearField(6);
}

class UpdatePreferencesRequest extends $pb.GeneratedMessage {
  factory UpdatePreferencesRequest({
    NotificationPreferences? preferences,
  }) {
    final result = create();
    if (preferences != null) result.preferences = preferences;
    return result;
  }

  UpdatePreferencesRequest._();

  factory UpdatePreferencesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePreferencesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePreferencesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aOM<NotificationPreferences>(1, _omitFieldNames ? '' : 'preferences',
        subBuilder: NotificationPreferences.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePreferencesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePreferencesRequest copyWith(
          void Function(UpdatePreferencesRequest) updates) =>
      super.copyWith((message) => updates(message as UpdatePreferencesRequest))
          as UpdatePreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePreferencesRequest create() => UpdatePreferencesRequest._();
  @$core.override
  UpdatePreferencesRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdatePreferencesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePreferencesRequest>(create);
  static UpdatePreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationPreferences get preferences => $_getN(0);
  @$pb.TagNumber(1)
  set preferences(NotificationPreferences value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPreferences() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreferences() => $_clearField(1);
  @$pb.TagNumber(1)
  NotificationPreferences ensurePreferences() => $_ensure(0);
}

class InAppNotification extends $pb.GeneratedMessage {
  factory InAppNotification({
    $core.String? id,
    $core.String? type,
    $core.String? title,
    $core.String? body,
    $core.String? actionData,
    $core.bool? isRead,
    $2.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (title != null) result.title = title;
    if (body != null) result.body = body;
    if (actionData != null) result.actionData = actionData;
    if (isRead != null) result.isRead = isRead;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  InAppNotification._();

  factory InAppNotification.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InAppNotification.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InAppNotification',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'body')
    ..aOS(5, _omitFieldNames ? '' : 'actionData')
    ..aOB(6, _omitFieldNames ? '' : 'isRead')
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InAppNotification clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InAppNotification copyWith(void Function(InAppNotification) updates) =>
      super.copyWith((message) => updates(message as InAppNotification))
          as InAppNotification;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InAppNotification create() => InAppNotification._();
  @$core.override
  InAppNotification createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InAppNotification getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InAppNotification>(create);
  static InAppNotification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get body => $_getSZ(3);
  @$pb.TagNumber(4)
  set body($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBody() => $_has(3);
  @$pb.TagNumber(4)
  void clearBody() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get actionData => $_getSZ(4);
  @$pb.TagNumber(5)
  set actionData($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasActionData() => $_has(4);
  @$pb.TagNumber(5)
  void clearActionData() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isRead => $_getBF(5);
  @$pb.TagNumber(6)
  set isRead($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsRead() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsRead() => $_clearField(6);

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
}

class GetHistoryRequest extends $pb.GeneratedMessage {
  factory GetHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetHistoryRequest._();

  factory GetHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..aI(2, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryRequest copyWith(void Function(GetHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetHistoryRequest))
          as GetHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoryRequest create() => GetHistoryRequest._();
  @$core.override
  GetHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoryRequest>(create);
  static GetHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);
}

class GetHistoryResponse extends $pb.GeneratedMessage {
  factory GetHistoryResponse({
    $core.Iterable<InAppNotification>? notifications,
    $core.int? totalUnread,
  }) {
    final result = create();
    if (notifications != null) result.notifications.addAll(notifications);
    if (totalUnread != null) result.totalUnread = totalUnread;
    return result;
  }

  GetHistoryResponse._();

  factory GetHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..pPM<InAppNotification>(1, _omitFieldNames ? '' : 'notifications',
        subBuilder: InAppNotification.create)
    ..aI(2, _omitFieldNames ? '' : 'totalUnread')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryResponse copyWith(void Function(GetHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetHistoryResponse))
          as GetHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHistoryResponse create() => GetHistoryResponse._();
  @$core.override
  GetHistoryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoryResponse>(create);
  static GetHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InAppNotification> get notifications => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalUnread => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalUnread($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalUnread() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalUnread() => $_clearField(2);
}

class MarkAsReadRequest extends $pb.GeneratedMessage {
  factory MarkAsReadRequest({
    $core.Iterable<$core.String>? notificationIds,
  }) {
    final result = create();
    if (notificationIds != null) result.notificationIds.addAll(notificationIds);
    return result;
  }

  MarkAsReadRequest._();

  factory MarkAsReadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarkAsReadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarkAsReadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'notificationIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkAsReadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarkAsReadRequest copyWith(void Function(MarkAsReadRequest) updates) =>
      super.copyWith((message) => updates(message as MarkAsReadRequest))
          as MarkAsReadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarkAsReadRequest create() => MarkAsReadRequest._();
  @$core.override
  MarkAsReadRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MarkAsReadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarkAsReadRequest>(create);
  static MarkAsReadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get notificationIds => $_getList(0);
}

class GetUnreadCountResponse extends $pb.GeneratedMessage {
  factory GetUnreadCountResponse({
    $core.int? count,
  }) {
    final result = create();
    if (count != null) result.count = count;
    return result;
  }

  GetUnreadCountResponse._();

  factory GetUnreadCountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUnreadCountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUnreadCountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUnreadCountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUnreadCountResponse copyWith(
          void Function(GetUnreadCountResponse) updates) =>
      super.copyWith((message) => updates(message as GetUnreadCountResponse))
          as GetUnreadCountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUnreadCountResponse create() => GetUnreadCountResponse._();
  @$core.override
  GetUnreadCountResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUnreadCountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUnreadCountResponse>(create);
  static GetUnreadCountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get count => $_getIZ(0);
  @$pb.TagNumber(1)
  set count($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearCount() => $_clearField(1);
}

class DeleteNotificationRequest extends $pb.GeneratedMessage {
  factory DeleteNotificationRequest({
    $core.String? notificationId,
  }) {
    final result = create();
    if (notificationId != null) result.notificationId = notificationId;
    return result;
  }

  DeleteNotificationRequest._();

  factory DeleteNotificationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteNotificationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteNotificationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'notifications'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'notificationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteNotificationRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteNotificationRequest copyWith(
          void Function(DeleteNotificationRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteNotificationRequest))
          as DeleteNotificationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteNotificationRequest create() => DeleteNotificationRequest._();
  @$core.override
  DeleteNotificationRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteNotificationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteNotificationRequest>(create);
  static DeleteNotificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get notificationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set notificationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNotificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotificationId() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
