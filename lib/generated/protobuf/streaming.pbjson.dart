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

@$core.Deprecated('Use roomStreamUpdateDescriptor instead')
const RoomStreamUpdate$json = {
  '1': 'RoomStreamUpdate',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'timestamp', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
    {'1': 'playback_update', '3': 3, '4': 1, '5': 11, '6': '.ListeningParty.PlaybackUpdate', '9': 0, '10': 'playbackUpdate'},
    {'1': 'member_update', '3': 4, '4': 1, '5': 11, '6': '.ListeningParty.MemberUpdate', '9': 0, '10': 'memberUpdate'},
    {'1': 'room_settings_update', '3': 5, '4': 1, '5': 11, '6': '.ListeningParty.RoomSettingsUpdate', '9': 0, '10': 'roomSettingsUpdate'},
    {'1': 'room_status_update', '3': 6, '4': 1, '5': 11, '6': '.ListeningParty.RoomStatusUpdate', '9': 0, '10': 'roomStatusUpdate'},
  ],
  '8': [
    {'1': 'update_type'},
  ],
};

/// Descriptor for `RoomStreamUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomStreamUpdateDescriptor = $convert.base64Decode(
    'ChBSb29tU3RyZWFtVXBkYXRlEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBI4Cgl0aW1lc3RhbX'
    'AYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXASSQoPcGxheWJh'
    'Y2tfdXBkYXRlGAMgASgLMh4uTGlzdGVuaW5nUGFydHkuUGxheWJhY2tVcGRhdGVIAFIOcGxheW'
    'JhY2tVcGRhdGUSQwoNbWVtYmVyX3VwZGF0ZRgEIAEoCzIcLkxpc3RlbmluZ1BhcnR5Lk1lbWJl'
    'clVwZGF0ZUgAUgxtZW1iZXJVcGRhdGUSVgoUcm9vbV9zZXR0aW5nc191cGRhdGUYBSABKAsyIi'
    '5MaXN0ZW5pbmdQYXJ0eS5Sb29tU2V0dGluZ3NVcGRhdGVIAFIScm9vbVNldHRpbmdzVXBkYXRl'
    'ElAKEnJvb21fc3RhdHVzX3VwZGF0ZRgGIAEoCzIgLkxpc3RlbmluZ1BhcnR5LlJvb21TdGF0dX'
    'NVcGRhdGVIAFIQcm9vbVN0YXR1c1VwZGF0ZUINCgt1cGRhdGVfdHlwZQ==');

@$core.Deprecated('Use playbackUpdateDescriptor instead')
const PlaybackUpdate$json = {
  '1': 'PlaybackUpdate',
  '2': [
    {'1': 'track_change', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.TrackChangeEvent', '9': 0, '10': 'trackChange'},
    {'1': 'play_state', '3': 2, '4': 1, '5': 11, '6': '.ListeningParty.PlayStateEvent', '9': 0, '10': 'playState'},
    {'1': 'seek', '3': 3, '4': 1, '5': 11, '6': '.ListeningParty.SeekEvent', '9': 0, '10': 'seek'},
    {'1': 'skip', '3': 4, '4': 1, '5': 11, '6': '.ListeningParty.SkipEvent', '9': 0, '10': 'skip'},
  ],
  '8': [
    {'1': 'playback_event'},
  ],
};

/// Descriptor for `PlaybackUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackUpdateDescriptor = $convert.base64Decode(
    'Cg5QbGF5YmFja1VwZGF0ZRJFCgx0cmFja19jaGFuZ2UYASABKAsyIC5MaXN0ZW5pbmdQYXJ0eS'
    '5UcmFja0NoYW5nZUV2ZW50SABSC3RyYWNrQ2hhbmdlEj8KCnBsYXlfc3RhdGUYAiABKAsyHi5M'
    'aXN0ZW5pbmdQYXJ0eS5QbGF5U3RhdGVFdmVudEgAUglwbGF5U3RhdGUSLwoEc2VlaxgDIAEoCz'
    'IZLkxpc3RlbmluZ1BhcnR5LlNlZWtFdmVudEgAUgRzZWVrEi8KBHNraXAYBCABKAsyGS5MaXN0'
    'ZW5pbmdQYXJ0eS5Ta2lwRXZlbnRIAFIEc2tpcEIQCg5wbGF5YmFja19ldmVudA==');

@$core.Deprecated('Use trackChangeEventDescriptor instead')
const TrackChangeEvent$json = {
  '1': 'TrackChangeEvent',
  '2': [
    {'1': 'current_track', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.Track', '10': 'currentTrack'},
    {'1': 'position_ms', '3': 2, '4': 1, '5': 5, '10': 'positionMs'},
  ],
};

/// Descriptor for `TrackChangeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackChangeEventDescriptor = $convert.base64Decode(
    'ChBUcmFja0NoYW5nZUV2ZW50EjoKDWN1cnJlbnRfdHJhY2sYASABKAsyFS5MaXN0ZW5pbmdQYX'
    'J0eS5UcmFja1IMY3VycmVudFRyYWNrEh8KC3Bvc2l0aW9uX21zGAIgASgFUgpwb3NpdGlvbk1z');

@$core.Deprecated('Use playStateEventDescriptor instead')
const PlayStateEvent$json = {
  '1': 'PlayStateEvent',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.ListeningParty.PlaybackStatus', '10': 'status'},
    {'1': 'position_ms', '3': 2, '4': 1, '5': 5, '10': 'positionMs'},
  ],
};

/// Descriptor for `PlayStateEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playStateEventDescriptor = $convert.base64Decode(
    'Cg5QbGF5U3RhdGVFdmVudBI2CgZzdGF0dXMYASABKA4yHi5MaXN0ZW5pbmdQYXJ0eS5QbGF5Ym'
    'Fja1N0YXR1c1IGc3RhdHVzEh8KC3Bvc2l0aW9uX21zGAIgASgFUgpwb3NpdGlvbk1z');

@$core.Deprecated('Use seekEventDescriptor instead')
const SeekEvent$json = {
  '1': 'SeekEvent',
  '2': [
    {'1': 'position_ms', '3': 1, '4': 1, '5': 5, '10': 'positionMs'},
  ],
};

/// Descriptor for `SeekEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seekEventDescriptor = $convert.base64Decode(
    'CglTZWVrRXZlbnQSHwoLcG9zaXRpb25fbXMYASABKAVSCnBvc2l0aW9uTXM=');

@$core.Deprecated('Use skipEventDescriptor instead')
const SkipEvent$json = {
  '1': 'SkipEvent',
  '2': [
    {'1': 'new_track', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.Track', '10': 'newTrack'},
  ],
};

/// Descriptor for `SkipEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skipEventDescriptor = $convert.base64Decode(
    'CglTa2lwRXZlbnQSMgoJbmV3X3RyYWNrGAEgASgLMhUuTGlzdGVuaW5nUGFydHkuVHJhY2tSCG'
    '5ld1RyYWNr');

@$core.Deprecated('Use memberUpdateDescriptor instead')
const MemberUpdate$json = {
  '1': 'MemberUpdate',
  '2': [
    {'1': 'member_join', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.MemberJoinEvent', '9': 0, '10': 'memberJoin'},
    {'1': 'member_leave', '3': 2, '4': 1, '5': 11, '6': '.ListeningParty.MemberLeaveEvent', '9': 0, '10': 'memberLeave'},
    {'1': 'role_change', '3': 3, '4': 1, '5': 11, '6': '.ListeningParty.MemberRoleChangeEvent', '9': 0, '10': 'roleChange'},
  ],
  '8': [
    {'1': 'member_event'},
  ],
};

/// Descriptor for `MemberUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberUpdateDescriptor = $convert.base64Decode(
    'CgxNZW1iZXJVcGRhdGUSQgoLbWVtYmVyX2pvaW4YASABKAsyHy5MaXN0ZW5pbmdQYXJ0eS5NZW'
    '1iZXJKb2luRXZlbnRIAFIKbWVtYmVySm9pbhJFCgxtZW1iZXJfbGVhdmUYAiABKAsyIC5MaXN0'
    'ZW5pbmdQYXJ0eS5NZW1iZXJMZWF2ZUV2ZW50SABSC21lbWJlckxlYXZlEkgKC3JvbGVfY2hhbm'
    'dlGAMgASgLMiUuTGlzdGVuaW5nUGFydHkuTWVtYmVyUm9sZUNoYW5nZUV2ZW50SABSCnJvbGVD'
    'aGFuZ2VCDgoMbWVtYmVyX2V2ZW50');

@$core.Deprecated('Use memberJoinEventDescriptor instead')
const MemberJoinEvent$json = {
  '1': 'MemberJoinEvent',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.User', '10': 'user'},
    {'1': 'role', '3': 2, '4': 1, '5': 14, '6': '.ListeningParty.RoomMemberRole', '10': 'role'},
  ],
};

/// Descriptor for `MemberJoinEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberJoinEventDescriptor = $convert.base64Decode(
    'Cg9NZW1iZXJKb2luRXZlbnQSKAoEdXNlchgBIAEoCzIULkxpc3RlbmluZ1BhcnR5LlVzZXJSBH'
    'VzZXISMgoEcm9sZRgCIAEoDjIeLkxpc3RlbmluZ1BhcnR5LlJvb21NZW1iZXJSb2xlUgRyb2xl');

@$core.Deprecated('Use memberLeaveEventDescriptor instead')
const MemberLeaveEvent$json = {
  '1': 'MemberLeaveEvent',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `MemberLeaveEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberLeaveEventDescriptor = $convert.base64Decode(
    'ChBNZW1iZXJMZWF2ZUV2ZW50EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use memberRoleChangeEventDescriptor instead')
const MemberRoleChangeEvent$json = {
  '1': 'MemberRoleChangeEvent',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'new_role', '3': 2, '4': 1, '5': 14, '6': '.ListeningParty.RoomMemberRole', '10': 'newRole'},
  ],
};

/// Descriptor for `MemberRoleChangeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberRoleChangeEventDescriptor = $convert.base64Decode(
    'ChVNZW1iZXJSb2xlQ2hhbmdlRXZlbnQSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjkKCG5ld1'
    '9yb2xlGAIgASgOMh4uTGlzdGVuaW5nUGFydHkuUm9vbU1lbWJlclJvbGVSB25ld1JvbGU=');

@$core.Deprecated('Use roomSettingsUpdateDescriptor instead')
const RoomSettingsUpdate$json = {
  '1': 'RoomSettingsUpdate',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'description', '17': true},
    {'1': 'visibility', '3': 3, '4': 1, '5': 14, '6': '.ListeningParty.RoomVisibility', '9': 2, '10': 'visibility', '17': true},
    {'1': 'invite_only', '3': 4, '4': 1, '5': 8, '9': 3, '10': 'inviteOnly', '17': true},
  ],
  '8': [
    {'1': '_name'},
    {'1': '_description'},
    {'1': '_visibility'},
    {'1': '_invite_only'},
  ],
};

/// Descriptor for `RoomSettingsUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomSettingsUpdateDescriptor = $convert.base64Decode(
    'ChJSb29tU2V0dGluZ3NVcGRhdGUSFwoEbmFtZRgBIAEoCUgAUgRuYW1liAEBEiUKC2Rlc2NyaX'
    'B0aW9uGAIgASgJSAFSC2Rlc2NyaXB0aW9uiAEBEkMKCnZpc2liaWxpdHkYAyABKA4yHi5MaXN0'
    'ZW5pbmdQYXJ0eS5Sb29tVmlzaWJpbGl0eUgCUgp2aXNpYmlsaXR5iAEBEiQKC2ludml0ZV9vbm'
    'x5GAQgASgISANSCmludml0ZU9ubHmIAQFCBwoFX25hbWVCDgoMX2Rlc2NyaXB0aW9uQg0KC192'
    'aXNpYmlsaXR5Qg4KDF9pbnZpdGVfb25seQ==');

@$core.Deprecated('Use roomStatusUpdateDescriptor instead')
const RoomStatusUpdate$json = {
  '1': 'RoomStatusUpdate',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.ListeningParty.RoomStatus', '10': 'status'},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'reason', '17': true},
  ],
  '8': [
    {'1': '_reason'},
  ],
};

/// Descriptor for `RoomStatusUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomStatusUpdateDescriptor = $convert.base64Decode(
    'ChBSb29tU3RhdHVzVXBkYXRlEjIKBnN0YXR1cxgBIAEoDjIaLkxpc3RlbmluZ1BhcnR5LlJvb2'
    '1TdGF0dXNSBnN0YXR1cxIbCgZyZWFzb24YAiABKAlIAFIGcmVhc29uiAEBQgkKB19yZWFzb24=');

@$core.Deprecated('Use joinRoomStreamRequestDescriptor instead')
const JoinRoomStreamRequest$json = {
  '1': 'JoinRoomStreamRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `JoinRoomStreamRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRoomStreamRequestDescriptor = $convert.base64Decode(
    'ChVKb2luUm9vbVN0cmVhbVJlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEhcKB3VzZX'
    'JfaWQYAiABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use roomStreamSnapshotDescriptor instead')
const RoomStreamSnapshot$json = {
  '1': 'RoomStreamSnapshot',
  '2': [
    {'1': 'room_info', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.Room', '10': 'roomInfo'},
    {'1': 'current_playback', '3': 2, '4': 1, '5': 11, '6': '.ListeningParty.PlaybackState', '10': 'currentPlayback'},
    {'1': 'current_track', '3': 3, '4': 1, '5': 11, '6': '.ListeningParty.Track', '10': 'currentTrack'},
    {'1': 'members', '3': 4, '4': 3, '5': 11, '6': '.ListeningParty.User', '10': 'members'},
    {'1': 'member_count', '3': 5, '4': 1, '5': 5, '10': 'memberCount'},
  ],
};

/// Descriptor for `RoomStreamSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomStreamSnapshotDescriptor = $convert.base64Decode(
    'ChJSb29tU3RyZWFtU25hcHNob3QSMQoJcm9vbV9pbmZvGAEgASgLMhQuTGlzdGVuaW5nUGFydH'
    'kuUm9vbVIIcm9vbUluZm8SSAoQY3VycmVudF9wbGF5YmFjaxgCIAEoCzIdLkxpc3RlbmluZ1Bh'
    'cnR5LlBsYXliYWNrU3RhdGVSD2N1cnJlbnRQbGF5YmFjaxI6Cg1jdXJyZW50X3RyYWNrGAMgAS'
    'gLMhUuTGlzdGVuaW5nUGFydHkuVHJhY2tSDGN1cnJlbnRUcmFjaxIuCgdtZW1iZXJzGAQgAygL'
    'MhQuTGlzdGVuaW5nUGFydHkuVXNlclIHbWVtYmVycxIhCgxtZW1iZXJfY291bnQYBSABKAVSC2'
    '1lbWJlckNvdW50');

@$core.Deprecated('Use streamRoomUpdatesRequestDescriptor instead')
const StreamRoomUpdatesRequest$json = {
  '1': 'StreamRoomUpdatesRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `StreamRoomUpdatesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamRoomUpdatesRequestDescriptor = $convert.base64Decode(
    'ChhTdHJlYW1Sb29tVXBkYXRlc1JlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEhcKB3'
    'VzZXJfaWQYAiABKAlSBnVzZXJJZA==');

