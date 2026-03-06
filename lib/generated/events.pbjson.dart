// This is a generated file - do not edit.
//
// Generated from events.proto.

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

@$core.Deprecated('Use userFollowedEventDescriptor instead')
const UserFollowedEvent$json = {
  '1': 'UserFollowedEvent',
  '2': [
    {'1': 'follower_id', '3': 1, '4': 1, '5': 9, '10': 'followerId'},
    {'1': 'follower_name', '3': 2, '4': 1, '5': 9, '10': 'followerName'},
    {'1': 'follower_avatar', '3': 3, '4': 1, '5': 9, '10': 'followerAvatar'},
    {'1': 'followee_id', '3': 4, '4': 1, '5': 9, '10': 'followeeId'},
    {
      '1': 'occurred_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'occurredAt'
    },
  ],
};

/// Descriptor for `UserFollowedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userFollowedEventDescriptor = $convert.base64Decode(
    'ChFVc2VyRm9sbG93ZWRFdmVudBIfCgtmb2xsb3dlcl9pZBgBIAEoCVIKZm9sbG93ZXJJZBIjCg'
    '1mb2xsb3dlcl9uYW1lGAIgASgJUgxmb2xsb3dlck5hbWUSJwoPZm9sbG93ZXJfYXZhdGFyGAMg'
    'ASgJUg5mb2xsb3dlckF2YXRhchIfCgtmb2xsb3dlZV9pZBgEIAEoCVIKZm9sbG93ZWVJZBI7Cg'
    'tvY2N1cnJlZF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCm9jY3VycmVk'
    'QXQ=');

@$core.Deprecated('Use partyInviteEventDescriptor instead')
const PartyInviteEvent$json = {
  '1': 'PartyInviteEvent',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'room_name', '3': 2, '4': 1, '5': 9, '10': 'roomName'},
    {'1': 'inviter_id', '3': 3, '4': 1, '5': 9, '10': 'inviterId'},
    {'1': 'inviter_name', '3': 4, '4': 1, '5': 9, '10': 'inviterName'},
    {'1': 'inviter_avatar', '3': 5, '4': 1, '5': 9, '10': 'inviterAvatar'},
    {'1': 'target_user_id', '3': 6, '4': 1, '5': 9, '10': 'targetUserId'},
    {
      '1': 'occurred_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'occurredAt'
    },
  ],
};

/// Descriptor for `PartyInviteEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List partyInviteEventDescriptor = $convert.base64Decode(
    'ChBQYXJ0eUludml0ZUV2ZW50EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIbCglyb29tX25hbW'
    'UYAiABKAlSCHJvb21OYW1lEh0KCmludml0ZXJfaWQYAyABKAlSCWludml0ZXJJZBIhCgxpbnZp'
    'dGVyX25hbWUYBCABKAlSC2ludml0ZXJOYW1lEiUKDmludml0ZXJfYXZhdGFyGAUgASgJUg1pbn'
    'ZpdGVyQXZhdGFyEiQKDnRhcmdldF91c2VyX2lkGAYgASgJUgx0YXJnZXRVc2VySWQSOwoLb2Nj'
    'dXJyZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpvY2N1cnJlZEF0');

@$core.Deprecated('Use followerListeningEventDescriptor instead')
const FollowerListeningEvent$json = {
  '1': 'FollowerListeningEvent',
  '2': [
    {'1': 'broadcaster_id', '3': 1, '4': 1, '5': 9, '10': 'broadcasterId'},
    {'1': 'broadcaster_name', '3': 2, '4': 1, '5': 9, '10': 'broadcasterName'},
    {'1': 'room_id', '3': 3, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'track_name', '3': 4, '4': 1, '5': 9, '10': 'trackName'},
    {
      '1': 'target_follower_ids',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'targetFollowerIds'
    },
    {
      '1': 'occurred_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'occurredAt'
    },
  ],
};

/// Descriptor for `FollowerListeningEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List followerListeningEventDescriptor = $convert.base64Decode(
    'ChZGb2xsb3dlckxpc3RlbmluZ0V2ZW50EiUKDmJyb2FkY2FzdGVyX2lkGAEgASgJUg1icm9hZG'
    'Nhc3RlcklkEikKEGJyb2FkY2FzdGVyX25hbWUYAiABKAlSD2Jyb2FkY2FzdGVyTmFtZRIXCgdy'
    'b29tX2lkGAMgASgJUgZyb29tSWQSHQoKdHJhY2tfbmFtZRgEIAEoCVIJdHJhY2tOYW1lEi4KE3'
    'RhcmdldF9mb2xsb3dlcl9pZHMYBSADKAlSEXRhcmdldEZvbGxvd2VySWRzEjsKC29jY3VycmVk'
    'X2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKb2NjdXJyZWRBdA==');
