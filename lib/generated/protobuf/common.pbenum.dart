//
//  Generated code. Do not modify.
//  source: protobuf/common.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RoomStatus extends $pb.ProtobufEnum {
  static const RoomStatus ACTIVE = RoomStatus._(0, _omitEnumNames ? '' : 'ACTIVE');
  static const RoomStatus INACTIVE = RoomStatus._(1, _omitEnumNames ? '' : 'INACTIVE');
  static const RoomStatus CLOSED = RoomStatus._(2, _omitEnumNames ? '' : 'CLOSED');

  static const $core.List<RoomStatus> values = <RoomStatus> [
    ACTIVE,
    INACTIVE,
    CLOSED,
  ];

  static final $core.List<RoomStatus?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RoomStatus? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomStatus._(super.value, super.name);
}

class RoomVisibility extends $pb.ProtobufEnum {
  static const RoomVisibility PUBLIC = RoomVisibility._(0, _omitEnumNames ? '' : 'PUBLIC');
  static const RoomVisibility PRIVATE = RoomVisibility._(1, _omitEnumNames ? '' : 'PRIVATE');

  static const $core.List<RoomVisibility> values = <RoomVisibility> [
    PUBLIC,
    PRIVATE,
  ];

  static final $core.List<RoomVisibility?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 1);
  static RoomVisibility? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomVisibility._(super.value, super.name);
}

class RoomMemberRole extends $pb.ProtobufEnum {
  static const RoomMemberRole HOST = RoomMemberRole._(0, _omitEnumNames ? '' : 'HOST');
  static const RoomMemberRole MODERATOR = RoomMemberRole._(1, _omitEnumNames ? '' : 'MODERATOR');
  static const RoomMemberRole PARTICIPANT = RoomMemberRole._(2, _omitEnumNames ? '' : 'PARTICIPANT');

  static const $core.List<RoomMemberRole> values = <RoomMemberRole> [
    HOST,
    MODERATOR,
    PARTICIPANT,
  ];

  static final $core.List<RoomMemberRole?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static RoomMemberRole? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RoomMemberRole._(super.value, super.name);
}

class PlaybackStatus extends $pb.ProtobufEnum {
  static const PlaybackStatus PLAYING = PlaybackStatus._(0, _omitEnumNames ? '' : 'PLAYING');
  static const PlaybackStatus PAUSED = PlaybackStatus._(1, _omitEnumNames ? '' : 'PAUSED');

  static const $core.List<PlaybackStatus> values = <PlaybackStatus> [
    PLAYING,
    PAUSED,
  ];

  static final $core.List<PlaybackStatus?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 1);
  static PlaybackStatus? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PlaybackStatus._(super.value, super.name);
}

class EventType extends $pb.ProtobufEnum {
  static const EventType PLAY = EventType._(0, _omitEnumNames ? '' : 'PLAY');
  static const EventType PAUSE = EventType._(1, _omitEnumNames ? '' : 'PAUSE');
  static const EventType SEEK = EventType._(2, _omitEnumNames ? '' : 'SEEK');
  static const EventType SKIP = EventType._(3, _omitEnumNames ? '' : 'SKIP');

  static const $core.List<EventType> values = <EventType> [
    PLAY,
    PAUSE,
    SEEK,
    SKIP,
  ];

  static final $core.List<EventType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static EventType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EventType._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
