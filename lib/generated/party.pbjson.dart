// This is a generated file - do not edit.
//
// Generated from party.proto.

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

@$core.Deprecated('Use syncRequestDescriptor instead')
const SyncRequest$json = {
  '1': 'SyncRequest',
  '2': [
    {'1': 'client_send_us', '3': 1, '4': 1, '5': 3, '10': 'clientSendUs'},
  ],
};

/// Descriptor for `SyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncRequestDescriptor = $convert.base64Decode(
    'CgtTeW5jUmVxdWVzdBIkCg5jbGllbnRfc2VuZF91cxgBIAEoA1IMY2xpZW50U2VuZFVz');

@$core.Deprecated('Use syncResponseDescriptor instead')
const SyncResponse$json = {
  '1': 'SyncResponse',
  '2': [
    {'1': 'server_receive_us', '3': 1, '4': 1, '5': 3, '10': 'serverReceiveUs'},
    {'1': 'server_send_us', '3': 2, '4': 1, '5': 3, '10': 'serverSendUs'},
  ],
};

/// Descriptor for `SyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncResponseDescriptor = $convert.base64Decode(
    'CgxTeW5jUmVzcG9uc2USKgoRc2VydmVyX3JlY2VpdmVfdXMYASABKANSD3NlcnZlclJlY2Vpdm'
    'VVcxIkCg5zZXJ2ZXJfc2VuZF91cxgCIAEoA1IMc2VydmVyU2VuZFVz');
