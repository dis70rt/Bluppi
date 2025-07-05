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

import 'package:protobuf/protobuf.dart' as $pb;

class HostPlaybackCommand_CommandType extends $pb.ProtobufEnum {
  static const HostPlaybackCommand_CommandType PLAY = HostPlaybackCommand_CommandType._(0, _omitEnumNames ? '' : 'PLAY');
  static const HostPlaybackCommand_CommandType PAUSE = HostPlaybackCommand_CommandType._(1, _omitEnumNames ? '' : 'PAUSE');
  static const HostPlaybackCommand_CommandType SEEK = HostPlaybackCommand_CommandType._(2, _omitEnumNames ? '' : 'SEEK');
  static const HostPlaybackCommand_CommandType TRACK_CHANGE = HostPlaybackCommand_CommandType._(3, _omitEnumNames ? '' : 'TRACK_CHANGE');
  static const HostPlaybackCommand_CommandType ADJUST_RATE = HostPlaybackCommand_CommandType._(4, _omitEnumNames ? '' : 'ADJUST_RATE');

  static const $core.List<HostPlaybackCommand_CommandType> values = <HostPlaybackCommand_CommandType> [
    PLAY,
    PAUSE,
    SEEK,
    TRACK_CHANGE,
    ADJUST_RATE,
  ];

  static final $core.List<HostPlaybackCommand_CommandType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 4);
  static HostPlaybackCommand_CommandType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HostPlaybackCommand_CommandType._(super.value, super.name);
}

class MemberStatus_StatusType extends $pb.ProtobufEnum {
  static const MemberStatus_StatusType JOINED = MemberStatus_StatusType._(0, _omitEnumNames ? '' : 'JOINED');
  static const MemberStatus_StatusType TRACK_LOADED = MemberStatus_StatusType._(1, _omitEnumNames ? '' : 'TRACK_LOADED');
  static const MemberStatus_StatusType READY_TO_PLAY = MemberStatus_StatusType._(2, _omitEnumNames ? '' : 'READY_TO_PLAY');
  static const MemberStatus_StatusType PLAYING = MemberStatus_StatusType._(3, _omitEnumNames ? '' : 'PLAYING');
  static const MemberStatus_StatusType PAUSED = MemberStatus_StatusType._(4, _omitEnumNames ? '' : 'PAUSED');
  static const MemberStatus_StatusType SYNCING = MemberStatus_StatusType._(5, _omitEnumNames ? '' : 'SYNCING');
  static const MemberStatus_StatusType SYNCED = MemberStatus_StatusType._(6, _omitEnumNames ? '' : 'SYNCED');
  static const MemberStatus_StatusType DESYNC = MemberStatus_StatusType._(7, _omitEnumNames ? '' : 'DESYNC');
  static const MemberStatus_StatusType ERROR = MemberStatus_StatusType._(8, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<MemberStatus_StatusType> values = <MemberStatus_StatusType> [
    JOINED,
    TRACK_LOADED,
    READY_TO_PLAY,
    PLAYING,
    PAUSED,
    SYNCING,
    SYNCED,
    DESYNC,
    ERROR,
  ];

  static final $core.List<MemberStatus_StatusType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 8);
  static MemberStatus_StatusType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MemberStatus_StatusType._(super.value, super.name);
}

class ServerBroadcast_BroadcastType extends $pb.ProtobufEnum {
  static const ServerBroadcast_BroadcastType TRACK_COMMAND = ServerBroadcast_BroadcastType._(0, _omitEnumNames ? '' : 'TRACK_COMMAND');
  static const ServerBroadcast_BroadcastType POSITION_UPDATE = ServerBroadcast_BroadcastType._(1, _omitEnumNames ? '' : 'POSITION_UPDATE');
  static const ServerBroadcast_BroadcastType CONTROL_COMMAND = ServerBroadcast_BroadcastType._(2, _omitEnumNames ? '' : 'CONTROL_COMMAND');
  static const ServerBroadcast_BroadcastType HOST_CHANGED = ServerBroadcast_BroadcastType._(3, _omitEnumNames ? '' : 'HOST_CHANGED');
  static const ServerBroadcast_BroadcastType MEMBER_JOINED = ServerBroadcast_BroadcastType._(4, _omitEnumNames ? '' : 'MEMBER_JOINED');
  static const ServerBroadcast_BroadcastType MEMBER_LEFT = ServerBroadcast_BroadcastType._(5, _omitEnumNames ? '' : 'MEMBER_LEFT');

  static const $core.List<ServerBroadcast_BroadcastType> values = <ServerBroadcast_BroadcastType> [
    TRACK_COMMAND,
    POSITION_UPDATE,
    CONTROL_COMMAND,
    HOST_CHANGED,
    MEMBER_JOINED,
    MEMBER_LEFT,
  ];

  static final $core.List<ServerBroadcast_BroadcastType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 5);
  static ServerBroadcast_BroadcastType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServerBroadcast_BroadcastType._(super.value, super.name);
}

class ServerResponse_ResponseType extends $pb.ProtobufEnum {
  static const ServerResponse_ResponseType ACKNOWLEDGED = ServerResponse_ResponseType._(0, _omitEnumNames ? '' : 'ACKNOWLEDGED');
  static const ServerResponse_ResponseType MEMBER_COUNT_UPDATE = ServerResponse_ResponseType._(1, _omitEnumNames ? '' : 'MEMBER_COUNT_UPDATE');
  static const ServerResponse_ResponseType MEMBER_STATUS_UPDATE = ServerResponse_ResponseType._(2, _omitEnumNames ? '' : 'MEMBER_STATUS_UPDATE');
  static const ServerResponse_ResponseType ERROR = ServerResponse_ResponseType._(3, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<ServerResponse_ResponseType> values = <ServerResponse_ResponseType> [
    ACKNOWLEDGED,
    MEMBER_COUNT_UPDATE,
    MEMBER_STATUS_UPDATE,
    ERROR,
  ];

  static final $core.List<ServerResponse_ResponseType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ServerResponse_ResponseType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ServerResponse_ResponseType._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
