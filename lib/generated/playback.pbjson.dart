// This is a generated file - do not edit.
//
// Generated from playback.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use clientCommandDescriptor instead')
const ClientCommand$json = {
  '1': 'ClientCommand',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'play',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.playback.PlayCommand',
      '9': 0,
      '10': 'play'
    },
    {
      '1': 'pause',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.playback.PauseCommand',
      '9': 0,
      '10': 'pause'
    },
    {
      '1': 'track_change',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.playback.TrackChangeCommand',
      '9': 0,
      '10': 'trackChange'
    },
    {
      '1': 'buffer_ready',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.playback.BufferReady',
      '9': 0,
      '10': 'bufferReady'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ClientCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientCommandDescriptor = $convert.base64Decode(
    'Cg1DbGllbnRDb21tYW5kEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAIgAS'
    'gJUgZ1c2VySWQSKwoEcGxheRgDIAEoCzIVLnBsYXliYWNrLlBsYXlDb21tYW5kSABSBHBsYXkS'
    'LgoFcGF1c2UYBCABKAsyFi5wbGF5YmFjay5QYXVzZUNvbW1hbmRIAFIFcGF1c2USQQoMdHJhY2'
    'tfY2hhbmdlGAUgASgLMhwucGxheWJhY2suVHJhY2tDaGFuZ2VDb21tYW5kSABSC3RyYWNrQ2hh'
    'bmdlEjoKDGJ1ZmZlcl9yZWFkeRgGIAEoCzIVLnBsYXliYWNrLkJ1ZmZlclJlYWR5SABSC2J1Zm'
    'ZlclJlYWR5QgkKB3BheWxvYWQ=');

@$core.Deprecated('Use playCommandDescriptor instead')
const PlayCommand$json = {
  '1': 'PlayCommand',
};

/// Descriptor for `PlayCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playCommandDescriptor =
    $convert.base64Decode('CgtQbGF5Q29tbWFuZA==');

@$core.Deprecated('Use pauseCommandDescriptor instead')
const PauseCommand$json = {
  '1': 'PauseCommand',
};

/// Descriptor for `PauseCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pauseCommandDescriptor =
    $convert.base64Decode('CgxQYXVzZUNvbW1hbmQ=');

@$core.Deprecated('Use trackChangeCommandDescriptor instead')
const TrackChangeCommand$json = {
  '1': 'TrackChangeCommand',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'audio_url', '3': 4, '4': 1, '5': 9, '10': 'audioUrl'},
    {'1': 'artwork_url', '3': 5, '4': 1, '5': 9, '10': 'artworkUrl'},
    {'1': 'duration_ms', '3': 6, '4': 1, '5': 3, '10': 'durationMs'},
  ],
};

/// Descriptor for `TrackChangeCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackChangeCommandDescriptor = $convert.base64Decode(
    'ChJUcmFja0NoYW5nZUNvbW1hbmQSGQoIdHJhY2tfaWQYASABKAlSB3RyYWNrSWQSFAoFdGl0bG'
    'UYAiABKAlSBXRpdGxlEhYKBmFydGlzdBgDIAEoCVIGYXJ0aXN0EhsKCWF1ZGlvX3VybBgEIAEo'
    'CVIIYXVkaW9VcmwSHwoLYXJ0d29ya191cmwYBSABKAlSCmFydHdvcmtVcmwSHwoLZHVyYXRpb2'
    '5fbXMYBiABKANSCmR1cmF0aW9uTXM=');

@$core.Deprecated('Use bufferReadyDescriptor instead')
const BufferReady$json = {
  '1': 'BufferReady',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 4, '10': 'version'},
  ],
};

/// Descriptor for `BufferReady`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bufferReadyDescriptor = $convert
    .base64Decode('CgtCdWZmZXJSZWFkeRIYCgd2ZXJzaW9uGAEgASgEUgd2ZXJzaW9u');

@$core.Deprecated('Use serverEventDescriptor instead')
const ServerEvent$json = {
  '1': 'ServerEvent',
  '2': [
    {
      '1': 'playback_state',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.playback.PlaybackState',
      '9': 0,
      '10': 'playbackState'
    },
    {
      '1': 'room_closed',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.playback.RoomClosed',
      '9': 0,
      '10': 'roomClosed'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `ServerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverEventDescriptor = $convert.base64Decode(
    'CgtTZXJ2ZXJFdmVudBJACg5wbGF5YmFja19zdGF0ZRgBIAEoCzIXLnBsYXliYWNrLlBsYXliYW'
    'NrU3RhdGVIAFINcGxheWJhY2tTdGF0ZRI3Cgtyb29tX2Nsb3NlZBgCIAEoCzIULnBsYXliYWNr'
    'LlJvb21DbG9zZWRIAFIKcm9vbUNsb3NlZEIJCgdwYXlsb2Fk');

@$core.Deprecated('Use roomClosedDescriptor instead')
const RoomClosed$json = {
  '1': 'RoomClosed',
};

/// Descriptor for `RoomClosed`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomClosedDescriptor =
    $convert.base64Decode('CgpSb29tQ2xvc2Vk');

@$core.Deprecated('Use playbackStateDescriptor instead')
const PlaybackState$json = {
  '1': 'PlaybackState',
  '2': [
    {
      '1': 'track',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.playback.TrackInfo',
      '10': 'track'
    },
    {'1': 'is_playing', '3': 2, '4': 1, '5': 8, '10': 'isPlaying'},
    {'1': 'position_ms', '3': 3, '4': 1, '5': 3, '10': 'positionMs'},
    {
      '1': 'last_update_server_us',
      '3': 4,
      '4': 1,
      '5': 3,
      '10': 'lastUpdateServerUs'
    },
    {
      '1': 'scheduled_start_server_us',
      '3': 5,
      '4': 1,
      '5': 3,
      '10': 'scheduledStartServerUs'
    },
    {'1': 'version', '3': 6, '4': 1, '5': 4, '10': 'version'},
  ],
};

/// Descriptor for `PlaybackState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackStateDescriptor = $convert.base64Decode(
    'Cg1QbGF5YmFja1N0YXRlEikKBXRyYWNrGAEgASgLMhMucGxheWJhY2suVHJhY2tJbmZvUgV0cm'
    'FjaxIdCgppc19wbGF5aW5nGAIgASgIUglpc1BsYXlpbmcSHwoLcG9zaXRpb25fbXMYAyABKANS'
    'CnBvc2l0aW9uTXMSMQoVbGFzdF91cGRhdGVfc2VydmVyX3VzGAQgASgDUhJsYXN0VXBkYXRlU2'
    'VydmVyVXMSOQoZc2NoZWR1bGVkX3N0YXJ0X3NlcnZlcl91cxgFIAEoA1IWc2NoZWR1bGVkU3Rh'
    'cnRTZXJ2ZXJVcxIYCgd2ZXJzaW9uGAYgASgEUgd2ZXJzaW9u');

@$core.Deprecated('Use trackInfoDescriptor instead')
const TrackInfo$json = {
  '1': 'TrackInfo',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'audio_url', '3': 4, '4': 1, '5': 9, '10': 'audioUrl'},
    {'1': 'artwork_url', '3': 5, '4': 1, '5': 9, '10': 'artworkUrl'},
    {'1': 'duration_ms', '3': 6, '4': 1, '5': 3, '10': 'durationMs'},
  ],
};

/// Descriptor for `TrackInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackInfoDescriptor = $convert.base64Decode(
    'CglUcmFja0luZm8SGQoIdHJhY2tfaWQYASABKAlSB3RyYWNrSWQSFAoFdGl0bGUYAiABKAlSBX'
    'RpdGxlEhYKBmFydGlzdBgDIAEoCVIGYXJ0aXN0EhsKCWF1ZGlvX3VybBgEIAEoCVIIYXVkaW9V'
    'cmwSHwoLYXJ0d29ya191cmwYBSABKAlSCmFydHdvcmtVcmwSHwoLZHVyYXRpb25fbXMYBiABKA'
    'NSCmR1cmF0aW9uTXM=');
