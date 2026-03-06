// This is a generated file - do not edit.
//
// Generated from rooms.proto.

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

@$core.Deprecated('Use roomStatusDescriptor instead')
const RoomStatus$json = {
  '1': 'RoomStatus',
  '2': [
    {'1': 'ROOM_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'ROOM_STATUS_ACTIVE', '2': 1},
    {'1': 'ROOM_STATUS_ENDED', '2': 2},
  ],
};

/// Descriptor for `RoomStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomStatusDescriptor = $convert.base64Decode(
    'CgpSb29tU3RhdHVzEhsKF1JPT01fU1RBVFVTX1VOU1BFQ0lGSUVEEAASFgoSUk9PTV9TVEFUVV'
    'NfQUNUSVZFEAESFQoRUk9PTV9TVEFUVVNfRU5ERUQQAg==');

@$core.Deprecated('Use roomVisibilityDescriptor instead')
const RoomVisibility$json = {
  '1': 'RoomVisibility',
  '2': [
    {'1': 'ROOM_VISIBILITY_UNSPECIFIED', '2': 0},
    {'1': 'ROOM_VISIBILITY_PUBLIC', '2': 1},
    {'1': 'ROOM_VISIBILITY_PRIVATE', '2': 2},
  ],
};

/// Descriptor for `RoomVisibility`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomVisibilityDescriptor = $convert.base64Decode(
    'Cg5Sb29tVmlzaWJpbGl0eRIfChtST09NX1ZJU0lCSUxJVFlfVU5TUEVDSUZJRUQQABIaChZST0'
    '9NX1ZJU0lCSUxJVFlfUFVCTElDEAESGwoXUk9PTV9WSVNJQklMSVRZX1BSSVZBVEUQAg==');

@$core.Deprecated('Use roomMemberRoleDescriptor instead')
const RoomMemberRole$json = {
  '1': 'RoomMemberRole',
  '2': [
    {'1': 'ROOM_MEMBER_ROLE_UNSPECIFIED', '2': 0},
    {'1': 'ROOM_MEMBER_ROLE_HOST', '2': 1},
    {'1': 'ROOM_MEMBER_ROLE_LISTENER', '2': 2},
  ],
};

/// Descriptor for `RoomMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomMemberRoleDescriptor = $convert.base64Decode(
    'Cg5Sb29tTWVtYmVyUm9sZRIgChxST09NX01FTUJFUl9ST0xFX1VOU1BFQ0lGSUVEEAASGQoVUk'
    '9PTV9NRU1CRVJfUk9MRV9IT1NUEAESHQoZUk9PTV9NRU1CRVJfUk9MRV9MSVNURU5FUhAC');

@$core.Deprecated('Use roomEventTypeDescriptor instead')
const RoomEventType$json = {
  '1': 'RoomEventType',
  '2': [
    {'1': 'ROOM_EVENT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'ROOM_EVENT_TYPE_USER_JOINED', '2': 1},
    {'1': 'ROOM_EVENT_TYPE_USER_LEFT', '2': 2},
    {'1': 'ROOM_EVENT_TYPE_ROOM_ENDED', '2': 3},
    {'1': 'ROOM_EVENT_TYPE_LIVE_CHAT_MESSAGE', '2': 4},
  ],
};

/// Descriptor for `RoomEventType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roomEventTypeDescriptor = $convert.base64Decode(
    'Cg1Sb29tRXZlbnRUeXBlEh8KG1JPT01fRVZFTlRfVFlQRV9VTlNQRUNJRklFRBAAEh8KG1JPT0'
    '1fRVZFTlRfVFlQRV9VU0VSX0pPSU5FRBABEh0KGVJPT01fRVZFTlRfVFlQRV9VU0VSX0xFRlQQ'
    'AhIeChpST09NX0VWRU5UX1RZUEVfUk9PTV9FTkRFRBADEiUKIVJPT01fRVZFTlRfVFlQRV9MSV'
    'ZFX0NIQVRfTUVTU0FHRRAE');

@$core.Deprecated('Use roomDescriptor instead')
const Room$json = {
  '1': 'Room',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.room.RoomStatus',
      '10': 'status'
    },
    {
      '1': 'visibility',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.room.RoomVisibility',
      '10': 'visibility'
    },
    {'1': 'host_user_id', '3': 6, '4': 1, '5': 9, '10': 'hostUserId'},
    {
      '1': 'created_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `Room`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomDescriptor = $convert.base64Decode(
    'CgRSb29tEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhIKBGNvZGUYAyABKA'
    'lSBGNvZGUSKAoGc3RhdHVzGAQgASgOMhAucm9vbS5Sb29tU3RhdHVzUgZzdGF0dXMSNAoKdmlz'
    'aWJpbGl0eRgFIAEoDjIULnJvb20uUm9vbVZpc2liaWxpdHlSCnZpc2liaWxpdHkSIAoMaG9zdF'
    '91c2VyX2lkGAYgASgJUgpob3N0VXNlcklkEjkKCmNyZWF0ZWRfYXQYByABKAsyGi5nb29nbGUu'
    'cHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgIIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdA==');

@$core.Deprecated('Use roomMemberDescriptor instead')
const RoomMember$json = {
  '1': 'RoomMember',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'role',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.room.RoomMemberRole',
      '10': 'role'
    },
    {
      '1': 'joined_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'joinedAt'
    },
    {
      '1': 'left_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leftAt'
    },
  ],
};

/// Descriptor for `RoomMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomMemberDescriptor = $convert.base64Decode(
    'CgpSb29tTWVtYmVyEhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAIgASgJUg'
    'Z1c2VySWQSKAoEcm9sZRgDIAEoDjIULnJvb20uUm9vbU1lbWJlclJvbGVSBHJvbGUSNwoJam9p'
    'bmVkX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIam9pbmVkQXQSMwoHbG'
    'VmdF9hdBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBmxlZnRBdA==');

@$core.Deprecated('Use roomSummaryDescriptor instead')
const RoomSummary$json = {
  '1': 'RoomSummary',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'room_name', '3': 2, '4': 1, '5': 9, '10': 'roomName'},
    {'1': 'track_id', '3': 3, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'track_title', '3': 4, '4': 1, '5': 9, '10': 'trackTitle'},
    {'1': 'track_artist', '3': 5, '4': 1, '5': 9, '10': 'trackArtist'},
    {'1': 'artwork_url', '3': 6, '4': 1, '5': 9, '10': 'artworkUrl'},
    {'1': 'host_user_id', '3': 7, '4': 1, '5': 9, '10': 'hostUserId'},
    {'1': 'host_display_name', '3': 8, '4': 1, '5': 9, '10': 'hostDisplayName'},
    {'1': 'listener_count', '3': 9, '4': 1, '5': 5, '10': 'listenerCount'},
    {'1': 'is_live', '3': 10, '4': 1, '5': 8, '10': 'isLive'},
    {
      '1': 'visibility',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.room.RoomVisibility',
      '10': 'visibility'
    },
  ],
};

/// Descriptor for `RoomSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomSummaryDescriptor = $convert.base64Decode(
    'CgtSb29tU3VtbWFyeRIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSGwoJcm9vbV9uYW1lGAIgAS'
    'gJUghyb29tTmFtZRIZCgh0cmFja19pZBgDIAEoCVIHdHJhY2tJZBIfCgt0cmFja190aXRsZRgE'
    'IAEoCVIKdHJhY2tUaXRsZRIhCgx0cmFja19hcnRpc3QYBSABKAlSC3RyYWNrQXJ0aXN0Eh8KC2'
    'FydHdvcmtfdXJsGAYgASgJUgphcnR3b3JrVXJsEiAKDGhvc3RfdXNlcl9pZBgHIAEoCVIKaG9z'
    'dFVzZXJJZBIqChFob3N0X2Rpc3BsYXlfbmFtZRgIIAEoCVIPaG9zdERpc3BsYXlOYW1lEiUKDm'
    'xpc3RlbmVyX2NvdW50GAkgASgFUg1saXN0ZW5lckNvdW50EhcKB2lzX2xpdmUYCiABKAhSBmlz'
    'TGl2ZRI0Cgp2aXNpYmlsaXR5GAsgASgOMhQucm9vbS5Sb29tVmlzaWJpbGl0eVIKdmlzaWJpbG'
    'l0eQ==');

@$core.Deprecated('Use searchRoomsRequestDescriptor instead')
const SearchRoomsRequest$json = {
  '1': 'SearchRoomsRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {
      '1': 'visibility',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.room.RoomVisibility',
      '10': 'visibility'
    },
    {'1': 'page_size', '3': 3, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 4, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `SearchRoomsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRoomsRequestDescriptor = $convert.base64Decode(
    'ChJTZWFyY2hSb29tc1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EjQKCnZpc2liaWxpdH'
    'kYAiABKA4yFC5yb29tLlJvb21WaXNpYmlsaXR5Ugp2aXNpYmlsaXR5EhsKCXBhZ2Vfc2l6ZRgD'
    'IAEoBVIIcGFnZVNpemUSHQoKcGFnZV90b2tlbhgEIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use searchRoomsResponseDescriptor instead')
const SearchRoomsResponse$json = {
  '1': 'SearchRoomsResponse',
  '2': [
    {
      '1': 'rooms',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.room.RoomSummary',
      '10': 'rooms'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `SearchRoomsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRoomsResponseDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hSb29tc1Jlc3BvbnNlEicKBXJvb21zGAEgAygLMhEucm9vbS5Sb29tU3VtbWFyeV'
    'IFcm9vbXMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1uZXh0UGFnZVRva2Vu');

@$core.Deprecated('Use createRoomRequestDescriptor instead')
const CreateRoomRequest$json = {
  '1': 'CreateRoomRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {
      '1': 'visibility',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.room.RoomVisibility',
      '10': 'visibility'
    },
    {'1': 'invite_only', '3': 3, '4': 1, '5': 8, '10': 'inviteOnly'},
  ],
};

/// Descriptor for `CreateRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createRoomRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVSb29tUmVxdWVzdBISCgRuYW1lGAEgASgJUgRuYW1lEjQKCnZpc2liaWxpdHkYAi'
    'ABKA4yFC5yb29tLlJvb21WaXNpYmlsaXR5Ugp2aXNpYmlsaXR5Eh8KC2ludml0ZV9vbmx5GAMg'
    'ASgIUgppbnZpdGVPbmx5');

@$core.Deprecated('Use getRoomRequestDescriptor instead')
const GetRoomRequest$json = {
  '1': 'GetRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `GetRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRoomRequestDescriptor = $convert
    .base64Decode('Cg5HZXRSb29tUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

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

@$core.Deprecated('Use joinRoomRequestDescriptor instead')
const JoinRoomRequest$json = {
  '1': 'JoinRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'roomId'},
    {'1': 'room_code', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'roomCode'},
  ],
  '8': [
    {'1': 'identifier'},
  ],
};

/// Descriptor for `JoinRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRoomRequestDescriptor = $convert.base64Decode(
    'Cg9Kb2luUm9vbVJlcXVlc3QSGQoHcm9vbV9pZBgBIAEoCUgAUgZyb29tSWQSHQoJcm9vbV9jb2'
    'RlGAIgASgJSABSCHJvb21Db2RlQgwKCmlkZW50aWZpZXI=');

@$core.Deprecated('Use leaveRoomRequestDescriptor instead')
const LeaveRoomRequest$json = {
  '1': 'LeaveRoomRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `LeaveRoomRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveRoomRequestDescriptor = $convert.base64Decode(
    'ChBMZWF2ZVJvb21SZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZA==');

@$core.Deprecated('Use listRoomsRequestDescriptor instead')
const ListRoomsRequest$json = {
  '1': 'ListRoomsRequest',
  '2': [
    {
      '1': 'visibility',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.room.RoomVisibility',
      '10': 'visibility'
    },
    {'1': 'page_size', '3': 2, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 3, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `ListRoomsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomsRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0Um9vbXNSZXF1ZXN0EjQKCnZpc2liaWxpdHkYASABKA4yFC5yb29tLlJvb21WaXNpYm'
    'lsaXR5Ugp2aXNpYmlsaXR5EhsKCXBhZ2Vfc2l6ZRgCIAEoBVIIcGFnZVNpemUSHQoKcGFnZV90'
    'b2tlbhgDIAEoCVIJcGFnZVRva2Vu');

@$core.Deprecated('Use listRoomsResponseDescriptor instead')
const ListRoomsResponse$json = {
  '1': 'ListRoomsResponse',
  '2': [
    {
      '1': 'rooms',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.room.RoomSummary',
      '10': 'rooms'
    },
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `ListRoomsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRoomsResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0Um9vbXNSZXNwb25zZRInCgVyb29tcxgBIAMoCzIRLnJvb20uUm9vbVN1bW1hcnlSBX'
    'Jvb21zEiYKD25leHRfcGFnZV90b2tlbhgCIAEoCVINbmV4dFBhZ2VUb2tlbg==');

@$core.Deprecated('Use subscribeRequestDescriptor instead')
const SubscribeRequest$json = {
  '1': 'SubscribeRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `SubscribeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeRequestDescriptor = $convert.base64Decode(
    'ChBTdWJzY3JpYmVSZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZA==');

@$core.Deprecated('Use getListenersRequestDescriptor instead')
const GetListenersRequest$json = {
  '1': 'GetListenersRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `GetListenersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getListenersRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRMaXN0ZW5lcnNSZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZA==');

@$core.Deprecated('Use getListenersResponseDescriptor instead')
const GetListenersResponse$json = {
  '1': 'GetListenersResponse',
  '2': [
    {
      '1': 'members',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.room.JoinedMember',
      '10': 'members'
    },
    {'1': 'total_listeners', '3': 2, '4': 1, '5': 5, '10': 'totalListeners'},
  ],
};

/// Descriptor for `GetListenersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getListenersResponseDescriptor = $convert.base64Decode(
    'ChRHZXRMaXN0ZW5lcnNSZXNwb25zZRIsCgdtZW1iZXJzGAEgAygLMhIucm9vbS5Kb2luZWRNZW'
    '1iZXJSB21lbWJlcnMSJwoPdG90YWxfbGlzdGVuZXJzGAIgASgFUg50b3RhbExpc3RlbmVycw==');

@$core.Deprecated('Use joinedMemberDescriptor instead')
const JoinedMember$json = {
  '1': 'JoinedMember',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'avatar_url', '3': 4, '4': 1, '5': 9, '10': 'avatarUrl'},
  ],
};

/// Descriptor for `JoinedMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinedMemberDescriptor = $convert.base64Decode(
    'CgxKb2luZWRNZW1iZXISFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhoKCHVzZXJuYW1lGAIgAS'
    'gJUgh1c2VybmFtZRIhCgxkaXNwbGF5X25hbWUYAyABKAlSC2Rpc3BsYXlOYW1lEh0KCmF2YXRh'
    'cl91cmwYBCABKAlSCWF2YXRhclVybA==');

@$core.Deprecated('Use leftMemberDescriptor instead')
const LeftMember$json = {
  '1': 'LeftMember',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `LeftMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leftMemberDescriptor = $convert
    .base64Decode('CgpMZWZ0TWVtYmVyEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use liveChatMessageDescriptor instead')
const LiveChatMessage$json = {
  '1': 'LiveChatMessage',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `LiveChatMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List liveChatMessageDescriptor = $convert.base64Decode(
    'Cg9MaXZlQ2hhdE1lc3NhZ2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhIKBHRleHQYAiABKA'
    'lSBHRleHQ=');

@$core.Deprecated('Use roomEventDescriptor instead')
const RoomEvent$json = {
  '1': 'RoomEvent',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.room.RoomEventType',
      '10': 'type'
    },
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    {
      '1': 'joined_member',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.room.JoinedMember',
      '10': 'joinedMember'
    },
    {
      '1': 'left_member',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.room.LeftMember',
      '10': 'leftMember'
    },
    {
      '1': 'live_chat_message',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.room.LiveChatMessage',
      '10': 'liveChatMessage'
    },
  ],
};

/// Descriptor for `RoomEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomEventDescriptor = $convert.base64Decode(
    'CglSb29tRXZlbnQSJwoEdHlwZRgBIAEoDjITLnJvb20uUm9vbUV2ZW50VHlwZVIEdHlwZRIXCg'
    'dyb29tX2lkGAIgASgJUgZyb29tSWQSNwoNam9pbmVkX21lbWJlchgDIAEoCzISLnJvb20uSm9p'
    'bmVkTWVtYmVyUgxqb2luZWRNZW1iZXISMQoLbGVmdF9tZW1iZXIYBCABKAsyEC5yb29tLkxlZn'
    'RNZW1iZXJSCmxlZnRNZW1iZXISQQoRbGl2ZV9jaGF0X21lc3NhZ2UYBSABKAsyFS5yb29tLkxp'
    'dmVDaGF0TWVzc2FnZVIPbGl2ZUNoYXRNZXNzYWdl');

@$core.Deprecated('Use sendLiveChatMessageRequestDescriptor instead')
const SendLiveChatMessageRequest$json = {
  '1': 'SendLiveChatMessageRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'text', '3': 3, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `SendLiveChatMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendLiveChatMessageRequestDescriptor =
    $convert.base64Decode(
        'ChpTZW5kTGl2ZUNoYXRNZXNzYWdlUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSEg'
        'oEdGV4dBgDIAEoCVIEdGV4dA==');

@$core.Deprecated('Use inviteUserRequestDescriptor instead')
const InviteUserRequest$json = {
  '1': 'InviteUserRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'target_user_id', '3': 2, '4': 1, '5': 9, '10': 'targetUserId'},
  ],
};

/// Descriptor for `InviteUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteUserRequestDescriptor = $convert.base64Decode(
    'ChFJbnZpdGVVc2VyUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQSJAoOdGFyZ2V0X3'
    'VzZXJfaWQYAiABKAlSDHRhcmdldFVzZXJJZA==');
