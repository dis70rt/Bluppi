// This is a generated file - do not edit.
//
// Generated from tracks.proto.

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

@$core.Deprecated('Use timeRangeDescriptor instead')
const TimeRange$json = {
  '1': 'TimeRange',
  '2': [
    {'1': 'TIME_RANGE_ALL_TIME', '2': 0},
    {'1': 'TIME_RANGE_LAST_7_DAYS', '2': 1},
    {'1': 'TIME_RANGE_LAST_30_DAYS', '2': 2},
  ],
};

/// Descriptor for `TimeRange`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List timeRangeDescriptor = $convert.base64Decode(
    'CglUaW1lUmFuZ2USFwoTVElNRV9SQU5HRV9BTExfVElNRRAAEhoKFlRJTUVfUkFOR0VfTEFTVF'
    '83X0RBWVMQARIbChdUSU1FX1JBTkdFX0xBU1RfMzBfREFZUxAC');

@$core.Deprecated('Use trackDescriptor instead')
const Track$json = {
  '1': 'Track',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'duration_ms', '3': 5, '4': 1, '5': 5, '10': 'durationMs'},
    {'1': 'genres', '3': 6, '4': 3, '5': 9, '10': 'genres'},
    {'1': 'image_small', '3': 7, '4': 1, '5': 9, '10': 'imageSmall'},
    {'1': 'image_large', '3': 8, '4': 1, '5': 9, '10': 'imageLarge'},
    {'1': 'preview_url', '3': 9, '4': 1, '5': 9, '10': 'previewUrl'},
    {'1': 'video_id', '3': 10, '4': 1, '5': 9, '10': 'videoId'},
    {'1': 'listeners', '3': 11, '4': 1, '5': 3, '10': 'listeners'},
    {'1': 'play_count', '3': 12, '4': 1, '5': 3, '10': 'playCount'},
    {'1': 'popularity', '3': 13, '4': 1, '5': 5, '10': 'popularity'},
    {
      '1': 'created_at',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Track`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackDescriptor = $convert.base64Decode(
    'CgVUcmFjaxIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhYKBmFydGlzdB'
    'gDIAEoCVIGYXJ0aXN0Eh8KC2R1cmF0aW9uX21zGAUgASgFUgpkdXJhdGlvbk1zEhYKBmdlbnJl'
    'cxgGIAMoCVIGZ2VucmVzEh8KC2ltYWdlX3NtYWxsGAcgASgJUgppbWFnZVNtYWxsEh8KC2ltYW'
    'dlX2xhcmdlGAggASgJUgppbWFnZUxhcmdlEh8KC3ByZXZpZXdfdXJsGAkgASgJUgpwcmV2aWV3'
    'VXJsEhkKCHZpZGVvX2lkGAogASgJUgd2aWRlb0lkEhwKCWxpc3RlbmVycxgLIAEoA1IJbGlzdG'
    'VuZXJzEh0KCnBsYXlfY291bnQYDCABKANSCXBsYXlDb3VudBIeCgpwb3B1bGFyaXR5GA0gASgF'
    'Ugpwb3B1bGFyaXR5EjkKCmNyZWF0ZWRfYXQYDiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZX'
    'N0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use searchTrackDescriptor instead')
const SearchTrack$json = {
  '1': 'SearchTrack',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'image_small', '3': 5, '4': 1, '5': 9, '10': 'imageSmall'},
    {'1': 'preview_url', '3': 6, '4': 1, '5': 9, '10': 'previewUrl'},
  ],
};

/// Descriptor for `SearchTrack`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTrackDescriptor = $convert.base64Decode(
    'CgtTZWFyY2hUcmFjaxIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEhYKBm'
    'FydGlzdBgDIAEoCVIGYXJ0aXN0Eh8KC2ltYWdlX3NtYWxsGAUgASgJUgppbWFnZVNtYWxsEh8K'
    'C3ByZXZpZXdfdXJsGAYgASgJUgpwcmV2aWV3VXJs');

@$core.Deprecated('Use trackResponseDescriptor instead')
const TrackResponse$json = {
  '1': 'TrackResponse',
  '2': [
    {
      '1': 'track',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.tracks.Track',
      '10': 'track'
    },
  ],
};

/// Descriptor for `TrackResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackResponseDescriptor = $convert.base64Decode(
    'Cg1UcmFja1Jlc3BvbnNlEiMKBXRyYWNrGAEgASgLMg0udHJhY2tzLlRyYWNrUgV0cmFjaw==');

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
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 3, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `SearchTracksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTracksRequestDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hUcmFja3NSZXF1ZXN0EhQKBXF1ZXJ5GAEgASgJUgVxdWVyeRIUCgVsaW1pdBgCIA'
    'EoBVIFbGltaXQSFgoGY3Vyc29yGAMgASgJUgZjdXJzb3I=');

@$core.Deprecated('Use searchTracksResponseDescriptor instead')
const SearchTracksResponse$json = {
  '1': 'SearchTracksResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.SearchTrack',
      '10': 'tracks'
    },
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'next_cursor', '3': 4, '4': 1, '5': 9, '10': 'nextCursor'},
  ],
};

/// Descriptor for `SearchTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchTracksResponseDescriptor = $convert.base64Decode(
    'ChRTZWFyY2hUcmFja3NSZXNwb25zZRIrCgZ0cmFja3MYASADKAsyEy50cmFja3MuU2VhcmNoVH'
    'JhY2tSBnRyYWNrcxIUCgVxdWVyeRgCIAEoCVIFcXVlcnkSFAoFbGltaXQYAyABKAVSBWxpbWl0'
    'Eh8KC25leHRfY3Vyc29yGAQgASgJUgpuZXh0Q3Vyc29y');

@$core.Deprecated('Use getPopularTracksRequestDescriptor instead')
const GetPopularTracksRequest$json = {
  '1': 'GetPopularTracksRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetPopularTracksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPopularTracksRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRQb3B1bGFyVHJhY2tzUmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getTracksByGenreRequestDescriptor instead')
const GetTracksByGenreRequest$json = {
  '1': 'GetTracksByGenreRequest',
  '2': [
    {'1': 'genre', '3': 1, '4': 1, '5': 9, '10': 'genre'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetTracksByGenreRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTracksByGenreRequestDescriptor =
    $convert.base64Decode(
        'ChdHZXRUcmFja3NCeUdlbnJlUmVxdWVzdBIUCgVnZW5yZRgBIAEoCVIFZ2VucmUSFAoFbGltaX'
        'QYAiABKAVSBWxpbWl0EhYKBm9mZnNldBgDIAEoBVIGb2Zmc2V0');

@$core.Deprecated('Use getTracksResponseDescriptor instead')
const GetTracksResponse$json = {
  '1': 'GetTracksResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.Track',
      '10': 'tracks'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTracksResponseDescriptor = $convert.base64Decode(
    'ChFHZXRUcmFja3NSZXNwb25zZRIlCgZ0cmFja3MYASADKAsyDS50cmFja3MuVHJhY2tSBnRyYW'
    'NrcxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');

@$core.Deprecated('Use likeTrackRequestDescriptor instead')
const LikeTrackRequest$json = {
  '1': 'LikeTrackRequest',
  '2': [
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
  ],
};

/// Descriptor for `LikeTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List likeTrackRequestDescriptor = $convert.base64Decode(
    'ChBMaWtlVHJhY2tSZXF1ZXN0EhkKCHRyYWNrX2lkGAIgASgJUgd0cmFja0lk');

@$core.Deprecated('Use unlikeTrackRequestDescriptor instead')
const UnlikeTrackRequest$json = {
  '1': 'UnlikeTrackRequest',
  '2': [
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
  ],
};

/// Descriptor for `UnlikeTrackRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unlikeTrackRequestDescriptor =
    $convert.base64Decode(
        'ChJVbmxpa2VUcmFja1JlcXVlc3QSGQoIdHJhY2tfaWQYAiABKAlSB3RyYWNrSWQ=');

@$core.Deprecated('Use statusResponseDescriptor instead')
const StatusResponse$json = {
  '1': 'StatusResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `StatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusResponseDescriptor = $convert.base64Decode(
    'Cg5TdGF0dXNSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAi'
    'ABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use getLikedTracksRequestDescriptor instead')
const GetLikedTracksRequest$json = {
  '1': 'GetLikedTracksRequest',
  '2': [
    {'1': 'target_user_id', '3': 1, '4': 1, '5': 9, '10': 'targetUserId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 3, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `GetLikedTracksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLikedTracksRequestDescriptor = $convert.base64Decode(
    'ChVHZXRMaWtlZFRyYWNrc1JlcXVlc3QSJAoOdGFyZ2V0X3VzZXJfaWQYASABKAlSDHRhcmdldF'
    'VzZXJJZBIUCgVsaW1pdBgCIAEoBVIFbGltaXQSFgoGY3Vyc29yGAMgASgJUgZjdXJzb3I=');

@$core.Deprecated('Use likedTrackEntryDescriptor instead')
const LikedTrackEntry$json = {
  '1': 'LikedTrackEntry',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'image_small', '3': 5, '4': 1, '5': 9, '10': 'imageSmall'},
    {
      '1': 'liked_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'likedAt'
    },
  ],
};

/// Descriptor for `LikedTrackEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List likedTrackEntryDescriptor = $convert.base64Decode(
    'Cg9MaWtlZFRyYWNrRW50cnkSGQoIdHJhY2tfaWQYASABKAlSB3RyYWNrSWQSFAoFdGl0bGUYAi'
    'ABKAlSBXRpdGxlEhYKBmFydGlzdBgDIAEoCVIGYXJ0aXN0Eh8KC2ltYWdlX3NtYWxsGAUgASgJ'
    'UgppbWFnZVNtYWxsEjUKCGxpa2VkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIHbGlrZWRBdA==');

@$core.Deprecated('Use getLikedTracksResponseDescriptor instead')
const GetLikedTracksResponse$json = {
  '1': 'GetLikedTracksResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.LikedTrackEntry',
      '10': 'tracks'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
    {'1': 'next_cursor', '3': 3, '4': 1, '5': 9, '10': 'nextCursor'},
    {'1': 'has_more', '3': 4, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetLikedTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getLikedTracksResponseDescriptor = $convert.base64Decode(
    'ChZHZXRMaWtlZFRyYWNrc1Jlc3BvbnNlEi8KBnRyYWNrcxgBIAMoCzIXLnRyYWNrcy5MaWtlZF'
    'RyYWNrRW50cnlSBnRyYWNrcxIUCgV0b3RhbBgCIAEoA1IFdG90YWwSHwoLbmV4dF9jdXJzb3IY'
    'AyABKAlSCm5leHRDdXJzb3ISGQoIaGFzX21vcmUYBCABKAhSB2hhc01vcmU=');

@$core.Deprecated('Use isTrackLikedRequestDescriptor instead')
const IsTrackLikedRequest$json = {
  '1': 'IsTrackLikedRequest',
  '2': [
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
  ],
};

/// Descriptor for `IsTrackLikedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isTrackLikedRequestDescriptor =
    $convert.base64Decode(
        'ChNJc1RyYWNrTGlrZWRSZXF1ZXN0EhkKCHRyYWNrX2lkGAIgASgJUgd0cmFja0lk');

@$core.Deprecated('Use isTrackLikedResponseDescriptor instead')
const IsTrackLikedResponse$json = {
  '1': 'IsTrackLikedResponse',
  '2': [
    {'1': 'is_liked', '3': 1, '4': 1, '5': 8, '10': 'isLiked'},
  ],
};

/// Descriptor for `IsTrackLikedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isTrackLikedResponseDescriptor =
    $convert.base64Decode(
        'ChRJc1RyYWNrTGlrZWRSZXNwb25zZRIZCghpc19saWtlZBgBIAEoCFIHaXNMaWtlZA==');

@$core.Deprecated('Use addTrackToHistoryRequestDescriptor instead')
const AddTrackToHistoryRequest$json = {
  '1': 'AddTrackToHistoryRequest',
  '2': [
    {'1': 'track_id', '3': 2, '4': 1, '5': 9, '10': 'trackId'},
  ],
};

/// Descriptor for `AddTrackToHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addTrackToHistoryRequestDescriptor =
    $convert.base64Decode(
        'ChhBZGRUcmFja1RvSGlzdG9yeVJlcXVlc3QSGQoIdHJhY2tfaWQYAiABKAlSB3RyYWNrSWQ=');

@$core.Deprecated('Use getTrackHistoryRequestDescriptor instead')
const GetTrackHistoryRequest$json = {
  '1': 'GetTrackHistoryRequest',
  '2': [
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetTrackHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackHistoryRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRUcmFja0hpc3RvcnlSZXF1ZXN0EhQKBWxpbWl0GAIgASgFUgVsaW1pdBIWCgZvZmZzZX'
        'QYAyABKAVSBm9mZnNldA==');

@$core.Deprecated('Use historyTrackEntryDescriptor instead')
const HistoryTrackEntry$json = {
  '1': 'HistoryTrackEntry',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'image_large', '3': 4, '4': 1, '5': 9, '10': 'imageLarge'},
    {'1': 'image_small', '3': 5, '4': 1, '5': 9, '10': 'imageSmall'},
    {
      '1': 'played_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'playedAt'
    },
  ],
};

/// Descriptor for `HistoryTrackEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyTrackEntryDescriptor = $convert.base64Decode(
    'ChFIaXN0b3J5VHJhY2tFbnRyeRIZCgh0cmFja19pZBgBIAEoCVIHdHJhY2tJZBIUCgV0aXRsZR'
    'gCIAEoCVIFdGl0bGUSFgoGYXJ0aXN0GAMgASgJUgZhcnRpc3QSHwoLaW1hZ2VfbGFyZ2UYBCAB'
    'KAlSCmltYWdlTGFyZ2USHwoLaW1hZ2Vfc21hbGwYBSABKAlSCmltYWdlU21hbGwSNwoJcGxheW'
    'VkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIIcGxheWVkQXQ=');

@$core.Deprecated('Use getTrackHistoryResponseDescriptor instead')
const GetTrackHistoryResponse$json = {
  '1': 'GetTrackHistoryResponse',
  '2': [
    {
      '1': 'history',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.HistoryTrackEntry',
      '10': 'history'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetTrackHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTrackHistoryResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRUcmFja0hpc3RvcnlSZXNwb25zZRIzCgdoaXN0b3J5GAEgAygLMhkudHJhY2tzLkhpc3'
        'RvcnlUcmFja0VudHJ5UgdoaXN0b3J5EhQKBXRvdGFsGAIgASgDUgV0b3RhbA==');

@$core.Deprecated('Use clearTrackHistoryRequestDescriptor instead')
const ClearTrackHistoryRequest$json = {
  '1': 'ClearTrackHistoryRequest',
};

/// Descriptor for `ClearTrackHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearTrackHistoryRequestDescriptor =
    $convert.base64Decode('ChhDbGVhclRyYWNrSGlzdG9yeVJlcXVlc3Q=');

@$core.Deprecated('Use getRecommendationsRequestDescriptor instead')
const GetRecommendationsRequest$json = {
  '1': 'GetRecommendationsRequest',
  '2': [
    {'1': 'video_id', '3': 1, '4': 1, '5': 9, '10': 'videoId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRecommendationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecommendationsRequestDescriptor =
    $convert.base64Decode(
        'ChlHZXRSZWNvbW1lbmRhdGlvbnNSZXF1ZXN0EhkKCHZpZGVvX2lkGAEgASgJUgd2aWRlb0lkEh'
        'QKBWxpbWl0GAIgASgFUgVsaW1pdA==');

@$core.Deprecated('Use getRecommendationsResponseDescriptor instead')
const GetRecommendationsResponse$json = {
  '1': 'GetRecommendationsResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.Track',
      '10': 'tracks'
    },
  ],
};

/// Descriptor for `GetRecommendationsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecommendationsResponseDescriptor =
    $convert.base64Decode(
        'ChpHZXRSZWNvbW1lbmRhdGlvbnNSZXNwb25zZRIlCgZ0cmFja3MYASADKAsyDS50cmFja3MuVH'
        'JhY2tSBnRyYWNrcw==');

@$core.Deprecated('Use trackSummaryDescriptor instead')
const TrackSummary$json = {
  '1': 'TrackSummary',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'preview_url', '3': 5, '4': 1, '5': 9, '10': 'previewUrl'},
    {
      '1': 'social_count',
      '3': 6,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'socialCount',
      '17': true
    },
    {
      '1': 'social_context',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'socialContext',
      '17': true
    },
  ],
  '8': [
    {'1': '_social_count'},
    {'1': '_social_context'},
  ],
};

/// Descriptor for `TrackSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackSummaryDescriptor = $convert.base64Decode(
    'CgxUcmFja1N1bW1hcnkSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIWCg'
    'ZhcnRpc3QYAyABKAlSBmFydGlzdBIbCglpbWFnZV91cmwYBCABKAlSCGltYWdlVXJsEh8KC3By'
    'ZXZpZXdfdXJsGAUgASgJUgpwcmV2aWV3VXJsEiYKDHNvY2lhbF9jb3VudBgGIAEoBUgAUgtzb2'
    'NpYWxDb3VudIgBARIqCg5zb2NpYWxfY29udGV4dBgHIAEoCUgBUg1zb2NpYWxDb250ZXh0iAEB'
    'Qg8KDV9zb2NpYWxfY291bnRCEQoPX3NvY2lhbF9jb250ZXh0');

@$core.Deprecated('Use discoverTracksRequestDescriptor instead')
const DiscoverTracksRequest$json = {
  '1': 'DiscoverTracksRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'next_cursor', '3': 2, '4': 1, '5': 9, '10': 'nextCursor'},
  ],
};

/// Descriptor for `DiscoverTracksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List discoverTracksRequestDescriptor = $convert.base64Decode(
    'ChVEaXNjb3ZlclRyYWNrc1JlcXVlc3QSFAoFbGltaXQYASABKAVSBWxpbWl0Eh8KC25leHRfY3'
    'Vyc29yGAIgASgJUgpuZXh0Q3Vyc29y');

@$core.Deprecated('Use discoverTracksResponseDescriptor instead')
const DiscoverTracksResponse$json = {
  '1': 'DiscoverTracksResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.TrackSummary',
      '10': 'tracks'
    },
    {'1': 'next_cursor', '3': 2, '4': 1, '5': 9, '10': 'nextCursor'},
    {'1': 'has_more', '3': 3, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `DiscoverTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List discoverTracksResponseDescriptor = $convert.base64Decode(
    'ChZEaXNjb3ZlclRyYWNrc1Jlc3BvbnNlEiwKBnRyYWNrcxgBIAMoCzIULnRyYWNrcy5UcmFja1'
    'N1bW1hcnlSBnRyYWNrcxIfCgtuZXh0X2N1cnNvchgCIAEoCVIKbmV4dEN1cnNvchIZCghoYXNf'
    'bW9yZRgDIAEoCFIHaGFzTW9yZQ==');

@$core.Deprecated('Use topTrackEntryDescriptor instead')
const TopTrackEntry$json = {
  '1': 'TopTrackEntry',
  '2': [
    {'1': 'track_id', '3': 1, '4': 1, '5': 9, '10': 'trackId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'artist', '3': 3, '4': 1, '5': 9, '10': 'artist'},
    {'1': 'image_small', '3': 4, '4': 1, '5': 9, '10': 'imageSmall'},
    {'1': 'play_count', '3': 5, '4': 1, '5': 5, '10': 'playCount'},
  ],
};

/// Descriptor for `TopTrackEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List topTrackEntryDescriptor = $convert.base64Decode(
    'Cg1Ub3BUcmFja0VudHJ5EhkKCHRyYWNrX2lkGAEgASgJUgd0cmFja0lkEhQKBXRpdGxlGAIgAS'
    'gJUgV0aXRsZRIWCgZhcnRpc3QYAyABKAlSBmFydGlzdBIfCgtpbWFnZV9zbWFsbBgEIAEoCVIK'
    'aW1hZ2VTbWFsbBIdCgpwbGF5X2NvdW50GAUgASgFUglwbGF5Q291bnQ=');

@$core.Deprecated('Use getUserTopTracksRequestDescriptor instead')
const GetUserTopTracksRequest$json = {
  '1': 'GetUserTopTracksRequest',
  '2': [
    {'1': 'target_user_id', '3': 1, '4': 1, '5': 9, '10': 'targetUserId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {
      '1': 'time_range',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.tracks.TimeRange',
      '10': 'timeRange'
    },
  ],
};

/// Descriptor for `GetUserTopTracksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTopTracksRequestDescriptor = $convert.base64Decode(
    'ChdHZXRVc2VyVG9wVHJhY2tzUmVxdWVzdBIkCg50YXJnZXRfdXNlcl9pZBgBIAEoCVIMdGFyZ2'
    'V0VXNlcklkEhQKBWxpbWl0GAIgASgFUgVsaW1pdBIwCgp0aW1lX3JhbmdlGAMgASgOMhEudHJh'
    'Y2tzLlRpbWVSYW5nZVIJdGltZVJhbmdl');

@$core.Deprecated('Use getUserTopTracksResponseDescriptor instead')
const GetUserTopTracksResponse$json = {
  '1': 'GetUserTopTracksResponse',
  '2': [
    {
      '1': 'tracks',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.tracks.TopTrackEntry',
      '10': 'tracks'
    },
  ],
};

/// Descriptor for `GetUserTopTracksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserTopTracksResponseDescriptor =
    $convert.base64Decode(
        'ChhHZXRVc2VyVG9wVHJhY2tzUmVzcG9uc2USLQoGdHJhY2tzGAEgAygLMhUudHJhY2tzLlRvcF'
        'RyYWNrRW50cnlSBnRyYWNrcw==');
