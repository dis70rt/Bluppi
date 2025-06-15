//
//  Generated code. Do not modify.
//  source: protobuf/playback.proto
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

@$core.Deprecated('Use playbackStateDescriptor instead')
const PlaybackState$json = {
  '1': 'PlaybackState',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'current_track_id', '3': 2, '4': 1, '5': 9, '10': 'currentTrackId'},
    {'1': 'position_ms', '3': 3, '4': 1, '5': 5, '10': 'positionMs'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.ListeningParty.PlaybackStatus', '10': 'status'},
    {'1': 'updated_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
  ],
};

/// Descriptor for `PlaybackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackStateDescriptor = $convert.base64Decode(
    'Cg1QbGF5YmFja1N0YXRlEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIoChBjdXJyZW50X3RyYW'
    'NrX2lkGAIgASgJUg5jdXJyZW50VHJhY2tJZBIfCgtwb3NpdGlvbl9tcxgDIAEoBVIKcG9zaXRp'
    'b25NcxI2CgZzdGF0dXMYBCABKA4yHi5MaXN0ZW5pbmdQYXJ0eS5QbGF5YmFja1N0YXR1c1IGc3'
    'RhdHVzEjkKCnVwZGF0ZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1'
    'cGRhdGVkQXQ=');

@$core.Deprecated('Use playRequestDescriptor instead')
const PlayRequest$json = {
  '1': 'PlayRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'position_ms', '3': 3, '4': 1, '5': 5, '10': 'positionMs'},
  ],
};

/// Descriptor for `PlayRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playRequestDescriptor = $convert.base64Decode(
    'CgtQbGF5UmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSGQoIdHJhY2tfaWQYAiABKA'
    'lSB3RyYWNrSWQSHwoLcG9zaXRpb25fbXMYAyABKAVSCnBvc2l0aW9uTXM=');

@$core.Deprecated('Use pauseRequestDescriptor instead')
const PauseRequest$json = {
  '1': 'PauseRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `PauseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseRequestDescriptor = $convert.base64Decode(
    'CgxQYXVzZVJlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlk');

@$core.Deprecated('Use seekRequestDescriptor instead')
const SeekRequest$json = {
  '1': 'SeekRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'position_ms', '3': 2, '4': 1, '5': 5, '10': 'positionMs'},
  ],
};

/// Descriptor for `SeekRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seekRequestDescriptor = $convert.base64Decode(
    'CgtTZWVrUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSHwoLcG9zaXRpb25fbXMYAi'
    'ABKAVSCnBvc2l0aW9uTXM=');

@$core.Deprecated('Use skipRequestDescriptor instead')
const SkipRequest$json = {
  '1': 'SkipRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `SkipRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipRequestDescriptor = $convert.base64Decode(
    'CgtTa2lwUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use getPlaybackStateRequestDescriptor instead')
const GetPlaybackStateRequest$json = {
  '1': 'GetPlaybackStateRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `GetPlaybackStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPlaybackStateRequestDescriptor = $convert.base64Decode(
    'ChdHZXRQbGF5YmFja1N0YXRlUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use syncPlaybackRequestDescriptor instead')
const SyncPlaybackRequest$json = {
  '1': 'SyncPlaybackRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `SyncPlaybackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncPlaybackRequestDescriptor = $convert.base64Decode(
    'ChNTeW5jUGxheWJhY2tSZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2'
    'lkGAIgASgJUgZ1c2VySWQ=');

