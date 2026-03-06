import 'dart:convert';
import 'package:bluppi/generated/notifications.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String body;
  final dynamic actionData;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.actionData,
    required this.isRead,
    required this.createdAt,
  });

  /// Converts a gRPC protobuf `InAppNotification` message to a `NotificationModel`.
  factory NotificationModel.fromProto(proto.InAppNotification pNotification) {
    return NotificationModel(
      id: pNotification.id,
      type: pNotification.type,
      title: pNotification.title,
      body: pNotification.body,
      actionData: pNotification.actionData.isNotEmpty
          ? jsonDecode(pNotification.actionData)
          : null,
      isRead: pNotification.isRead,
      createdAt: pNotification.createdAt.toDateTime(),
    );
  }

  /// Converts a `NotificationModel` to a gRPC protobuf `InAppNotification` message.
  proto.InAppNotification toProto() {
    return proto.InAppNotification(
      id: id,
      type: type,
      title: title,
      body: body,
      actionData: actionData != null ? jsonEncode(actionData) : '',
      isRead: isRead,
      createdAt: Timestamp.fromDateTime(createdAt),
    );
  }

  /// Creates a `NotificationModel` from a JSON map.
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      body: json['body'],
      actionData: json['actionData'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  /// Converts a `NotificationModel` to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'body': body,
      'actionData': actionData,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}