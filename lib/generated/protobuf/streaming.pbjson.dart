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

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use syncMeasurementDescriptor instead')
const SyncMeasurement$json = {
  '1': 'SyncMeasurement',
  '2': [
    {'1': 'client_send_ms', '3': 1, '4': 1, '5': 3, '10': 'clientSendMs'},
    {'1': 'server_receive_ms', '3': 2, '4': 1, '5': 3, '10': 'serverReceiveMs'},
    {'1': 'server_send_ms', '3': 3, '4': 1, '5': 3, '10': 'serverSendMs'},
    {'1': 'client_receive_ms', '3': 4, '4': 1, '5': 3, '10': 'clientReceiveMs'},
    {'1': 'client_id', '3': 5, '4': 1, '5': 9, '10': 'clientId'},
  ],
};

/// Descriptor for `SyncMeasurement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncMeasurementDescriptor = $convert.base64Decode(
    'Cg9TeW5jTWVhc3VyZW1lbnQSJAoOY2xpZW50X3NlbmRfbXMYASABKANSDGNsaWVudFNlbmRNcx'
    'IqChFzZXJ2ZXJfcmVjZWl2ZV9tcxgCIAEoA1IPc2VydmVyUmVjZWl2ZU1zEiQKDnNlcnZlcl9z'
    'ZW5kX21zGAMgASgDUgxzZXJ2ZXJTZW5kTXMSKgoRY2xpZW50X3JlY2VpdmVfbXMYBCABKANSD2'
    'NsaWVudFJlY2VpdmVNcxIbCgljbGllbnRfaWQYBSABKAlSCGNsaWVudElk');

@$core.Deprecated('Use syncResponseDescriptor instead')
const SyncResponse$json = {
  '1': 'SyncResponse',
  '2': [
    {'1': 'server_timestamp_ms', '3': 1, '4': 1, '5': 3, '10': 'serverTimestampMs'},
    {'1': 'recommended_adjustment', '3': 2, '4': 1, '5': 2, '10': 'recommendedAdjustment'},
    {'1': 'estimated_offset_ms', '3': 3, '4': 1, '5': 5, '10': 'estimatedOffsetMs'},
  ],
};

/// Descriptor for `SyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncResponseDescriptor = $convert.base64Decode(
    'CgxTeW5jUmVzcG9uc2USLgoTc2VydmVyX3RpbWVzdGFtcF9tcxgBIAEoA1IRc2VydmVyVGltZX'
    'N0YW1wTXMSNQoWcmVjb21tZW5kZWRfYWRqdXN0bWVudBgCIAEoAlIVcmVjb21tZW5kZWRBZGp1'
    'c3RtZW50Ei4KE2VzdGltYXRlZF9vZmZzZXRfbXMYAyABKAVSEWVzdGltYXRlZE9mZnNldE1z');

@$core.Deprecated('Use playbackCommandDescriptor instead')
const PlaybackCommand$json = {
  '1': 'PlaybackCommand',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.ListeningParty.PlaybackCommand.CommandType', '10': 'type'},
    {'1': 'server_timestamp_ms', '3': 2, '4': 1, '5': 3, '10': 'serverTimestampMs'},
    {'1': 'position_ms', '3': 3, '4': 1, '5': 3, '10': 'positionMs'},
    {'1': 'track', '3': 4, '4': 1, '5': 11, '6': '.ListeningParty.Track', '10': 'track'},
    {'1': 'playback_rate', '3': 5, '4': 1, '5': 2, '10': 'playbackRate'},
  ],
  '4': [PlaybackCommand_CommandType$json],
};

@$core.Deprecated('Use playbackCommandDescriptor instead')
const PlaybackCommand_CommandType$json = {
  '1': 'CommandType',
  '2': [
    {'1': 'PLAY', '2': 0},
    {'1': 'PAUSE', '2': 1},
    {'1': 'SEEK', '2': 2},
    {'1': 'TRACK_CHANGE', '2': 3},
    {'1': 'ADJUST_RATE', '2': 4},
  ],
};

/// Descriptor for `PlaybackCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackCommandDescriptor = $convert.base64Decode(
    'Cg9QbGF5YmFja0NvbW1hbmQSPwoEdHlwZRgBIAEoDjIrLkxpc3RlbmluZ1BhcnR5LlBsYXliYW'
    'NrQ29tbWFuZC5Db21tYW5kVHlwZVIEdHlwZRIuChNzZXJ2ZXJfdGltZXN0YW1wX21zGAIgASgD'
    'UhFzZXJ2ZXJUaW1lc3RhbXBNcxIfCgtwb3NpdGlvbl9tcxgDIAEoA1IKcG9zaXRpb25NcxIrCg'
    'V0cmFjaxgEIAEoCzIVLkxpc3RlbmluZ1BhcnR5LlRyYWNrUgV0cmFjaxIjCg1wbGF5YmFja19y'
    'YXRlGAUgASgCUgxwbGF5YmFja1JhdGUiTwoLQ29tbWFuZFR5cGUSCAoEUExBWRAAEgkKBVBBVV'
    'NFEAESCAoEU0VFSxACEhAKDFRSQUNLX0NIQU5HRRADEg8KC0FESlVTVF9SQVRFEAQ=');

@$core.Deprecated('Use clientStateDescriptor instead')
const ClientState$json = {
  '1': 'ClientState',
  '2': [
    {'1': 'client_timestamp_ms', '3': 1, '4': 1, '5': 3, '10': 'clientTimestampMs'},
    {'1': 'playback_position_ms', '3': 2, '4': 1, '5': 3, '10': 'playbackPositionMs'},
    {'1': 'current_track_id', '3': 3, '4': 1, '5': 9, '10': 'currentTrackId'},
    {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.ListeningParty.PlaybackStatus', '10': 'status'},
    {'1': 'current_playback_rate', '3': 5, '4': 1, '5': 2, '10': 'currentPlaybackRate'},
    {'1': 'buffer_health_ms', '3': 6, '4': 1, '5': 5, '10': 'bufferHealthMs'},
  ],
};

/// Descriptor for `ClientState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientStateDescriptor = $convert.base64Decode(
    'CgtDbGllbnRTdGF0ZRIuChNjbGllbnRfdGltZXN0YW1wX21zGAEgASgDUhFjbGllbnRUaW1lc3'
    'RhbXBNcxIwChRwbGF5YmFja19wb3NpdGlvbl9tcxgCIAEoA1IScGxheWJhY2tQb3NpdGlvbk1z'
    'EigKEGN1cnJlbnRfdHJhY2tfaWQYAyABKAlSDmN1cnJlbnRUcmFja0lkEjYKBnN0YXR1cxgEIA'
    'EoDjIeLkxpc3RlbmluZ1BhcnR5LlBsYXliYWNrU3RhdHVzUgZzdGF0dXMSMgoVY3VycmVudF9w'
    'bGF5YmFja19yYXRlGAUgASgCUhNjdXJyZW50UGxheWJhY2tSYXRlEigKEGJ1ZmZlcl9oZWFsdG'
    'hfbXMYBiABKAVSDmJ1ZmZlckhlYWx0aE1z');

