// This is a generated file - do not edit.
//
// Generated from presences.proto.

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

@$core.Deprecated('Use subscribeRequestDescriptor instead')
const SubscribeRequest$json = {
  '1': 'SubscribeRequest',
  '2': [
    {'1': 'target_user_ids', '3': 1, '4': 3, '5': 9, '10': 'targetUserIds'},
  ],
};

/// Descriptor for `SubscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeRequestDescriptor = $convert.base64Decode(
    'ChBTdWJzY3JpYmVSZXF1ZXN0EiYKD3RhcmdldF91c2VyX2lkcxgBIAMoCVINdGFyZ2V0VXNlck'
    'lkcw==');

@$core.Deprecated('Use presenceUpdateDescriptor instead')
const PresenceUpdate$json = {
  '1': 'PresenceUpdate',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'last_seen', '3': 3, '4': 1, '5': 3, '10': 'lastSeen'},
  ],
};

/// Descriptor for `PresenceUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List presenceUpdateDescriptor = $convert.base64Decode(
    'Cg5QcmVzZW5jZVVwZGF0ZRIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFgoGc3RhdHVzGAIgAS'
    'gJUgZzdGF0dXMSGwoJbGFzdF9zZWVuGAMgASgDUghsYXN0U2Vlbg==');

@$core.Deprecated('Use heartBeatRequestDescriptor instead')
const HeartBeatRequest$json = {
  '1': 'HeartBeatRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `HeartBeatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heartBeatRequestDescriptor = $convert.base64Decode(
    'ChBIZWFydEJlYXRSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');
