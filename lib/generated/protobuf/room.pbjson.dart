//
//  Generated code. Do not modify.
//  source: protobuf/room.proto
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

@$core.Deprecated('Use roomDescriptor instead')
const Room$json = {
  '1': 'Room',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    {'1': 'room_code', '3': 4, '4': 1, '5': 9, '10': 'roomCode'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.ListeningParty.RoomStatus', '10': 'status'},
    {'1': 'visibility', '3': 6, '4': 1, '5': 14, '6': '.ListeningParty.RoomVisibility', '10': 'visibility'},
    {'1': 'invite_only', '3': 7, '4': 1, '5': 8, '10': 'inviteOnly'},
    {'1': 'members', '3': 8, '4': 3, '5': 11, '6': '.ListeningParty.RoomMember', '10': 'members'},
    {'1': 'host_user_id', '3': 9, '4': 1, '5': 9, '10': 'hostUserId'},
    {'1': 'playback_state', '3': 10, '4': 1, '5': 11, '6': '.ListeningParty.PlaybackState', '10': 'playbackState'},
    {'1': 'current_track', '3': 11, '4': 1, '5': 11, '6': '.ListeningParty.Track', '10': 'currentTrack'},
    {'1': 'current_position_ms', '3': 12, '4': 1, '5': 3, '10': 'currentPositionMs'},
    {'1': 'last_position_update', '3': 13, '4': 1, '5': 3, '10': 'lastPositionUpdate'},
    {'1': 'track_start_time', '3': 14, '4': 1, '5': 3, '10': 'trackStartTime'},
    {'1': 'is_playing', '3': 15, '4': 1, '5': 8, '10': 'isPlaying'},
  ],
};

/// Descriptor for `Room`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomDescriptor = $convert.base64Decode(
    'CgRSb29tEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW'
    '9uGAMgASgJUgtkZXNjcmlwdGlvbhIbCglyb29tX2NvZGUYBCABKAlSCHJvb21Db2RlEjIKBnN0'
    'YXR1cxgFIAEoDjIaLkxpc3RlbmluZ1BhcnR5LlJvb21TdGF0dXNSBnN0YXR1cxI+Cgp2aXNpYm'
    'lsaXR5GAYgASgOMh4uTGlzdGVuaW5nUGFydHkuUm9vbVZpc2liaWxpdHlSCnZpc2liaWxpdHkS'
    'HwoLaW52aXRlX29ubHkYByABKAhSCmludml0ZU9ubHkSNAoHbWVtYmVycxgIIAMoCzIaLkxpc3'
    'RlbmluZ1BhcnR5LlJvb21NZW1iZXJSB21lbWJlcnMSIAoMaG9zdF91c2VyX2lkGAkgASgJUgpo'
    'b3N0VXNlcklkEkQKDnBsYXliYWNrX3N0YXRlGAogASgLMh0uTGlzdGVuaW5nUGFydHkuUGxheW'
    'JhY2tTdGF0ZVINcGxheWJhY2tTdGF0ZRI6Cg1jdXJyZW50X3RyYWNrGAsgASgLMhUuTGlzdGVu'
    'aW5nUGFydHkuVHJhY2tSDGN1cnJlbnRUcmFjaxIuChNjdXJyZW50X3Bvc2l0aW9uX21zGAwgAS'
    'gDUhFjdXJyZW50UG9zaXRpb25NcxIwChRsYXN0X3Bvc2l0aW9uX3VwZGF0ZRgNIAEoA1ISbGFz'
    'dFBvc2l0aW9uVXBkYXRlEigKEHRyYWNrX3N0YXJ0X3RpbWUYDiABKANSDnRyYWNrU3RhcnRUaW'
    '1lEh0KCmlzX3BsYXlpbmcYDyABKAhSCWlzUGxheWluZw==');

@$core.Deprecated('Use createRoomRequestDescriptor instead')
const CreateRoomRequest$json = {
  '1': 'CreateRoomRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'room_code', '3': 3, '4': 1, '5': 9, '10': 'roomCode'},
    {'1': 'visibility', '3': 4, '4': 1, '5': 14, '6': '.ListeningParty.RoomVisibility', '10': 'visibility'},
    {'1': 'invite_only', '3': 5, '4': 1, '5': 8, '10': 'inviteOnly'},
    {'1': 'host_user_id', '3': 6, '4': 1, '5': 9, '10': 'hostUserId'},
  ],
};

/// Descriptor for `CreateRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRoomRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVSb29tUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEiAKC2Rlc2NyaXB0aW9uGA'
    'IgASgJUgtkZXNjcmlwdGlvbhIbCglyb29tX2NvZGUYAyABKAlSCHJvb21Db2RlEj4KCnZpc2li'
    'aWxpdHkYBCABKA4yHi5MaXN0ZW5pbmdQYXJ0eS5Sb29tVmlzaWJpbGl0eVIKdmlzaWJpbGl0eR'
    'IfCgtpbnZpdGVfb25seRgFIAEoCFIKaW52aXRlT25seRIgCgxob3N0X3VzZXJfaWQYBiABKAlS'
    'Cmhvc3RVc2VySWQ=');

@$core.Deprecated('Use getRoomRequestDescriptor instead')
const GetRoomRequest$json = {
  '1': 'GetRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `GetRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRSb29tUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use getRoomByCodeRequestDescriptor instead')
const GetRoomByCodeRequest$json = {
  '1': 'GetRoomByCodeRequest',
  '2': [
    {'1': 'room_code', '3': 1, '4': 1, '5': 9, '10': 'roomCode'},
  ],
};

/// Descriptor for `GetRoomByCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomByCodeRequestDescriptor = $convert.base64Decode(
    'ChRHZXRSb29tQnlDb2RlUmVxdWVzdBIbCglyb29tX2NvZGUYASABKAlSCHJvb21Db2Rl');

@$core.Deprecated('Use updateRoomRequestDescriptor instead')
const UpdateRoomRequest$json = {
  '1': 'UpdateRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'description', '17': true},
    {'1': 'visibility', '3': 4, '4': 1, '5': 14, '6': '.ListeningParty.RoomVisibility', '9': 2, '10': 'visibility', '17': true},
    {'1': 'invite_only', '3': 5, '4': 1, '5': 8, '9': 3, '10': 'inviteOnly', '17': true},
  ],
  '8': [
    {'1': '_name'},
    {'1': '_description'},
    {'1': '_visibility'},
    {'1': '_invite_only'},
  ],
};

/// Descriptor for `UpdateRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateRoomRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVSb29tUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSFwoEbmFtZRgCIA'
    'EoCUgAUgRuYW1liAEBEiUKC2Rlc2NyaXB0aW9uGAMgASgJSAFSC2Rlc2NyaXB0aW9uiAEBEkMK'
    'CnZpc2liaWxpdHkYBCABKA4yHi5MaXN0ZW5pbmdQYXJ0eS5Sb29tVmlzaWJpbGl0eUgCUgp2aX'
    'NpYmlsaXR5iAEBEiQKC2ludml0ZV9vbmx5GAUgASgISANSCmludml0ZU9ubHmIAQFCBwoFX25h'
    'bWVCDgoMX2Rlc2NyaXB0aW9uQg0KC192aXNpYmlsaXR5Qg4KDF9pbnZpdGVfb25seQ==');

@$core.Deprecated('Use deleteRoomRequestDescriptor instead')
const DeleteRoomRequest$json = {
  '1': 'DeleteRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `DeleteRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteRoomRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVSb29tUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use listRoomsRequestDescriptor instead')
const ListRoomsRequest$json = {
  '1': 'ListRoomsRequest',
  '2': [
    {'1': 'visibility_filter', '3': 1, '4': 1, '5': 14, '6': '.ListeningParty.RoomVisibility', '9': 0, '10': 'visibilityFilter', '17': true},
    {'1': 'host_user_id_filter', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'hostUserIdFilter', '17': true},
    {'1': 'include_private_rooms_if_member', '3': 3, '4': 1, '5': 8, '9': 2, '10': 'includePrivateRoomsIfMember', '17': true},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 5, '4': 1, '5': 9, '10': 'pageToken'},
  ],
  '8': [
    {'1': '_visibility_filter'},
    {'1': '_host_user_id_filter'},
    {'1': '_include_private_rooms_if_member'},
  ],
};

/// Descriptor for `ListRoomsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomsRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0Um9vbXNSZXF1ZXN0ElAKEXZpc2liaWxpdHlfZmlsdGVyGAEgASgOMh4uTGlzdGVuaW'
    '5nUGFydHkuUm9vbVZpc2liaWxpdHlIAFIQdmlzaWJpbGl0eUZpbHRlcogBARIyChNob3N0X3Vz'
    'ZXJfaWRfZmlsdGVyGAIgASgJSAFSEGhvc3RVc2VySWRGaWx0ZXKIAQESSQofaW5jbHVkZV9wcm'
    'l2YXRlX3Jvb21zX2lmX21lbWJlchgDIAEoCEgCUhtpbmNsdWRlUHJpdmF0ZVJvb21zSWZNZW1i'
    'ZXKIAQESGwoJcGFnZV9zaXplGAQgASgFUghwYWdlU2l6ZRIdCgpwYWdlX3Rva2VuGAUgASgJUg'
    'lwYWdlVG9rZW5CFAoSX3Zpc2liaWxpdHlfZmlsdGVyQhYKFF9ob3N0X3VzZXJfaWRfZmlsdGVy'
    'QiIKIF9pbmNsdWRlX3ByaXZhdGVfcm9vbXNfaWZfbWVtYmVy');

@$core.Deprecated('Use listRoomsResponseDescriptor instead')
const ListRoomsResponse$json = {
  '1': 'ListRoomsResponse',
  '2': [
    {'1': 'rooms', '3': 1, '4': 3, '5': 11, '6': '.ListeningParty.Room', '10': 'rooms'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListRoomsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0Um9vbXNSZXNwb25zZRIqCgVyb29tcxgBIAMoCzIULkxpc3RlbmluZ1BhcnR5LlJvb2'
    '1SBXJvb21zEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use joinRoomRequestDescriptor instead')
const JoinRoomRequest$json = {
  '1': 'JoinRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'roomId'},
    {'1': 'room_code', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'roomCode'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
  ],
  '8': [
    {'1': 'identifier'},
  ],
};

/// Descriptor for `JoinRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRoomRequestDescriptor = $convert.base64Decode(
    'Cg9Kb2luUm9vbVJlcXVlc3QSGQoHcm9vbV9pZBgBIAEoCUgAUgZyb29tSWQSHQoJcm9vbV9jb2'
    'RlGAIgASgJSABSCHJvb21Db2RlEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZEIMCgppZGVudGlm'
    'aWVy');

@$core.Deprecated('Use leaveRoomRequestDescriptor instead')
const LeaveRoomRequest$json = {
  '1': 'LeaveRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `LeaveRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveRoomRequestDescriptor = $convert.base64Decode(
    'ChBMZWF2ZVJvb21SZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGA'
    'IgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use inviteToRoomRequestDescriptor instead')
const InviteToRoomRequest$json = {
  '1': 'InviteToRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'inviter_user_id', '3': 2, '4': 1, '5': 9, '10': 'inviterUserId'},
    {'1': 'invitee_user_id', '3': 3, '4': 1, '5': 9, '10': 'inviteeUserId'},
  ],
};

/// Descriptor for `InviteToRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteToRoomRequestDescriptor = $convert.base64Decode(
    'ChNJbnZpdGVUb1Jvb21SZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBImCg9pbnZpdG'
    'VyX3VzZXJfaWQYAiABKAlSDWludml0ZXJVc2VySWQSJgoPaW52aXRlZV91c2VyX2lkGAMgASgJ'
    'Ug1pbnZpdGVlVXNlcklk');

@$core.Deprecated('Use kickFromRoomRequestDescriptor instead')
const KickFromRoomRequest$json = {
  '1': 'KickFromRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'performing_user_id', '3': 2, '4': 1, '5': 9, '10': 'performingUserId'},
    {'1': 'kicked_user_id', '3': 3, '4': 1, '5': 9, '10': 'kickedUserId'},
  ],
};

/// Descriptor for `KickFromRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List kickFromRoomRequestDescriptor = $convert.base64Decode(
    'ChNLaWNrRnJvbVJvb21SZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIsChJwZXJmb3'
    'JtaW5nX3VzZXJfaWQYAiABKAlSEHBlcmZvcm1pbmdVc2VySWQSJAoOa2lja2VkX3VzZXJfaWQY'
    'AyABKAlSDGtpY2tlZFVzZXJJZA==');

@$core.Deprecated('Use roomMemberDescriptor instead')
const RoomMember$json = {
  '1': 'RoomMember',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'role', '3': 3, '4': 1, '5': 14, '6': '.ListeningParty.RoomMemberRole', '10': 'role'},
    {'1': 'invited_by', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'invitedBy', '17': true},
    {'1': 'joined_at', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'joinedAt'},
    {'1': 'left_at', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '9': 1, '10': 'leftAt', '17': true},
  ],
  '8': [
    {'1': '_invited_by'},
    {'1': '_left_at'},
  ],
};

/// Descriptor for `RoomMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomMemberDescriptor = $convert.base64Decode(
    'CgpSb29tTWVtYmVyEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSMgoEcm9sZRgDIAEoDjIeLkxpc3RlbmluZ1BhcnR5LlJvb21NZW1iZXJSb2xlUgRy'
    'b2xlEiIKCmludml0ZWRfYnkYBCABKAlIAFIJaW52aXRlZEJ5iAEBEjcKCWpvaW5lZF9hdBgFIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGpvaW5lZEF0EjgKB2xlZnRfYXQYBiAB'
    'KAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wSAFSBmxlZnRBdIgBAUINCgtfaW52aXRlZF'
    '9ieUIKCghfbGVmdF9hdA==');

