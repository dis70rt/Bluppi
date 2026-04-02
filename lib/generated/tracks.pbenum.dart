// This is a generated file - do not edit.
//
// Generated from tracks.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TimeRange extends $pb.ProtobufEnum {
  static const TimeRange TIME_RANGE_ALL_TIME =
      TimeRange._(0, _omitEnumNames ? '' : 'TIME_RANGE_ALL_TIME');
  static const TimeRange TIME_RANGE_LAST_7_DAYS =
      TimeRange._(1, _omitEnumNames ? '' : 'TIME_RANGE_LAST_7_DAYS');
  static const TimeRange TIME_RANGE_LAST_30_DAYS =
      TimeRange._(2, _omitEnumNames ? '' : 'TIME_RANGE_LAST_30_DAYS');

  static const $core.List<TimeRange> values = <TimeRange>[
    TIME_RANGE_ALL_TIME,
    TIME_RANGE_LAST_7_DAYS,
    TIME_RANGE_LAST_30_DAYS,
  ];

  static final $core.List<TimeRange?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static TimeRange? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TimeRange._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
