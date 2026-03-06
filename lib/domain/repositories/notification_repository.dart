import 'package:bluppi/domain/models/notification_model.dart';

abstract class NotificationRepository {
  Future<void> registerDevice(String fcmToken);
  Future<void> unregisterDevice(String fcmToken);

  // Future<> getPreferences();
  // Future<void> updatePreferences();

  Future<List<NotificationModel>> getNotificationHistory({int limit = 20, int offset = 0});
  Future<void> markAsRead(List<String> notificationIds);
  Future<void> deleteNotification(String notificationId);
  Future<void> clearNotifications();

  Future<int> getUnreadCount();
}