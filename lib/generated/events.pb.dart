// This is a generated file - do not edit.
//
// Generated from events.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserFollowedEvent extends $pb.GeneratedMessage {
  factory UserFollowedEvent({
    $core.String? followerId,
    $core.String? followerName,
    $core.String? followerAvatar,
    $core.String? followeeId,
    $0.Timestamp? occurredAt,
  }) {
    final result = create();
    if (followerId != null) result.followerId = followerId;
    if (followerName != null) result.followerName = followerName;
    if (followerAvatar != null) result.followerAvatar = followerAvatar;
    if (followeeId != null) result.followeeId = followeeId;
    if (occurredAt != null) result.occurredAt = occurredAt;
    return result;
  }

  UserFollowedEvent._();

  factory UserFollowedEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserFollowedEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserFollowedEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'events'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'followerId')
    ..aOS(2, _omitFieldNames ? '' : 'followerName')
    ..aOS(3, _omitFieldNames ? '' : 'followerAvatar')
    ..aOS(4, _omitFieldNames ? '' : 'followeeId')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'occurredAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFollowedEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserFollowedEvent copyWith(void Function(UserFollowedEvent) updates) =>
      super.copyWith((message) => updates(message as UserFollowedEvent))
          as UserFollowedEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserFollowedEvent create() => UserFollowedEvent._();
  @$core.override
  UserFollowedEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserFollowedEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFollowedEvent>(create);
  static UserFollowedEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get followerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set followerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFollowerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFollowerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get followerName => $_getSZ(1);
  @$pb.TagNumber(2)
  set followerName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFollowerName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFollowerName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get followerAvatar => $_getSZ(2);
  @$pb.TagNumber(3)
  set followerAvatar($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFollowerAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearFollowerAvatar() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get followeeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set followeeId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFolloweeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFolloweeId() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get occurredAt => $_getN(4);
  @$pb.TagNumber(5)
  set occurredAt($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasOccurredAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearOccurredAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureOccurredAt() => $_ensure(4);
}

class PartyInviteEvent extends $pb.GeneratedMessage {
  factory PartyInviteEvent({
    $core.String? roomId,
    $core.String? roomName,
    $core.String? inviterId,
    $core.String? inviterName,
    $core.String? inviterAvatar,
    $core.String? targetUserId,
    $0.Timestamp? occurredAt,
  }) {
    final result = create();
    if (roomId != null) result.roomId = roomId;
    if (roomName != null) result.roomName = roomName;
    if (inviterId != null) result.inviterId = inviterId;
    if (inviterName != null) result.inviterName = inviterName;
    if (inviterAvatar != null) result.inviterAvatar = inviterAvatar;
    if (targetUserId != null) result.targetUserId = targetUserId;
    if (occurredAt != null) result.occurredAt = occurredAt;
    return result;
  }

  PartyInviteEvent._();

  factory PartyInviteEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PartyInviteEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PartyInviteEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'events'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'roomId')
    ..aOS(2, _omitFieldNames ? '' : 'roomName')
    ..aOS(3, _omitFieldNames ? '' : 'inviterId')
    ..aOS(4, _omitFieldNames ? '' : 'inviterName')
    ..aOS(5, _omitFieldNames ? '' : 'inviterAvatar')
    ..aOS(6, _omitFieldNames ? '' : 'targetUserId')
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'occurredAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PartyInviteEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PartyInviteEvent copyWith(void Function(PartyInviteEvent) updates) =>
      super.copyWith((message) => updates(message as PartyInviteEvent))
          as PartyInviteEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PartyInviteEvent create() => PartyInviteEvent._();
  @$core.override
  PartyInviteEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PartyInviteEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PartyInviteEvent>(create);
  static PartyInviteEvent? _defaultInstance;

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
  $core.String get inviterId => $_getSZ(2);
  @$pb.TagNumber(3)
  set inviterId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInviterId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInviterId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get inviterName => $_getSZ(3);
  @$pb.TagNumber(4)
  set inviterName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInviterName() => $_has(3);
  @$pb.TagNumber(4)
  void clearInviterName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get inviterAvatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set inviterAvatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInviterAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearInviterAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get targetUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set targetUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTargetUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetUserId() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.Timestamp get occurredAt => $_getN(6);
  @$pb.TagNumber(7)
  set occurredAt($0.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasOccurredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearOccurredAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureOccurredAt() => $_ensure(6);
}

class FollowerListeningEvent extends $pb.GeneratedMessage {
  factory FollowerListeningEvent({
    $core.String? broadcasterId,
    $core.String? broadcasterName,
    $core.String? roomId,
    $core.String? trackName,
    $core.Iterable<$core.String>? targetFollowerIds,
    $0.Timestamp? occurredAt,
  }) {
    final result = create();
    if (broadcasterId != null) result.broadcasterId = broadcasterId;
    if (broadcasterName != null) result.broadcasterName = broadcasterName;
    if (roomId != null) result.roomId = roomId;
    if (trackName != null) result.trackName = trackName;
    if (targetFollowerIds != null)
      result.targetFollowerIds.addAll(targetFollowerIds);
    if (occurredAt != null) result.occurredAt = occurredAt;
    return result;
  }

  FollowerListeningEvent._();

  factory FollowerListeningEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FollowerListeningEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FollowerListeningEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'events'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'broadcasterId')
    ..aOS(2, _omitFieldNames ? '' : 'broadcasterName')
    ..aOS(3, _omitFieldNames ? '' : 'roomId')
    ..aOS(4, _omitFieldNames ? '' : 'trackName')
    ..pPS(5, _omitFieldNames ? '' : 'targetFollowerIds')
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'occurredAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FollowerListeningEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FollowerListeningEvent copyWith(
          void Function(FollowerListeningEvent) updates) =>
      super.copyWith((message) => updates(message as FollowerListeningEvent))
          as FollowerListeningEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FollowerListeningEvent create() => FollowerListeningEvent._();
  @$core.override
  FollowerListeningEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FollowerListeningEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FollowerListeningEvent>(create);
  static FollowerListeningEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get broadcasterId => $_getSZ(0);
  @$pb.TagNumber(1)
  set broadcasterId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBroadcasterId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBroadcasterId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get broadcasterName => $_getSZ(1);
  @$pb.TagNumber(2)
  set broadcasterName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBroadcasterName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBroadcasterName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get roomId => $_getSZ(2);
  @$pb.TagNumber(3)
  set roomId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRoomId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoomId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get trackName => $_getSZ(3);
  @$pb.TagNumber(4)
  set trackName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTrackName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrackName() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get targetFollowerIds => $_getList(4);

  @$pb.TagNumber(6)
  $0.Timestamp get occurredAt => $_getN(5);
  @$pb.TagNumber(6)
  set occurredAt($0.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOccurredAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearOccurredAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureOccurredAt() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
