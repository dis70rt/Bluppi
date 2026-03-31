// This is a generated file - do not edit.
//
// Generated from friends_activity.proto.

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

@$core.Deprecated('Use friendActivityDescriptor instead')
const FriendActivity$json = {
  '1': 'FriendActivity',
  '2': [
    {'1': 'friend_id', '3': 1, '4': 1, '5': 9, '10': 'friendId'},
    {'1': 'friend_name', '3': 2, '4': 1, '5': 9, '10': 'friendName'},
    {'1': 'friend_avatar_url', '3': 3, '4': 1, '5': 9, '10': 'friendAvatarUrl'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
    {'1': 'friend_username', '3': 11, '4': 1, '5': 9, '10': 'friendUsername'},
    {
      '1': 'track_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'trackId',
      '17': true
    },
    {
      '1': 'track_title',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'trackTitle',
      '17': true
    },
    {
      '1': 'track_artist',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'trackArtist',
      '17': true
    },
    {
      '1': 'track_cover_url',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'trackCoverUrl',
      '17': true
    },
    {
      '1': 'track_preview_url',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'trackPreviewUrl',
      '17': true
    },
    {
      '1': 'last_seen',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'lastSeen'
    },
  ],
  '8': [
    {'1': '_track_id'},
    {'1': '_track_title'},
    {'1': '_track_artist'},
    {'1': '_track_cover_url'},
    {'1': '_track_preview_url'},
  ],
};

/// Descriptor for `FriendActivity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List friendActivityDescriptor = $convert.base64Decode(
    'Cg5GcmllbmRBY3Rpdml0eRIbCglmcmllbmRfaWQYASABKAlSCGZyaWVuZElkEh8KC2ZyaWVuZF'
    '9uYW1lGAIgASgJUgpmcmllbmROYW1lEioKEWZyaWVuZF9hdmF0YXJfdXJsGAMgASgJUg9mcmll'
    'bmRBdmF0YXJVcmwSFgoGc3RhdHVzGAQgASgJUgZzdGF0dXMSJwoPZnJpZW5kX3VzZXJuYW1lGA'
    'sgASgJUg5mcmllbmRVc2VybmFtZRIeCgh0cmFja19pZBgFIAEoCUgAUgd0cmFja0lkiAEBEiQK'
    'C3RyYWNrX3RpdGxlGAYgASgJSAFSCnRyYWNrVGl0bGWIAQESJgoMdHJhY2tfYXJ0aXN0GAcgAS'
    'gJSAJSC3RyYWNrQXJ0aXN0iAEBEisKD3RyYWNrX2NvdmVyX3VybBgIIAEoCUgDUg10cmFja0Nv'
    'dmVyVXJsiAEBEi8KEXRyYWNrX3ByZXZpZXdfdXJsGAkgASgJSARSD3RyYWNrUHJldmlld1VybI'
    'gBARI3CglsYXN0X3NlZW4YCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUghsYXN0'
    'U2VlbkILCglfdHJhY2tfaWRCDgoMX3RyYWNrX3RpdGxlQg8KDV90cmFja19hcnRpc3RCEgoQX3'
    'RyYWNrX2NvdmVyX3VybEIUChJfdHJhY2tfcHJldmlld191cmw=');

@$core.Deprecated('Use getFriendsFeedRequestDescriptor instead')
const GetFriendsFeedRequest$json = {
  '1': 'GetFriendsFeedRequest',
  '2': [
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetFriendsFeedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFriendsFeedRequestDescriptor = $convert.base64Decode(
    'ChVHZXRGcmllbmRzRmVlZFJlcXVlc3QSFAoFbGltaXQYAiABKAVSBWxpbWl0EhYKBm9mZnNldB'
    'gDIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getFriendsFeedResponseDescriptor instead')
const GetFriendsFeedResponse$json = {
  '1': 'GetFriendsFeedResponse',
  '2': [
    {
      '1': 'activities',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.friends_activity.FriendActivity',
      '10': 'activities'
    },
  ],
};

/// Descriptor for `GetFriendsFeedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFriendsFeedResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRGcmllbmRzRmVlZFJlc3BvbnNlEkAKCmFjdGl2aXRpZXMYASADKAsyIC5mcmllbmRzX2'
        'FjdGl2aXR5LkZyaWVuZEFjdGl2aXR5UgphY3Rpdml0aWVz');
