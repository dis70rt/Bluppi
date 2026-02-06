// This is a generated file - do not edit.
//
// Generated from users.proto.

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

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
    {'1': 'username', '3': 3, '4': 1, '5': 9, '10': 'username'},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '10': 'name'},
    {'1': 'bio', '3': 5, '4': 1, '5': 9, '10': 'bio'},
    {'1': 'country', '3': 6, '4': 1, '5': 9, '10': 'country'},
    {'1': 'phone', '3': 7, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'profile_pic', '3': 8, '4': 1, '5': 9, '10': 'profilePic'},
    {'1': 'favorite_genres', '3': 9, '4': 3, '5': 9, '10': 'favoriteGenres'},
    {'1': 'follower_count', '3': 10, '4': 1, '5': 5, '10': 'followerCount'},
    {'1': 'following_count', '3': 11, '4': 1, '5': 5, '10': 'followingCount'},
    {
      '1': 'created_at',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'date_of_birth',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'dateOfBirth'
    },
    {'1': 'gender', '3': 14, '4': 1, '5': 9, '10': 'gender'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBIUCgVlbWFpbBgCIAEoCVIFZW1haWwSGgoIdXNlcm5hbW'
    'UYAyABKAlSCHVzZXJuYW1lEhIKBG5hbWUYBCABKAlSBG5hbWUSEAoDYmlvGAUgASgJUgNiaW8S'
    'GAoHY291bnRyeRgGIAEoCVIHY291bnRyeRIUCgVwaG9uZRgHIAEoCVIFcGhvbmUSHwoLcHJvZm'
    'lsZV9waWMYCCABKAlSCnByb2ZpbGVQaWMSJwoPZmF2b3JpdGVfZ2VucmVzGAkgAygJUg5mYXZv'
    'cml0ZUdlbnJlcxIlCg5mb2xsb3dlcl9jb3VudBgKIAEoBVINZm9sbG93ZXJDb3VudBInCg9mb2'
    'xsb3dpbmdfY291bnQYCyABKAVSDmZvbGxvd2luZ0NvdW50EjkKCmNyZWF0ZWRfYXQYDCABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSPgoNZGF0ZV9vZl9iaXJ0aB'
    'gNIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSC2RhdGVPZkJpcnRoEhYKBmdlbmRl'
    'chgOIAEoCVIGZ2VuZGVy');

@$core.Deprecated('Use createUserRequestDescriptor instead')
const CreateUserRequest$json = {
  '1': 'CreateUserRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'bio', '3': 4, '4': 1, '5': 9, '10': 'bio'},
    {'1': 'country', '3': 5, '4': 1, '5': 9, '10': 'country'},
    {'1': 'phone', '3': 6, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'profile_pic', '3': 7, '4': 1, '5': 9, '10': 'profilePic'},
    {'1': 'favorite_genres', '3': 8, '4': 3, '5': 9, '10': 'favoriteGenres'},
    {'1': 'id', '3': 9, '4': 1, '5': 9, '10': 'id'},
    {
      '1': 'date_of_birth',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'dateOfBirth'
    },
    {'1': 'gender', '3': 11, '4': 1, '5': 9, '10': 'gender'},
  ],
};

/// Descriptor for `CreateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUserRequestDescriptor = $convert.base64Decode(
    'ChFDcmVhdGVVc2VyUmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWwSGgoIdXNlcm5hbWUYAi'
    'ABKAlSCHVzZXJuYW1lEhIKBG5hbWUYAyABKAlSBG5hbWUSEAoDYmlvGAQgASgJUgNiaW8SGAoH'
    'Y291bnRyeRgFIAEoCVIHY291bnRyeRIUCgVwaG9uZRgGIAEoCVIFcGhvbmUSHwoLcHJvZmlsZV'
    '9waWMYByABKAlSCnByb2ZpbGVQaWMSJwoPZmF2b3JpdGVfZ2VucmVzGAggAygJUg5mYXZvcml0'
    'ZUdlbnJlcxIOCgJpZBgJIAEoCVICaWQSPgoNZGF0ZV9vZl9iaXJ0aBgKIAEoCzIaLmdvb2dsZS'
    '5wcm90b2J1Zi5UaW1lc3RhbXBSC2RhdGVPZkJpcnRoEhYKBmdlbmRlchgLIAEoCVIGZ2VuZGVy');

@$core.Deprecated('Use userResponseDescriptor instead')
const UserResponse$json = {
  '1': 'UserResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.users.User', '10': 'user'},
  ],
};

/// Descriptor for `UserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userResponseDescriptor = $convert.base64Decode(
    'CgxVc2VyUmVzcG9uc2USHwoEdXNlchgBIAEoCzILLnVzZXJzLlVzZXJSBHVzZXI=');

@$core.Deprecated('Use getUserByIdRequestDescriptor instead')
const GetUserByIdRequest$json = {
  '1': 'GetUserByIdRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserByIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserByIdRequestDescriptor =
    $convert.base64Decode(
        'ChJHZXRVc2VyQnlJZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use getUserByUsernameRequestDescriptor instead')
const GetUserByUsernameRequest$json = {
  '1': 'GetUserByUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `GetUserByUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserByUsernameRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRVc2VyQnlVc2VybmFtZVJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1l');

@$core.Deprecated('Use updateUserRequestDescriptor instead')
const UpdateUserRequest$json = {
  '1': 'UpdateUserRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'email', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'email', '17': true},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'name', '17': true},
    {'1': 'bio', '3': 4, '4': 1, '5': 9, '9': 2, '10': 'bio', '17': true},
    {
      '1': 'country',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'country',
      '17': true
    },
    {'1': 'phone', '3': 6, '4': 1, '5': 9, '9': 4, '10': 'phone', '17': true},
    {
      '1': 'profile_pic',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'profilePic',
      '17': true
    },
    {'1': 'favorite_genres', '3': 8, '4': 3, '5': 9, '10': 'favoriteGenres'},
    {
      '1': 'date_of_birth',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 6,
      '10': 'dateOfBirth',
      '17': true
    },
    {
      '1': 'gender',
      '3': 10,
      '4': 1,
      '5': 9,
      '9': 7,
      '10': 'gender',
      '17': true
    },
  ],
  '8': [
    {'1': '_email'},
    {'1': '_name'},
    {'1': '_bio'},
    {'1': '_country'},
    {'1': '_phone'},
    {'1': '_profile_pic'},
    {'1': '_date_of_birth'},
    {'1': '_gender'},
  ],
};

/// Descriptor for `UpdateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserRequestDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVVc2VyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSGQoFZW1haWwYAi'
    'ABKAlIAFIFZW1haWyIAQESFwoEbmFtZRgDIAEoCUgBUgRuYW1liAEBEhUKA2JpbxgEIAEoCUgC'
    'UgNiaW+IAQESHQoHY291bnRyeRgFIAEoCUgDUgdjb3VudHJ5iAEBEhkKBXBob25lGAYgASgJSA'
    'RSBXBob25liAEBEiQKC3Byb2ZpbGVfcGljGAcgASgJSAVSCnByb2ZpbGVQaWOIAQESJwoPZmF2'
    'b3JpdGVfZ2VucmVzGAggAygJUg5mYXZvcml0ZUdlbnJlcxJDCg1kYXRlX29mX2JpcnRoGAkgAS'
    'gLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcEgGUgtkYXRlT2ZCaXJ0aIgBARIbCgZnZW5k'
    'ZXIYCiABKAlIB1IGZ2VuZGVyiAEBQggKBl9lbWFpbEIHCgVfbmFtZUIGCgRfYmlvQgoKCF9jb3'
    'VudHJ5QggKBl9waG9uZUIOCgxfcHJvZmlsZV9waWNCEAoOX2RhdGVfb2ZfYmlydGhCCQoHX2dl'
    'bmRlcg==');

@$core.Deprecated('Use deleteUserRequestDescriptor instead')
const DeleteUserRequest$json = {
  '1': 'DeleteUserRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `DeleteUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteUserRequestDescriptor = $convert.base64Decode(
    'ChFEZWxldGVVc2VyUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use deleteUserResponseDescriptor instead')
const DeleteUserResponse$json = {
  '1': 'DeleteUserResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `DeleteUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteUserResponseDescriptor =
    $convert.base64Decode(
        'ChJEZWxldGVVc2VyUmVzcG9uc2USGAoHbWVzc2FnZRgBIAEoCVIHbWVzc2FnZQ==');

@$core.Deprecated('Use searchUsersRequestDescriptor instead')
const SearchUsersRequest$json = {
  '1': 'SearchUsersRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `SearchUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersRequestDescriptor = $convert.base64Decode(
    'ChJTZWFyY2hVc2Vyc1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBWxpbWl0GAIgAS'
    'gFUgVsaW1pdBIWCgZvZmZzZXQYAyABKAVSBm9mZnNldA==');

@$core.Deprecated('Use searchUsersResponseDescriptor instead')
const SearchUsersResponse$json = {
  '1': 'SearchUsersResponse',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.users.User', '10': 'users'},
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `SearchUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersResponseDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hVc2Vyc1Jlc3BvbnNlEiEKBXVzZXJzGAEgAygLMgsudXNlcnMuVXNlclIFdXNlcn'
    'MSFAoFdG90YWwYAiABKANSBXRvdGFs');

@$core.Deprecated('Use checkUsernameRequestDescriptor instead')
const CheckUsernameRequest$json = {
  '1': 'CheckUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `CheckUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUsernameRequestDescriptor =
    $convert.base64Decode(
        'ChRDaGVja1VzZXJuYW1lUmVxdWVzdBIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWU=');

@$core.Deprecated('Use checkEmailRequestDescriptor instead')
const CheckEmailRequest$json = {
  '1': 'CheckEmailRequest',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `CheckEmailRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkEmailRequestDescriptor = $convert
    .base64Decode('ChFDaGVja0VtYWlsUmVxdWVzdBIUCgVlbWFpbBgBIAEoCVIFZW1haWw=');

@$core.Deprecated('Use checkUserRequestDescriptor instead')
const CheckUserRequest$json = {
  '1': 'CheckUserRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `CheckUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUserRequestDescriptor =
    $convert.base64Decode('ChBDaGVja1VzZXJSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use checkExistenceResponseDescriptor instead')
const CheckExistenceResponse$json = {
  '1': 'CheckExistenceResponse',
  '2': [
    {'1': 'exists', '3': 1, '4': 1, '5': 8, '10': 'exists'},
  ],
};

/// Descriptor for `CheckExistenceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkExistenceResponseDescriptor =
    $convert.base64Decode(
        'ChZDaGVja0V4aXN0ZW5jZVJlc3BvbnNlEhYKBmV4aXN0cxgBIAEoCFIGZXhpc3Rz');

@$core.Deprecated('Use statusResponseDescriptor instead')
const StatusResponse$json = {
  '1': 'StatusResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `StatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List statusResponseDescriptor = $convert.base64Decode(
    'Cg5TdGF0dXNSZXNwb25zZRIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEhgKB3N1Y2Nlc3MYAi'
    'ABKAhSB3N1Y2Nlc3M=');

@$core.Deprecated('Use getUserStatsRequestDescriptor instead')
const GetUserStatsRequest$json = {
  '1': 'GetUserStatsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserStatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserStatsRequestDescriptor =
    $convert.base64Decode(
        'ChNHZXRVc2VyU3RhdHNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use userStatsResponseDescriptor instead')
const UserStatsResponse$json = {
  '1': 'UserStatsResponse',
  '2': [
    {'1': 'follower_count', '3': 1, '4': 1, '5': 5, '10': 'followerCount'},
    {'1': 'following_count', '3': 2, '4': 1, '5': 5, '10': 'followingCount'},
  ],
};

/// Descriptor for `UserStatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userStatsResponseDescriptor = $convert.base64Decode(
    'ChFVc2VyU3RhdHNSZXNwb25zZRIlCg5mb2xsb3dlcl9jb3VudBgBIAEoBVINZm9sbG93ZXJDb3'
    'VudBInCg9mb2xsb3dpbmdfY291bnQYAiABKAVSDmZvbGxvd2luZ0NvdW50');

@$core.Deprecated('Use addRecentSearchRequestDescriptor instead')
const AddRecentSearchRequest$json = {
  '1': 'AddRecentSearchRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `AddRecentSearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addRecentSearchRequestDescriptor =
    $convert.base64Decode(
        'ChZBZGRSZWNlbnRTZWFyY2hSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVxdW'
        'VyeRgCIAEoCVIFcXVlcnk=');

@$core.Deprecated('Use getRecentSearchesRequestDescriptor instead')
const GetRecentSearchesRequest$json = {
  '1': 'GetRecentSearchesRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetRecentSearchesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecentSearchesRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRSZWNlbnRTZWFyY2hlc1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhQKBW'
        'xpbWl0GAIgASgFUgVsaW1pdA==');

@$core.Deprecated('Use recentSearchEntryDescriptor instead')
const RecentSearchEntry$json = {
  '1': 'RecentSearchEntry',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {
      '1': 'searched_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'searchedAt'
    },
  ],
};

/// Descriptor for `RecentSearchEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recentSearchEntryDescriptor = $convert.base64Decode(
    'ChFSZWNlbnRTZWFyY2hFbnRyeRIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSOwoLc2VhcmNoZWRfYX'
    'QYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpzZWFyY2hlZEF0');

@$core.Deprecated('Use recentSearchesResponseDescriptor instead')
const RecentSearchesResponse$json = {
  '1': 'RecentSearchesResponse',
  '2': [
    {
      '1': 'searches',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.users.RecentSearchEntry',
      '10': 'searches'
    },
  ],
};

/// Descriptor for `RecentSearchesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List recentSearchesResponseDescriptor =
    $convert.base64Decode(
        'ChZSZWNlbnRTZWFyY2hlc1Jlc3BvbnNlEjQKCHNlYXJjaGVzGAEgAygLMhgudXNlcnMuUmVjZW'
        '50U2VhcmNoRW50cnlSCHNlYXJjaGVz');

@$core.Deprecated('Use followUserRequestDescriptor instead')
const FollowUserRequest$json = {
  '1': 'FollowUserRequest',
  '2': [
    {'1': 'follower_id', '3': 1, '4': 1, '5': 9, '10': 'followerId'},
    {'1': 'followee_id', '3': 2, '4': 1, '5': 9, '10': 'followeeId'},
  ],
};

/// Descriptor for `FollowUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List followUserRequestDescriptor = $convert.base64Decode(
    'ChFGb2xsb3dVc2VyUmVxdWVzdBIfCgtmb2xsb3dlcl9pZBgBIAEoCVIKZm9sbG93ZXJJZBIfCg'
    'tmb2xsb3dlZV9pZBgCIAEoCVIKZm9sbG93ZWVJZA==');

@$core.Deprecated('Use unfollowUserRequestDescriptor instead')
const UnfollowUserRequest$json = {
  '1': 'UnfollowUserRequest',
  '2': [
    {'1': 'follower_id', '3': 1, '4': 1, '5': 9, '10': 'followerId'},
    {'1': 'followee_id', '3': 2, '4': 1, '5': 9, '10': 'followeeId'},
  ],
};

/// Descriptor for `UnfollowUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unfollowUserRequestDescriptor = $convert.base64Decode(
    'ChNVbmZvbGxvd1VzZXJSZXF1ZXN0Eh8KC2ZvbGxvd2VyX2lkGAEgASgJUgpmb2xsb3dlcklkEh'
    '8KC2ZvbGxvd2VlX2lkGAIgASgJUgpmb2xsb3dlZUlk');

@$core.Deprecated('Use isFollowingRequestDescriptor instead')
const IsFollowingRequest$json = {
  '1': 'IsFollowingRequest',
  '2': [
    {'1': 'follower_id', '3': 1, '4': 1, '5': 9, '10': 'followerId'},
    {'1': 'followee_id', '3': 2, '4': 1, '5': 9, '10': 'followeeId'},
  ],
};

/// Descriptor for `IsFollowingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isFollowingRequestDescriptor = $convert.base64Decode(
    'ChJJc0ZvbGxvd2luZ1JlcXVlc3QSHwoLZm9sbG93ZXJfaWQYASABKAlSCmZvbGxvd2VySWQSHw'
    'oLZm9sbG93ZWVfaWQYAiABKAlSCmZvbGxvd2VlSWQ=');

@$core.Deprecated('Use isFollowingResponseDescriptor instead')
const IsFollowingResponse$json = {
  '1': 'IsFollowingResponse',
  '2': [
    {'1': 'is_following', '3': 1, '4': 1, '5': 8, '10': 'isFollowing'},
  ],
};

/// Descriptor for `IsFollowingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List isFollowingResponseDescriptor = $convert.base64Decode(
    'ChNJc0ZvbGxvd2luZ1Jlc3BvbnNlEiEKDGlzX2ZvbGxvd2luZxgBIAEoCFILaXNGb2xsb3dpbm'
    'c=');

@$core.Deprecated('Use getFollowersRequestDescriptor instead')
const GetFollowersRequest$json = {
  '1': 'GetFollowersRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetFollowersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFollowersRequestDescriptor = $convert.base64Decode(
    'ChNHZXRGb2xsb3dlcnNSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVsaW1pdB'
    'gCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use getFollowingRequestDescriptor instead')
const GetFollowingRequest$json = {
  '1': 'GetFollowingRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetFollowingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFollowingRequestDescriptor = $convert.base64Decode(
    'ChNHZXRGb2xsb3dpbmdSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIUCgVsaW1pdB'
    'gCIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAMgASgFUgZvZmZzZXQ=');

@$core.Deprecated('Use followUserEntryDescriptor instead')
const FollowUserEntry$json = {
  '1': 'FollowUserEntry',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'profile_pic', '3': 4, '4': 1, '5': 9, '10': 'profilePic'},
    {
      '1': 'followed_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'followedAt'
    },
  ],
};

/// Descriptor for `FollowUserEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List followUserEntryDescriptor = $convert.base64Decode(
    'Cg9Gb2xsb3dVc2VyRW50cnkSDgoCaWQYASABKAlSAmlkEhoKCHVzZXJuYW1lGAIgASgJUgh1c2'
    'VybmFtZRISCgRuYW1lGAMgASgJUgRuYW1lEh8KC3Byb2ZpbGVfcGljGAQgASgJUgpwcm9maWxl'
    'UGljEjsKC2ZvbGxvd2VkX2F0GAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIKZm'
    '9sbG93ZWRBdA==');

@$core.Deprecated('Use getFollowersResponseDescriptor instead')
const GetFollowersResponse$json = {
  '1': 'GetFollowersResponse',
  '2': [
    {
      '1': 'followers',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.users.FollowUserEntry',
      '10': 'followers'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetFollowersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFollowersResponseDescriptor = $convert.base64Decode(
    'ChRHZXRGb2xsb3dlcnNSZXNwb25zZRI0Cglmb2xsb3dlcnMYASADKAsyFi51c2Vycy5Gb2xsb3'
    'dVc2VyRW50cnlSCWZvbGxvd2VycxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');

@$core.Deprecated('Use getFollowingResponseDescriptor instead')
const GetFollowingResponse$json = {
  '1': 'GetFollowingResponse',
  '2': [
    {
      '1': 'following',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.users.FollowUserEntry',
      '10': 'following'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 3, '10': 'total'},
  ],
};

/// Descriptor for `GetFollowingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFollowingResponseDescriptor = $convert.base64Decode(
    'ChRHZXRGb2xsb3dpbmdSZXNwb25zZRI0Cglmb2xsb3dpbmcYASADKAsyFi51c2Vycy5Gb2xsb3'
    'dVc2VyRW50cnlSCWZvbGxvd2luZxIUCgV0b3RhbBgCIAEoA1IFdG90YWw=');
