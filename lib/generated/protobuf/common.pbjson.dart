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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use roomStatusDescriptor instead')
const RoomStatus$json = {
  '1': 'RoomStatus',
  '2': [
    {'1': 'ACTIVE', '2': 0},
    {'1': 'INACTIVE', '2': 1},
    {'1': 'CLOSED', '2': 2},
  ],
};

/// Descriptor for `RoomStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomStatusDescriptor = $convert.base64Decode(
    'CgpSb29tU3RhdHVzEgoKBkFDVElWRRAAEgwKCElOQUNUSVZFEAESCgoGQ0xPU0VEEAI=');

@$core.Deprecated('Use roomVisibilityDescriptor instead')
const RoomVisibility$json = {
  '1': 'RoomVisibility',
  '2': [
    {'1': 'PUBLIC', '2': 0},
    {'1': 'PRIVATE', '2': 1},
  ],
};

/// Descriptor for `RoomVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomVisibilityDescriptor = $convert.base64Decode(
    'Cg5Sb29tVmlzaWJpbGl0eRIKCgZQVUJMSUMQABILCgdQUklWQVRFEAE=');

@$core.Deprecated('Use roomMemberRoleDescriptor instead')
const RoomMemberRole$json = {
  '1': 'RoomMemberRole',
  '2': [
    {'1': 'HOST', '2': 0},
    {'1': 'MODERATOR', '2': 1},
    {'1': 'PARTICIPANT', '2': 2},
  ],
};

/// Descriptor for `RoomMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomMemberRoleDescriptor = $convert.base64Decode(
    'Cg5Sb29tTWVtYmVyUm9sZRIICgRIT1NUEAASDQoJTU9ERVJBVE9SEAESDwoLUEFSVElDSVBBTl'
    'QQAg==');

@$core.Deprecated('Use playbackStatusDescriptor instead')
const PlaybackStatus$json = {
  '1': 'PlaybackStatus',
  '2': [
    {'1': 'PLAYING', '2': 0},
    {'1': 'PAUSED', '2': 1},
  ],
};

/// Descriptor for `PlaybackStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playbackStatusDescriptor = $convert.base64Decode(
    'Cg5QbGF5YmFja1N0YXR1cxILCgdQTEFZSU5HEAASCgoGUEFVU0VEEAE=');

@$core.Deprecated('Use eventTypeDescriptor instead')
const EventType$json = {
  '1': 'EventType',
  '2': [
    {'1': 'PLAY', '2': 0},
    {'1': 'PAUSE', '2': 1},
    {'1': 'SEEK', '2': 2},
    {'1': 'SKIP', '2': 3},
  ],
};

/// Descriptor for `EventType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List eventTypeDescriptor = $convert.base64Decode(
    'CglFdmVudFR5cGUSCAoEUExBWRAAEgkKBVBBVVNFEAESCAoEU0VFSxACEggKBFNLSVAQAw==');

