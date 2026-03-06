// This is a generated file - do not edit.
//
// Generated from notifications.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;

import 'notifications.pb.dart' as $0;

export 'notifications.pb.dart';

@$pb.GrpcServiceName('notifications.NotificationService')
class NotificationServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  NotificationServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.Empty> registerDevice(
    $0.RegisterDeviceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerDevice, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> unregisterDevice(
    $0.UnregisterDeviceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unregisterDevice, request, options: options);
  }

  $grpc.ResponseFuture<$0.NotificationPreferences> getPreferences(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPreferences, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> updatePreferences(
    $0.UpdatePreferencesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updatePreferences, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetHistoryResponse> getHistory(
    $0.GetHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> markAsRead(
    $0.MarkAsReadRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$markAsRead, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteNotification(
    $0.DeleteNotificationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteNotification, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> clearHistory(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$clearHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUnreadCountResponse> getUnreadCount(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUnreadCount, request, options: options);
  }

  // method descriptors

  static final _$registerDevice =
      $grpc.ClientMethod<$0.RegisterDeviceRequest, $1.Empty>(
          '/notifications.NotificationService/RegisterDevice',
          ($0.RegisterDeviceRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$unregisterDevice =
      $grpc.ClientMethod<$0.UnregisterDeviceRequest, $1.Empty>(
          '/notifications.NotificationService/UnregisterDevice',
          ($0.UnregisterDeviceRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$getPreferences =
      $grpc.ClientMethod<$1.Empty, $0.NotificationPreferences>(
          '/notifications.NotificationService/GetPreferences',
          ($1.Empty value) => value.writeToBuffer(),
          $0.NotificationPreferences.fromBuffer);
  static final _$updatePreferences =
      $grpc.ClientMethod<$0.UpdatePreferencesRequest, $1.Empty>(
          '/notifications.NotificationService/UpdatePreferences',
          ($0.UpdatePreferencesRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$getHistory =
      $grpc.ClientMethod<$0.GetHistoryRequest, $0.GetHistoryResponse>(
          '/notifications.NotificationService/GetHistory',
          ($0.GetHistoryRequest value) => value.writeToBuffer(),
          $0.GetHistoryResponse.fromBuffer);
  static final _$markAsRead =
      $grpc.ClientMethod<$0.MarkAsReadRequest, $1.Empty>(
          '/notifications.NotificationService/MarkAsRead',
          ($0.MarkAsReadRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$deleteNotification =
      $grpc.ClientMethod<$0.DeleteNotificationRequest, $1.Empty>(
          '/notifications.NotificationService/DeleteNotification',
          ($0.DeleteNotificationRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$clearHistory = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/notifications.NotificationService/ClearHistory',
      ($1.Empty value) => value.writeToBuffer(),
      $1.Empty.fromBuffer);
  static final _$getUnreadCount =
      $grpc.ClientMethod<$1.Empty, $0.GetUnreadCountResponse>(
          '/notifications.NotificationService/GetUnreadCount',
          ($1.Empty value) => value.writeToBuffer(),
          $0.GetUnreadCountResponse.fromBuffer);
}

@$pb.GrpcServiceName('notifications.NotificationService')
abstract class NotificationServiceBase extends $grpc.Service {
  $core.String get $name => 'notifications.NotificationService';

  NotificationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterDeviceRequest, $1.Empty>(
        'RegisterDevice',
        registerDevice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegisterDeviceRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnregisterDeviceRequest, $1.Empty>(
        'UnregisterDevice',
        unregisterDevice_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnregisterDeviceRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.NotificationPreferences>(
        'GetPreferences',
        getPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.NotificationPreferences value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePreferencesRequest, $1.Empty>(
        'UpdatePreferences',
        updatePreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdatePreferencesRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetHistoryRequest, $0.GetHistoryResponse>(
        'GetHistory',
        getHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetHistoryRequest.fromBuffer(value),
        ($0.GetHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkAsReadRequest, $1.Empty>(
        'MarkAsRead',
        markAsRead_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MarkAsReadRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteNotificationRequest, $1.Empty>(
        'DeleteNotification',
        deleteNotification_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteNotificationRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'ClearHistory',
        clearHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.GetUnreadCountResponse>(
        'GetUnreadCount',
        getUnreadCount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.GetUnreadCountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> registerDevice_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RegisterDeviceRequest> $request) async {
    return registerDevice($call, await $request);
  }

  $async.Future<$1.Empty> registerDevice(
      $grpc.ServiceCall call, $0.RegisterDeviceRequest request);

  $async.Future<$1.Empty> unregisterDevice_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UnregisterDeviceRequest> $request) async {
    return unregisterDevice($call, await $request);
  }

  $async.Future<$1.Empty> unregisterDevice(
      $grpc.ServiceCall call, $0.UnregisterDeviceRequest request);

  $async.Future<$0.NotificationPreferences> getPreferences_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return getPreferences($call, await $request);
  }

  $async.Future<$0.NotificationPreferences> getPreferences(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$1.Empty> updatePreferences_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdatePreferencesRequest> $request) async {
    return updatePreferences($call, await $request);
  }

  $async.Future<$1.Empty> updatePreferences(
      $grpc.ServiceCall call, $0.UpdatePreferencesRequest request);

  $async.Future<$0.GetHistoryResponse> getHistory_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetHistoryRequest> $request) async {
    return getHistory($call, await $request);
  }

  $async.Future<$0.GetHistoryResponse> getHistory(
      $grpc.ServiceCall call, $0.GetHistoryRequest request);

  $async.Future<$1.Empty> markAsRead_Pre($grpc.ServiceCall $call,
      $async.Future<$0.MarkAsReadRequest> $request) async {
    return markAsRead($call, await $request);
  }

  $async.Future<$1.Empty> markAsRead(
      $grpc.ServiceCall call, $0.MarkAsReadRequest request);

  $async.Future<$1.Empty> deleteNotification_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteNotificationRequest> $request) async {
    return deleteNotification($call, await $request);
  }

  $async.Future<$1.Empty> deleteNotification(
      $grpc.ServiceCall call, $0.DeleteNotificationRequest request);

  $async.Future<$1.Empty> clearHistory_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return clearHistory($call, await $request);
  }

  $async.Future<$1.Empty> clearHistory(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.GetUnreadCountResponse> getUnreadCount_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return getUnreadCount($call, await $request);
  }

  $async.Future<$0.GetUnreadCountResponse> getUnreadCount(
      $grpc.ServiceCall call, $1.Empty request);
}
