//
//  Generated code. Do not modify.
//  source: protobuf/events.proto
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

@$core.Deprecated('Use playbackEventLogDescriptor instead')
const PlaybackEventLog$json = {
  '1': 'PlaybackEventLog',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 3, '10': 'eventId'},
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'event_type', '3': 4, '4': 1, '5': 14, '6': '.ListeningParty.EventType', '10': 'eventType'},
    {'1': 'event_payload', '3': 5, '4': 1, '5': 9, '10': 'eventPayload'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `PlaybackEventLog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackEventLogDescriptor = $convert.base64Decode(
    'ChBQbGF5YmFja0V2ZW50TG9nEhkKCGV2ZW50X2lkGAEgASgDUgdldmVudElkEhcKB3Jvb21faW'
    'QYAiABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSOAoKZXZlbnRfdHlwZRgE'
    'IAEoDjIZLkxpc3RlbmluZ1BhcnR5LkV2ZW50VHlwZVIJZXZlbnRUeXBlEiMKDWV2ZW50X3BheW'
    'xvYWQYBSABKAlSDGV2ZW50UGF5bG9hZBI4Cgl0aW1lc3RhbXAYBiABKAsyGi5nb29nbGUucHJv'
    'dG9idWYuVGltZXN0YW1wUgl0aW1lc3RhbXA=');

@$core.Deprecated('Use streamRoomEventsRequestDescriptor instead')
const StreamRoomEventsRequest$json = {
  '1': 'StreamRoomEventsRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `StreamRoomEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamRoomEventsRequestDescriptor = $convert.base64Decode(
    'ChdTdHJlYW1Sb29tRXZlbnRzUmVxdWVzdBIXCgdyb29tX2lkGAEgASgJUgZyb29tSWQ=');

@$core.Deprecated('Use roomEventDescriptor instead')
const RoomEvent$json = {
  '1': 'RoomEvent',
  '2': [
    {'1': 'event_id', '3': 1, '4': 1, '5': 9, '10': 'eventId'},
    {'1': 'room_id', '3': 2, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'category', '3': 3, '4': 1, '5': 14, '6': '.ListeningParty.RoomEvent.EventCategory', '10': 'category'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'details_json', '3': 5, '4': 1, '5': 9, '10': 'detailsJson'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
  '4': [RoomEvent_EventCategory$json],
};

@$core.Deprecated('Use roomEventDescriptor instead')
const RoomEvent_EventCategory$json = {
  '1': 'EventCategory',
  '2': [
    {'1': 'EVENT_CATEGORY_UNSPECIFIED', '2': 0},
    {'1': 'USER_JOINED', '2': 1},
    {'1': 'USER_LEFT', '2': 2},
    {'1': 'ROOM_SETTINGS_UPDATED', '2': 3},
  ],
};

/// Descriptor for `RoomEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomEventDescriptor = $convert.base64Decode(
    'CglSb29tRXZlbnQSGQoIZXZlbnRfaWQYASABKAlSB2V2ZW50SWQSFwoHcm9vbV9pZBgCIAEoCV'
    'IGcm9vbUlkEkMKCGNhdGVnb3J5GAMgASgOMicuTGlzdGVuaW5nUGFydHkuUm9vbUV2ZW50LkV2'
    'ZW50Q2F0ZWdvcnlSCGNhdGVnb3J5EhcKB3VzZXJfaWQYBCABKAlSBnVzZXJJZBIhCgxkZXRhaW'
    'xzX2pzb24YBSABKAlSC2RldGFpbHNKc29uEjgKCXRpbWVzdGFtcBgGIAEoCzIaLmdvb2dsZS5w'
    'cm90b2J1Zi5UaW1lc3RhbXBSCXRpbWVzdGFtcCJqCg1FdmVudENhdGVnb3J5Eh4KGkVWRU5UX0'
    'NBVEVHT1JZX1VOU1BFQ0lGSUVEEAASDwoLVVNFUl9KT0lORUQQARINCglVU0VSX0xFRlQQAhIZ'
    'ChVST09NX1NFVFRJTkdTX1VQREFURUQQAw==');

@$core.Deprecated('Use streamPlaybackEventsRequestDescriptor instead')
const StreamPlaybackEventsRequest$json = {
  '1': 'StreamPlaybackEventsRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
  ],
};

/// Descriptor for `StreamPlaybackEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamPlaybackEventsRequestDescriptor = $convert.base64Decode(
    'ChtTdHJlYW1QbGF5YmFja0V2ZW50c1JlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlk');

@$core.Deprecated('Use playbackEventDescriptor instead')
const PlaybackEvent$json = {
  '1': 'PlaybackEvent',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'event_type', '3': 3, '4': 1, '5': 14, '6': '.ListeningParty.EventType', '10': 'eventType'},
    {'1': 'track_id', '3': 4, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'position_ms', '3': 5, '4': 1, '5': 5, '10': 'positionMs'},
    {'1': 'timestamp', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'timestamp'},
  ],
};

/// Descriptor for `PlaybackEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playbackEventDescriptor = $convert.base64Decode(
    'Cg1QbGF5YmFja0V2ZW50EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBIXCgd1c2VyX2lkGAIgAS'
    'gJUgZ1c2VySWQSOAoKZXZlbnRfdHlwZRgDIAEoDjIZLkxpc3RlbmluZ1BhcnR5LkV2ZW50VHlw'
    'ZVIJZXZlbnRUeXBlEhkKCHRyYWNrX2lkGAQgASgJUgd0cmFja0lkEh8KC3Bvc2l0aW9uX21zGA'
    'UgASgFUgpwb3NpdGlvbk1zEjgKCXRpbWVzdGFtcBgGIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5U'
    'aW1lc3RhbXBSCXRpbWVzdGFtcA==');

@$core.Deprecated('Use logEventRequestDescriptor instead')
const LogEventRequest$json = {
  '1': 'LogEventRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'event_type', '3': 3, '4': 1, '5': 14, '6': '.ListeningParty.EventType', '10': 'eventType'},
    {'1': 'event_payload', '3': 4, '4': 1, '5': 9, '10': 'eventPayload'},
  ],
};

/// Descriptor for `LogEventRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logEventRequestDescriptor = $convert.base64Decode(
    'Cg9Mb2dFdmVudFJlcXVlc3QSFwoHcm9vbV9pZBgBIAEoCVIGcm9vbUlkEhcKB3VzZXJfaWQYAi'
    'ABKAlSBnVzZXJJZBI4CgpldmVudF90eXBlGAMgASgOMhkuTGlzdGVuaW5nUGFydHkuRXZlbnRU'
    'eXBlUglldmVudFR5cGUSIwoNZXZlbnRfcGF5bG9hZBgEIAEoCVIMZXZlbnRQYXlsb2Fk');

@$core.Deprecated('Use getEventHistoryRequestDescriptor instead')
const GetEventHistoryRequest$json = {
  '1': 'GetEventHistoryRequest',
  '2': [
    {'1': 'room_id', '3': 1, '4': 1, '5': 9, '10': 'roomId'},
    {'1': 'start_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startTime'},
    {'1': 'end_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endTime'},
    {'1': 'page_size', '3': 4, '4': 1, '5': 5, '10': 'pageSize'},
    {'1': 'page_token', '3': 5, '4': 1, '5': 9, '10': 'pageToken'},
  ],
};

/// Descriptor for `GetEventHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventHistoryRequestDescriptor = $convert.base64Decode(
    'ChZHZXRFdmVudEhpc3RvcnlSZXF1ZXN0EhcKB3Jvb21faWQYASABKAlSBnJvb21JZBI5CgpzdG'
    'FydF90aW1lGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJc3RhcnRUaW1lEjUK'
    'CGVuZF90aW1lGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHZW5kVGltZRIbCg'
    'lwYWdlX3NpemUYBCABKAVSCHBhZ2VTaXplEh0KCnBhZ2VfdG9rZW4YBSABKAlSCXBhZ2VUb2tl'
    'bg==');

@$core.Deprecated('Use getEventHistoryResponseDescriptor instead')
const GetEventHistoryResponse$json = {
  '1': 'GetEventHistoryResponse',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.ListeningParty.PlaybackEventLog', '10': 'events'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '10': 'nextPageToken'},
  ],
};

/// Descriptor for `GetEventHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEventHistoryResponseDescriptor = $convert.base64Decode(
    'ChdHZXRFdmVudEhpc3RvcnlSZXNwb25zZRI4CgZldmVudHMYASADKAsyIC5MaXN0ZW5pbmdQYX'
    'J0eS5QbGF5YmFja0V2ZW50TG9nUgZldmVudHMSJgoPbmV4dF9wYWdlX3Rva2VuGAIgASgJUg1u'
    'ZXh0UGFnZVRva2Vu');

