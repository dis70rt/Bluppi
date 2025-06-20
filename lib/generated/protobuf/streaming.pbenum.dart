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

class PlaybackCommand_CommandType extends $pb.ProtobufEnum {
  static const PlaybackCommand_CommandType PLAY = PlaybackCommand_CommandType._(0, _omitEnumNames ? '' : 'PLAY');
  static const PlaybackCommand_CommandType PAUSE = PlaybackCommand_CommandType._(1, _omitEnumNames ? '' : 'PAUSE');
  static const PlaybackCommand_CommandType SEEK = PlaybackCommand_CommandType._(2, _omitEnumNames ? '' : 'SEEK');
  static const PlaybackCommand_CommandType TRACK_CHANGE = PlaybackCommand_CommandType._(3, _omitEnumNames ? '' : 'TRACK_CHANGE');
  static const PlaybackCommand_CommandType ADJUST_RATE = PlaybackCommand_CommandType._(4, _omitEnumNames ? '' : 'ADJUST_RATE');

  static const $core.List<PlaybackCommand_CommandType> values = <PlaybackCommand_CommandType> [
    PLAY,
    PAUSE,
    SEEK,
    TRACK_CHANGE,
    ADJUST_RATE,
  ];

  static final $core.List<PlaybackCommand_CommandType?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 4);
  static PlaybackCommand_CommandType? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PlaybackCommand_CommandType._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
