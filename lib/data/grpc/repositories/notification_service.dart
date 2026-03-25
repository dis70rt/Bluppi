
import 'dart:io';

import 'package:bluppi/data/auth/auth_interceptor.dart';
import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/notification_model.dart';
import 'package:bluppi/domain/repositories/notification_repository.dart';
import 'package:bluppi/generated/notifications.pbgrpc.dart' as proto;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

final notificationServiceProvider = Provider<NotificationServiceRepository>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  final client = proto.NotificationServiceClient(channel, interceptors: [AuthInterceptor()]);
  return NotificationServiceRepository(client);
});

class NotificationServiceRepository implements NotificationRepository {
  final proto.NotificationServiceClient _client;

  NotificationServiceRepository(this._client);

  @override
  Future<void> registerDevice(String fcmToken) async {
    proto.DeviceType protoDeviceType;
    switch (Platform.operatingSystem) {
      case 'android':
        protoDeviceType = proto.DeviceType.DEVICE_TYPE_ANDROID;
        break;
      case 'ios':
        protoDeviceType = proto.DeviceType.DEVICE_TYPE_IOS;
        break;
      default:
        throw ArgumentError('Unsupported device type: ${Platform.operatingSystem}');
    }
    final request = proto.RegisterDeviceRequest(fcmToken: fcmToken, deviceType: protoDeviceType);
    await _client.registerDevice(request);
    // log('FCM token registered with backend: $fcmToken');
  }

  @override
  Future<void> unregisterDevice(String fcmToken) async {
    final request = proto.UnregisterDeviceRequest(fcmToken: fcmToken);
    await _client.unregisterDevice(request);
  }

  @override
  Future<List<NotificationModel>> getNotificationHistory({int limit = 20, int offset = 0}) async {
    final request = proto.GetHistoryRequest(limit: limit, offset: offset);
    final response = await _client.getHistory(request);
    // I have total unread counts also.
    return response.notifications.map((p) => NotificationModel.fromProto(p)).toList();
  }

  @override
  Future<void> markAsRead(List<String> notificationIds) async {
    final request = proto.MarkAsReadRequest(notificationIds: notificationIds);
    await _client.markAsRead(request);
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final request = proto.DeleteNotificationRequest(notificationId: notificationId);
    await _client.deleteNotification(request);
  }

  @override
  Future<void> clearNotifications() async {
    await _client.clearHistory(Empty());
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await _client.getUnreadCount(Empty());
    return response.count;
  }
}