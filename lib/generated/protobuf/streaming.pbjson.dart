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

@$core.Deprecated('Use syncRequestDescriptor instead')
const SyncRequest$json = {
  '1': 'SyncRequest',
  '2': [
    {'1': 'client_send_ms', '3': 1, '4': 1, '5': 3, '10': 'clientSendMs'},
  ],
};

/// Descriptor for `SyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncRequestDescriptor = $convert.base64Decode(
    'CgtTeW5jUmVxdWVzdBIkCg5jbGllbnRfc2VuZF9tcxgBIAEoA1IMY2xpZW50U2VuZE1z');

@$core.Deprecated('Use syncReplyDescriptor instead')
const SyncReply$json = {
  '1': 'SyncReply',
  '2': [
    {'1': 'server_receive_ms', '3': 1, '4': 1, '5': 3, '10': 'serverReceiveMs'},
    {'1': 'server_send_ms', '3': 2, '4': 1, '5': 3, '10': 'serverSendMs'},
  ],
};

/// Descriptor for `SyncReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncReplyDescriptor = $convert.base64Decode(
    'CglTeW5jUmVwbHkSKgoRc2VydmVyX3JlY2VpdmVfbXMYASABKANSD3NlcnZlclJlY2VpdmVNcx'
    'IkCg5zZXJ2ZXJfc2VuZF9tcxgCIAEoA1IMc2VydmVyU2VuZE1z');

@$core.Deprecated('Use hostTrackCommandDescriptor instead')
const HostTrackCommand$json = {
  '1': 'HostTrackCommand',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'track', '3': 2, '4': 1, '5': 11, '6': '.ListeningParty.Track', '10': 'track'},
    {'1': 'start_at_server_ms', '3': 3, '4': 1, '5': 3, '10': 'startAtServerMs'},
    {'1': 'start_position', '3': 4, '4': 1, '5': 3, '10': 'startPosition'},
    {'1': 'host_user_id', '3': 6, '4': 1, '5': 9, '10': 'hostUserId'},
  ],
};

/// Descriptor for `HostTrackCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hostTrackCommandDescriptor = $convert.base64Decode(
    'ChBIb3N0VHJhY2tDb21tYW5kEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIrCgV0cmFjaxgCIA'
    'EoCzIVLkxpc3RlbmluZ1BhcnR5LlRyYWNrUgV0cmFjaxIrChJzdGFydF9hdF9zZXJ2ZXJfbXMY'
    'AyABKANSD3N0YXJ0QXRTZXJ2ZXJNcxIlCg5zdGFydF9wb3NpdGlvbhgEIAEoA1INc3RhcnRQb3'
    'NpdGlvbhIgCgxob3N0X3VzZXJfaWQYBiABKAlSCmhvc3RVc2VySWQ=');

@$core.Deprecated('Use hostPositionUpdateDescriptor instead')
const HostPositionUpdate$json = {
  '1': 'HostPositionUpdate',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'current_position_ms', '3': 2, '4': 1, '5': 3, '10': 'currentPositionMs'},
    {'1': 'server_timestamp_ms', '3': 3, '4': 1, '5': 3, '10': 'serverTimestampMs'},
    {'1': 'host_user_id', '3': 4, '4': 1, '5': 9, '10': 'hostUserId'},
  ],
};

/// Descriptor for `HostPositionUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hostPositionUpdateDescriptor = $convert.base64Decode(
    'ChJIb3N0UG9zaXRpb25VcGRhdGUSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEi4KE2N1cnJlbn'
    'RfcG9zaXRpb25fbXMYAiABKANSEWN1cnJlbnRQb3NpdGlvbk1zEi4KE3NlcnZlcl90aW1lc3Rh'
    'bXBfbXMYAyABKANSEXNlcnZlclRpbWVzdGFtcE1zEiAKDGhvc3RfdXNlcl9pZBgEIAEoCVIKaG'
    '9zdFVzZXJJZA==');

@$core.Deprecated('Use hostPlaybackCommandDescriptor instead')
const HostPlaybackCommand$json = {
  '1': 'HostPlaybackCommand',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.ListeningParty.HostPlaybackCommand.CommandType', '10': 'type'},
    {'1': 'execute_at_server_ms', '3': 3, '4': 1, '5': 3, '10': 'executeAtServerMs'},
    {'1': 'position_ms', '3': 4, '4': 1, '5': 3, '10': 'positionMs'},
    {'1': 'host_user_id', '3': 5, '4': 1, '5': 9, '10': 'hostUserId'},
  ],
  '4': [HostPlaybackCommand_CommandType$json],
};

@$core.Deprecated('Use hostPlaybackCommandDescriptor instead')
const HostPlaybackCommand_CommandType$json = {
  '1': 'CommandType',
  '2': [
    {'1': 'PLAY', '2': 0},
    {'1': 'PAUSE', '2': 1},
    {'1': 'SEEK', '2': 2},
    {'1': 'TRACK_CHANGE', '2': 3},
    {'1': 'ADJUST_RATE', '2': 4},
  ],
};

/// Descriptor for `HostPlaybackCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hostPlaybackCommandDescriptor = $convert.base64Decode(
    'ChNIb3N0UGxheWJhY2tDb21tYW5kEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBJDCgR0eXBlGA'
    'IgASgOMi8uTGlzdGVuaW5nUGFydHkuSG9zdFBsYXliYWNrQ29tbWFuZC5Db21tYW5kVHlwZVIE'
    'dHlwZRIvChRleGVjdXRlX2F0X3NlcnZlcl9tcxgDIAEoA1IRZXhlY3V0ZUF0U2VydmVyTXMSHw'
    'oLcG9zaXRpb25fbXMYBCABKANSCnBvc2l0aW9uTXMSIAoMaG9zdF91c2VyX2lkGAUgASgJUgpo'
    'b3N0VXNlcklkIk8KC0NvbW1hbmRUeXBlEggKBFBMQVkQABIJCgVQQVVTRRABEggKBFNFRUsQAh'
    'IQCgxUUkFDS19DSEFOR0UQAxIPCgtBREpVU1RfUkFURRAE');

@$core.Deprecated('Use hostCommandDescriptor instead')
const HostCommand$json = {
  '1': 'HostCommand',
  '2': [
    {'1': 'track_command', '3': 1, '4': 1, '5': 11, '6': '.ListeningParty.HostTrackCommand', '9': 0, '10': 'trackCommand'},
    {'1': 'position_update', '3': 2, '4': 1, '5': 11, '6': '.ListeningParty.HostPositionUpdate', '9': 0, '10': 'positionUpdate'},
    {'1': 'control_command', '3': 3, '4': 1, '5': 11, '6': '.ListeningParty.HostPlaybackCommand', '9': 0, '10': 'controlCommand'},
  ],
  '8': [
    {'1': 'command'},
  ],
};

/// Descriptor for `HostCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hostCommandDescriptor = $convert.base64Decode(
    'CgtIb3N0Q29tbWFuZBJHCg10cmFja19jb21tYW5kGAEgASgLMiAuTGlzdGVuaW5nUGFydHkuSG'
    '9zdFRyYWNrQ29tbWFuZEgAUgx0cmFja0NvbW1hbmQSTQoPcG9zaXRpb25fdXBkYXRlGAIgASgL'
    'MiIuTGlzdGVuaW5nUGFydHkuSG9zdFBvc2l0aW9uVXBkYXRlSABSDnBvc2l0aW9uVXBkYXRlEk'
    '4KD2NvbnRyb2xfY29tbWFuZBgDIAEoCzIjLkxpc3RlbmluZ1BhcnR5Lkhvc3RQbGF5YmFja0Nv'
    'bW1hbmRIAFIOY29udHJvbENvbW1hbmRCCQoHY29tbWFuZA==');

@$core.Deprecated('Use memberStatusDescriptor instead')
const MemberStatus$json = {
  '1': 'MemberStatus',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.ListeningParty.MemberStatus.StatusType', '10': 'status'},
    {'1': 'actual_position_ms', '3': 4, '4': 1, '5': 3, '10': 'actualPositionMs'},
    {'1': 'client_timestamp_ms', '3': 5, '4': 1, '5': 3, '10': 'clientTimestampMs'},
    {'1': 'error_message', '3': 6, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
  '4': [MemberStatus_StatusType$json],
};

@$core.Deprecated('Use memberStatusDescriptor instead')
const MemberStatus_StatusType$json = {
  '1': 'StatusType',
  '2': [
    {'1': 'JOINED', '2': 0},
    {'1': 'TRACK_LOADED', '2': 1},
    {'1': 'READY_TO_PLAY', '2': 2},
    {'1': 'PLAYING', '2': 3},
    {'1': 'PAUSED', '2': 4},
    {'1': 'SYNCING', '2': 5},
    {'1': 'SYNCED', '2': 6},
    {'1': 'DESYNC', '2': 7},
    {'1': 'ERROR', '2': 8},
  ],
};

/// Descriptor for `MemberStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberStatusDescriptor = $convert.base64Decode(
    'CgxNZW1iZXJTdGF0dXMSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEhcKB3VzZXJfaWQYAiABKA'
    'lSBnVzZXJJZBI/CgZzdGF0dXMYAyABKA4yJy5MaXN0ZW5pbmdQYXJ0eS5NZW1iZXJTdGF0dXMu'
    'U3RhdHVzVHlwZVIGc3RhdHVzEiwKEmFjdHVhbF9wb3NpdGlvbl9tcxgEIAEoA1IQYWN0dWFsUG'
    '9zaXRpb25NcxIuChNjbGllbnRfdGltZXN0YW1wX21zGAUgASgDUhFjbGllbnRUaW1lc3RhbXBN'
    'cxIjCg1lcnJvcl9tZXNzYWdlGAYgASgJUgxlcnJvck1lc3NhZ2UihgEKClN0YXR1c1R5cGUSCg'
    'oGSk9JTkVEEAASEAoMVFJBQ0tfTE9BREVEEAESEQoNUkVBRFlfVE9fUExBWRACEgsKB1BMQVlJ'
    'TkcQAxIKCgZQQVVTRUQQBBILCgdTWU5DSU5HEAUSCgoGU1lOQ0VEEAYSCgoGREVTWU5DEAcSCQ'
    'oFRVJST1IQCA==');

@$core.Deprecated('Use serverBroadcastDescriptor instead')
const ServerBroadcast$json = {
  '1': 'ServerBroadcast',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.ListeningParty.ServerBroadcast.BroadcastType', '10': 'type'},
    {'1': 'track_command', '3': 3, '4': 1, '5': 11, '6': '.ListeningParty.HostTrackCommand', '10': 'trackCommand'},
    {'1': 'position_update', '3': 4, '4': 1, '5': 11, '6': '.ListeningParty.HostPositionUpdate', '10': 'positionUpdate'},
    {'1': 'control_command', '3': 5, '4': 1, '5': 11, '6': '.ListeningParty.HostPlaybackCommand', '10': 'controlCommand'},
    {'1': 'new_host_user_id', '3': 6, '4': 1, '5': 9, '10': 'newHostUserId'},
    {'1': 'affected_user_id', '3': 7, '4': 1, '5': 9, '10': 'affectedUserId'},
  ],
  '4': [ServerBroadcast_BroadcastType$json],
};

@$core.Deprecated('Use serverBroadcastDescriptor instead')
const ServerBroadcast_BroadcastType$json = {
  '1': 'BroadcastType',
  '2': [
    {'1': 'TRACK_COMMAND', '2': 0},
    {'1': 'POSITION_UPDATE', '2': 1},
    {'1': 'CONTROL_COMMAND', '2': 2},
    {'1': 'HOST_CHANGED', '2': 3},
    {'1': 'MEMBER_JOINED', '2': 4},
    {'1': 'MEMBER_LEFT', '2': 5},
  ],
};

/// Descriptor for `ServerBroadcast`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverBroadcastDescriptor = $convert.base64Decode(
    'Cg9TZXJ2ZXJCcm9hZGNhc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEkEKBHR5cGUYAiABKA'
    '4yLS5MaXN0ZW5pbmdQYXJ0eS5TZXJ2ZXJCcm9hZGNhc3QuQnJvYWRjYXN0VHlwZVIEdHlwZRJF'
    'Cg10cmFja19jb21tYW5kGAMgASgLMiAuTGlzdGVuaW5nUGFydHkuSG9zdFRyYWNrQ29tbWFuZF'
    'IMdHJhY2tDb21tYW5kEksKD3Bvc2l0aW9uX3VwZGF0ZRgEIAEoCzIiLkxpc3RlbmluZ1BhcnR5'
    'Lkhvc3RQb3NpdGlvblVwZGF0ZVIOcG9zaXRpb25VcGRhdGUSTAoPY29udHJvbF9jb21tYW5kGA'
    'UgASgLMiMuTGlzdGVuaW5nUGFydHkuSG9zdFBsYXliYWNrQ29tbWFuZFIOY29udHJvbENvbW1h'
    'bmQSJwoQbmV3X2hvc3RfdXNlcl9pZBgGIAEoCVINbmV3SG9zdFVzZXJJZBIoChBhZmZlY3RlZF'
    '91c2VyX2lkGAcgASgJUg5hZmZlY3RlZFVzZXJJZCKCAQoNQnJvYWRjYXN0VHlwZRIRCg1UUkFD'
    'S19DT01NQU5EEAASEwoPUE9TSVRJT05fVVBEQVRFEAESEwoPQ09OVFJPTF9DT01NQU5EEAISEA'
    'oMSE9TVF9DSEFOR0VEEAMSEQoNTUVNQkVSX0pPSU5FRBAEEg8KC01FTUJFUl9MRUZUEAU=');

@$core.Deprecated('Use serverResponseDescriptor instead')
const ServerResponse$json = {
  '1': 'ServerResponse',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.ListeningParty.ServerResponse.ResponseType', '10': 'type'},
    {'1': 'ready_member_count', '3': 2, '4': 1, '5': 5, '10': 'readyMemberCount'},
    {'1': 'total_member_count', '3': 3, '4': 1, '5': 5, '10': 'totalMemberCount'},
    {'1': 'member_statuses', '3': 4, '4': 3, '5': 11, '6': '.ListeningParty.MemberStatus', '10': 'memberStatuses'},
    {'1': 'error_message', '3': 5, '4': 1, '5': 9, '10': 'errorMessage'},
  ],
  '4': [ServerResponse_ResponseType$json],
};

@$core.Deprecated('Use serverResponseDescriptor instead')
const ServerResponse_ResponseType$json = {
  '1': 'ResponseType',
  '2': [
    {'1': 'ACKNOWLEDGED', '2': 0},
    {'1': 'MEMBER_COUNT_UPDATE', '2': 1},
    {'1': 'MEMBER_STATUS_UPDATE', '2': 2},
    {'1': 'ERROR', '2': 3},
  ],
};

/// Descriptor for `ServerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverResponseDescriptor = $convert.base64Decode(
    'Cg5TZXJ2ZXJSZXNwb25zZRI/CgR0eXBlGAEgASgOMisuTGlzdGVuaW5nUGFydHkuU2VydmVyUm'
    'VzcG9uc2UuUmVzcG9uc2VUeXBlUgR0eXBlEiwKEnJlYWR5X21lbWJlcl9jb3VudBgCIAEoBVIQ'
    'cmVhZHlNZW1iZXJDb3VudBIsChJ0b3RhbF9tZW1iZXJfY291bnQYAyABKAVSEHRvdGFsTWVtYm'
    'VyQ291bnQSRQoPbWVtYmVyX3N0YXR1c2VzGAQgAygLMhwuTGlzdGVuaW5nUGFydHkuTWVtYmVy'
    'U3RhdHVzUg5tZW1iZXJTdGF0dXNlcxIjCg1lcnJvcl9tZXNzYWdlGAUgASgJUgxlcnJvck1lc3'
    'NhZ2UiXgoMUmVzcG9uc2VUeXBlEhAKDEFDS05PV0xFREdFRBAAEhcKE01FTUJFUl9DT1VOVF9V'
    'UERBVEUQARIYChRNRU1CRVJfU1RBVFVTX1VQREFURRACEgkKBUVSUk9SEAM=');

