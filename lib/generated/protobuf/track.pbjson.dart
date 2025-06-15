//
//  Generated code. Do not modify.
//  source: protobuf/track.proto
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

@$core.Deprecated('Use trackDescriptor instead')
const Track$json = {
  '1': 'Track',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'duration_ms', '3': 5, '4': 1, '5': 5, '10': 'durationMs'},
  ],
};

/// Descriptor for `Track`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackDescriptor = $convert.base64Decode(
    'CgVUcmFjaxIZCgh0cmFja19pZBgBIAEoCVIHdHJhY2tJZBIUCgV0aXRsZRgCIAEoCVIFdGl0bG'
    'USFgoGYXJ0aXN0GAMgASgJUgZhcnRpc3QSGwoJaW1hZ2VfdXJsGAQgASgJUghpbWFnZVVybBIf'
    'CgtkdXJhdGlvbl9tcxgFIAEoBVIKZHVyYXRpb25Ncw==');

@$core.Deprecated('Use getTrackRequestDescriptor instead')
const GetTrackRequest$json = {
  '1': 'GetTrackRequest',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
  ],
};

/// Descriptor for `GetTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRUcmFja1JlcXVlc3QSGQoIdHJhY2tfaWQYASABKAlSB3RyYWNrSWQ=');

@$core.Deprecated('Use searchTracksRequestDescriptor instead')
const SearchTracksRequest$json = {
  '1': 'SearchTracksRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `SearchTracksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTracksRequestDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hUcmFja3NSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIbCglwYWdlX3Npem'
    'UYAiABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YAyABKAlSCXBhZ2VUb2tlbg==');

@$core.Deprecated('Use searchTracksResponseDescriptor instead')
const SearchTracksResponse$json = {
  '1': 'SearchTracksResponse',
  '2': [
    {'1': 'tracks', '3': 1, '4': 3, '5': 11, '6': '.ListeningParty.Track', '10': 'tracks'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `SearchTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTracksResponseDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hUcmFja3NSZXNwb25zZRItCgZ0cmFja3MYASADKAsyFS5MaXN0ZW5pbmdQYXJ0eS'
    '5UcmFja1IGdHJhY2tzEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

