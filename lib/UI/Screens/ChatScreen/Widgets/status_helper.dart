import 'package:flutter/material.dart';
import 'package:bluppi/Data/Models/message_model.dart';
import 'package:bluppi/Data/Services/socket_service.dart';

class Status {
  static Color getColor(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.connecting:
      case ConnectionStatus.reconnecting:
        return Colors.orange;
      case ConnectionStatus.error:
      case ConnectionStatus.disconnected:
        return Colors.red;
    }
  }

  static String getText(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return 'Online';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.reconnecting:
        return 'Reconnecting...';
      case ConnectionStatus.error:
        return 'Connection error';
      case ConnectionStatus.disconnected:
        return 'Offline';
    }
  }

  static IconData getIcon(MessageStatus status) {
    switch (status) {
      case MessageStatus.pending:
        return Icons.access_time;
      case MessageStatus.sent:
        return Icons.check;
      case MessageStatus.delivered:
        return Icons.done_all;
      case MessageStatus.seen:
        return Icons.done_all;
      case MessageStatus.failed:
        return Icons.error_outline;
    }
  }
}
