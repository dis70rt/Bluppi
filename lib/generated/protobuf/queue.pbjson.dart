//
//  Generated code. Do not modify.
//  source: protobuf/queue.proto
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

@$core.Deprecated('Use roomQueueItemDescriptor instead')
const RoomQueueItem$json = {
  '1': 'RoomQueueItem',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'position', '3': 2, '4': 1, '5': 5, '10': 'position'},
    {'1': 'track_id', '3': 3, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'added_by', '3': 4, '4': 1, '5': 9, '10': 'addedBy'},
    {'1': 'added_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'addedAt'},
  ],
};

/// Descriptor for `RoomQueueItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomQueueItemDescriptor = $convert.base64Decode(
    'Cg1Sb29tUXVldWVJdGVtEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIaCghwb3NpdGlvbhgCIA'
    'EoBVIIcG9zaXRpb24SGQoIdHJhY2tfaWQYAyABKAlSB3RyYWNrSWQSGQoIYWRkZWRfYnkYBCAB'
    'KAlSB2FkZGVkQnkSNQoIYWRkZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW'
    '1wUgdhZGRlZEF0');

@$core.Deprecated('Use addToQueueRequestDescriptor instead')
const AddToQueueRequest$json = {
  '1': 'AddToQueueRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `AddToQueueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addToQueueRequestDescriptor = $convert.base64Decode(
    'ChFBZGRUb1F1ZXVlUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSGQoIdHJhY2tfaW'
    'QYAiABKAlSB3RyYWNrSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklk');

@$core.Deprecated('Use removeFromQueueRequestDescriptor instead')
const RemoveFromQueueRequest$json = {
  '1': 'RemoveFromQueueRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
  ],
};

/// Descriptor for `RemoveFromQueueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeFromQueueRequestDescriptor = $convert.base64Decode(
    'ChZSZW1vdmVGcm9tUXVldWVSZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIZCgh0cm'
    'Fja19pZBgCIAEoCVIHdHJhY2tJZA==');

@$core.Deprecated('Use getQueueRequestDescriptor instead')
const GetQueueRequest$json = {
  '1': 'GetQueueRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `GetQueueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQueueRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRRdWV1ZVJlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlk');

@$core.Deprecated('Use getQueueResponseDescriptor instead')
const GetQueueResponse$json = {
  '1': 'GetQueueResponse',
  '2': [
    {'1': 'items', '3': 1, '4': 3, '5': 11, '6': '.ListeningParty.RoomQueueItem', '10': 'items'},
  ],
};

/// Descriptor for `GetQueueResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getQueueResponseDescriptor = $convert.base64Decode(
    'ChBHZXRRdWV1ZVJlc3BvbnNlEjMKBWl0ZW1zGAEgAygLMh0uTGlzdGVuaW5nUGFydHkuUm9vbV'
    'F1ZXVlSXRlbVIFaXRlbXM=');

@$core.Deprecated('Use clearQueueRequestDescriptor instead')
const ClearQueueRequest$json = {
  '1': 'ClearQueueRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `ClearQueueRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearQueueRequestDescriptor = $convert.base64Decode(
    'ChFDbGVhclF1ZXVlUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

