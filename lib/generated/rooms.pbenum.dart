// This is a generated file - do not edit.
//
// Generated from rooms.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RoomStatus extends $pb.ProtobufEnum {
  static const RoomStatus ROOM_STATUS_UNSPECIFIED =
      RoomStatus._(0, _omitEnumNames ? '' : 'ROOM_STATUS_UNSPECIFIED');
  static const RoomStatus ROOM_STATUS_ACTIVE =
      RoomStatus._(1, _omitEnumNames ? '' : 'ROOM_STATUS_ACTIVE');
  static const RoomStatus ROOM_STATUS_ENDED =
      RoomStatus._(2, _omitEnumNames ? '' : 'ROOM_STATUS_ENDED');

  static const $core.List<RoomStatus> values = <RoomStatus>[
    ROOM_STATUS_UNSPECIFIED,
    ROOM_STATUS_ACTIVE,
    ROOM_STATUS_ENDED,
  ];

  static final $core.List<RoomStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RoomStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomStatus._(super.value, super.name);
}

class RoomVisibility extends $pb.ProtobufEnum {
  static const RoomVisibility ROOM_VISIBILITY_UNSPECIFIED =
      RoomVisibility._(0, _omitEnumNames ? '' : 'ROOM_VISIBILITY_UNSPECIFIED');
  static const RoomVisibility ROOM_VISIBILITY_PUBLIC =
      RoomVisibility._(1, _omitEnumNames ? '' : 'ROOM_VISIBILITY_PUBLIC');
  static const RoomVisibility ROOM_VISIBILITY_PRIVATE =
      RoomVisibility._(2, _omitEnumNames ? '' : 'ROOM_VISIBILITY_PRIVATE');

  static const $core.List<RoomVisibility> values = <RoomVisibility>[
    ROOM_VISIBILITY_UNSPECIFIED,
    ROOM_VISIBILITY_PUBLIC,
    ROOM_VISIBILITY_PRIVATE,
  ];

  static final $core.List<RoomVisibility?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RoomVisibility? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomVisibility._(super.value, super.name);
}

class RoomMemberRole extends $pb.ProtobufEnum {
  static const RoomMemberRole ROOM_MEMBER_ROLE_UNSPECIFIED =
      RoomMemberRole._(0, _omitEnumNames ? '' : 'ROOM_MEMBER_ROLE_UNSPECIFIED');
  static const RoomMemberRole ROOM_MEMBER_ROLE_HOST =
      RoomMemberRole._(1, _omitEnumNames ? '' : 'ROOM_MEMBER_ROLE_HOST');
  static const RoomMemberRole ROOM_MEMBER_ROLE_LISTENER =
      RoomMemberRole._(2, _omitEnumNames ? '' : 'ROOM_MEMBER_ROLE_LISTENER');

  static const $core.List<RoomMemberRole> values = <RoomMemberRole>[
    ROOM_MEMBER_ROLE_UNSPECIFIED,
    ROOM_MEMBER_ROLE_HOST,
    ROOM_MEMBER_ROLE_LISTENER,
  ];

  static final $core.List<RoomMemberRole?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RoomMemberRole? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomMemberRole._(super.value, super.name);
}

class RoomEventType extends $pb.ProtobufEnum {
  static const RoomEventType ROOM_EVENT_TYPE_UNSPECIFIED =
      RoomEventType._(0, _omitEnumNames ? '' : 'ROOM_EVENT_TYPE_UNSPECIFIED');
  static const RoomEventType ROOM_EVENT_TYPE_USER_JOINED =
      RoomEventType._(1, _omitEnumNames ? '' : 'ROOM_EVENT_TYPE_USER_JOINED');
  static const RoomEventType ROOM_EVENT_TYPE_USER_LEFT =
      RoomEventType._(2, _omitEnumNames ? '' : 'ROOM_EVENT_TYPE_USER_LEFT');
  static const RoomEventType ROOM_EVENT_TYPE_ROOM_ENDED =
      RoomEventType._(3, _omitEnumNames ? '' : 'ROOM_EVENT_TYPE_ROOM_ENDED');

  static const $core.List<RoomEventType> values = <RoomEventType>[
    ROOM_EVENT_TYPE_UNSPECIFIED,
    ROOM_EVENT_TYPE_USER_JOINED,
    ROOM_EVENT_TYPE_USER_LEFT,
    ROOM_EVENT_TYPE_ROOM_ENDED,
  ];

  static final $core.List<RoomEventType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RoomEventType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomEventType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
