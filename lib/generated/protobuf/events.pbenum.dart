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

import 'package:protobuf/protobuf.dart' as $pb;

class RoomEvent_EventCategory extends $pb.ProtobufEnum {
  static const RoomEvent_EventCategory EVENT_CATEGORY_UNSPECIFIED = RoomEvent_EventCategory._(0, _omitEnumNames ? '' : 'EVENT_CATEGORY_UNSPECIFIED');
  static const RoomEvent_EventCategory USER_JOINED = RoomEvent_EventCategory._(1, _omitEnumNames ? '' : 'USER_JOINED');
  static const RoomEvent_EventCategory USER_LEFT = RoomEvent_EventCategory._(2, _omitEnumNames ? '' : 'USER_LEFT');
  static const RoomEvent_EventCategory ROOM_SETTINGS_UPDATED = RoomEvent_EventCategory._(3, _omitEnumNames ? '' : 'ROOM_SETTINGS_UPDATED');

  static const $core.List<RoomEvent_EventCategory> values = <RoomEvent_EventCategory> [
    EVENT_CATEGORY_UNSPECIFIED,
    USER_JOINED,
    USER_LEFT,
    ROOM_SETTINGS_UPDATED,
  ];

  static final $core.List<RoomEvent_EventCategory?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RoomEvent_EventCategory? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomEvent_EventCategory._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
