// This is a generated file - do not edit.
//
// Generated from notifications.proto.

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

@$core.Deprecated('Use deviceTypeDescriptor instead')
const DeviceType$json = {
  '1': 'DeviceType',
  '2': [
    {'1': 'DEVICE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'DEVICE_TYPE_ANDROID', '2': 1},
    {'1': 'DEVICE_TYPE_IOS', '2': 2},
  ],
};

/// Descriptor for `DeviceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List deviceTypeDescriptor = $convert.base64Decode(
    'CgpEZXZpY2VUeXBlEhsKF0RFVklDRV9UWVBFX1VOU1BFQ0lGSUVEEAASFwoTREVWSUNFX1RZUE'
    'VfQU5EUk9JRBABEhMKD0RFVklDRV9UWVBFX0lPUxAC');

@$core.Deprecated('Use registerDeviceRequestDescriptor instead')
const RegisterDeviceRequest$json = {
  '1': 'RegisterDeviceRequest',
  '2': [
    {'1': 'fcm_token', '3': 1, '4': 1, '5': 9, '10': 'fcmToken'},
    {
      '1': 'device_type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.notifications.DeviceType',
      '10': 'deviceType'
    },
  ],
};

/// Descriptor for `RegisterDeviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerDeviceRequestDescriptor = $convert.base64Decode(
    'ChVSZWdpc3RlckRldmljZVJlcXVlc3QSGwoJZmNtX3Rva2VuGAEgASgJUghmY21Ub2tlbhI6Cg'
    'tkZXZpY2VfdHlwZRgCIAEoDjIZLm5vdGlmaWNhdGlvbnMuRGV2aWNlVHlwZVIKZGV2aWNlVHlw'
    'ZQ==');

@$core.Deprecated('Use unregisterDeviceRequestDescriptor instead')
const UnregisterDeviceRequest$json = {
  '1': 'UnregisterDeviceRequest',
  '2': [
    {'1': 'fcm_token', '3': 1, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

/// Descriptor for `UnregisterDeviceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unregisterDeviceRequestDescriptor =
    $convert.base64Decode(
        'ChdVbnJlZ2lzdGVyRGV2aWNlUmVxdWVzdBIbCglmY21fdG9rZW4YASABKAlSCGZjbVRva2Vu');

@$core.Deprecated('Use notificationPreferencesDescriptor instead')
const NotificationPreferences$json = {
  '1': 'NotificationPreferences',
  '2': [
    {
      '1': 'push_notifications_enabled',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'pushNotificationsEnabled'
    },
    {
      '1': 'email_notifications_enabled',
      '3': 2,
      '4': 1,
      '5': 8,
      '10': 'emailNotificationsEnabled'
    },
    {
      '1': 'party_invites_enabled',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'partyInvitesEnabled'
    },
    {
      '1': 'new_followers_enabled',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'newFollowersEnabled'
    },
    {
      '1': 'follow_request_enabled',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'followRequestEnabled'
    },
    {
      '1': 'follower_listening_enabled',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'followerListeningEnabled'
    },
  ],
};

/// Descriptor for `NotificationPreferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationPreferencesDescriptor = $convert.base64Decode(
    'ChdOb3RpZmljYXRpb25QcmVmZXJlbmNlcxI8ChpwdXNoX25vdGlmaWNhdGlvbnNfZW5hYmxlZB'
    'gBIAEoCFIYcHVzaE5vdGlmaWNhdGlvbnNFbmFibGVkEj4KG2VtYWlsX25vdGlmaWNhdGlvbnNf'
    'ZW5hYmxlZBgCIAEoCFIZZW1haWxOb3RpZmljYXRpb25zRW5hYmxlZBIyChVwYXJ0eV9pbnZpdG'
    'VzX2VuYWJsZWQYAyABKAhSE3BhcnR5SW52aXRlc0VuYWJsZWQSMgoVbmV3X2ZvbGxvd2Vyc19l'
    'bmFibGVkGAQgASgIUhNuZXdGb2xsb3dlcnNFbmFibGVkEjQKFmZvbGxvd19yZXF1ZXN0X2VuYW'
    'JsZWQYBSABKAhSFGZvbGxvd1JlcXVlc3RFbmFibGVkEjwKGmZvbGxvd2VyX2xpc3RlbmluZ19l'
    'bmFibGVkGAYgASgIUhhmb2xsb3dlckxpc3RlbmluZ0VuYWJsZWQ=');

@$core.Deprecated('Use updatePreferencesRequestDescriptor instead')
const UpdatePreferencesRequest$json = {
  '1': 'UpdatePreferencesRequest',
  '2': [
    {
      '1': 'preferences',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.notifications.NotificationPreferences',
      '10': 'preferences'
    },
  ],
};

/// Descriptor for `UpdatePreferencesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePreferencesRequestDescriptor =
    $convert.base64Decode(
        'ChhVcGRhdGVQcmVmZXJlbmNlc1JlcXVlc3QSSAoLcHJlZmVyZW5jZXMYASABKAsyJi5ub3RpZm'
        'ljYXRpb25zLk5vdGlmaWNhdGlvblByZWZlcmVuY2VzUgtwcmVmZXJlbmNlcw==');

@$core.Deprecated('Use inAppNotificationDescriptor instead')
const InAppNotification$json = {
  '1': 'InAppNotification',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'type', '3': 2, '4': 1, '5': 9, '10': 'type'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'body', '3': 4, '4': 1, '5': 9, '10': 'body'},
    {'1': 'action_data', '3': 5, '4': 1, '5': 9, '10': 'actionData'},
    {'1': 'is_read', '3': 6, '4': 1, '5': 8, '10': 'isRead'},
    {
      '1': 'created_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `InAppNotification`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inAppNotificationDescriptor = $convert.base64Decode(
    'ChFJbkFwcE5vdGlmaWNhdGlvbhIOCgJpZBgBIAEoCVICaWQSEgoEdHlwZRgCIAEoCVIEdHlwZR'
    'IUCgV0aXRsZRgDIAEoCVIFdGl0bGUSEgoEYm9keRgEIAEoCVIEYm9keRIfCgthY3Rpb25fZGF0'
    'YRgFIAEoCVIKYWN0aW9uRGF0YRIXCgdpc19yZWFkGAYgASgIUgZpc1JlYWQSOQoKY3JlYXRlZF'
    '9hdBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWNyZWF0ZWRBdA==');

@$core.Deprecated('Use getHistoryRequestDescriptor instead')
const GetHistoryRequest$json = {
  '1': 'GetHistoryRequest',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
  ],
};

/// Descriptor for `GetHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoryRequestDescriptor = $convert.base64Decode(
    'ChFHZXRIaXN0b3J5UmVxdWVzdBIUCgVsaW1pdBgBIAEoBVIFbGltaXQSFgoGb2Zmc2V0GAIgAS'
    'gFUgZvZmZzZXQ=');

@$core.Deprecated('Use getHistoryResponseDescriptor instead')
const GetHistoryResponse$json = {
  '1': 'GetHistoryResponse',
  '2': [
    {
      '1': 'notifications',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.notifications.InAppNotification',
      '10': 'notifications'
    },
    {'1': 'total_unread', '3': 2, '4': 1, '5': 5, '10': 'totalUnread'},
  ],
};

/// Descriptor for `GetHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoryResponseDescriptor = $convert.base64Decode(
    'ChJHZXRIaXN0b3J5UmVzcG9uc2USRgoNbm90aWZpY2F0aW9ucxgBIAMoCzIgLm5vdGlmaWNhdG'
    'lvbnMuSW5BcHBOb3RpZmljYXRpb25SDW5vdGlmaWNhdGlvbnMSIQoMdG90YWxfdW5yZWFkGAIg'
    'ASgFUgt0b3RhbFVucmVhZA==');

@$core.Deprecated('Use markAsReadRequestDescriptor instead')
const MarkAsReadRequest$json = {
  '1': 'MarkAsReadRequest',
  '2': [
    {'1': 'notification_ids', '3': 1, '4': 3, '5': 9, '10': 'notificationIds'},
  ],
};

/// Descriptor for `MarkAsReadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List markAsReadRequestDescriptor = $convert.base64Decode(
    'ChFNYXJrQXNSZWFkUmVxdWVzdBIpChBub3RpZmljYXRpb25faWRzGAEgAygJUg9ub3RpZmljYX'
    'Rpb25JZHM=');

@$core.Deprecated('Use getUnreadCountResponseDescriptor instead')
const GetUnreadCountResponse$json = {
  '1': 'GetUnreadCountResponse',
  '2': [
    {'1': 'count', '3': 1, '4': 1, '5': 5, '10': 'count'},
  ],
};

/// Descriptor for `GetUnreadCountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUnreadCountResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRVbnJlYWRDb3VudFJlc3BvbnNlEhQKBWNvdW50GAEgASgFUgVjb3VudA==');

@$core.Deprecated('Use deleteNotificationRequestDescriptor instead')
const DeleteNotificationRequest$json = {
  '1': 'DeleteNotificationRequest',
  '2': [
    {'1': 'notification_id', '3': 1, '4': 1, '5': 9, '10': 'notificationId'},
  ],
};

/// Descriptor for `DeleteNotificationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteNotificationRequestDescriptor =
    $convert.base64Decode(
        'ChlEZWxldGVOb3RpZmljYXRpb25SZXF1ZXN0EicKD25vdGlmaWNhdGlvbl9pZBgBIAEoCVIObm'
        '90aWZpY2F0aW9uSWQ=');
