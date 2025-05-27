import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:synqit/Data/Models/message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as webStatus;

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

class SocketService {
  final String baseUrl;
  WebSocketChannel? _channel;
  String? _userId;
  ConnectionStatus _status = ConnectionStatus.disconnected;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  bool _isDisposing = false;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;

  final StreamController<ChatMessage> _messageController =
      StreamController<ChatMessage>.broadcast();
  final StreamController<ConnectionStatus> _statusController =
      StreamController<ConnectionStatus>.broadcast();
  final StreamController<Map<String, dynamic>> _statusUpdateController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<ChatMessage> get messageStream => _messageController.stream;
  Stream<ConnectionStatus> get connectionStatus => _statusController.stream;
  Stream<Map<String, dynamic>> get statusUpdateStream =>
      _statusUpdateController.stream;
  ConnectionStatus get status => _status;
  bool get isConnected => _status == ConnectionStatus.connected;

  SocketService({required this.baseUrl});

  Future<bool> connect(String userId) async {
    if (_isDisposing) return false;

    if (_status == ConnectionStatus.connected && _userId == userId) {
      log("Already connected as user: $userId");
      return true;
    }

    _userId = userId;
    _updateStatus(ConnectionStatus.connecting);
    log("Connecting to WebSocket as user: $userId");

    try {
      _cleanup();

      final uri = Uri.parse('$baseUrl/ws/v1/$userId');
      log("WebSocket URI: ${uri.toString()}");

      _channel = WebSocketChannel.connect(
        uri,
        protocols: null,
      );

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
        cancelOnError: false,
      );

      _updateStatus(ConnectionStatus.connected);
      _startHeartbeat();
      _reconnectAttempts = 0;

      log('Socket connected successfully for user: $userId');
      return true;
    } catch (e) {
      log('Socket connection failed: $e');
      _updateStatus(ConnectionStatus.error);
      _scheduleReconnect();
      return false;
    }
  }

  void _handleMessage(dynamic data) {
    if (_isDisposing) return;

    try {
      log("Raw message received: $data");

      if (data == null || (data is String && data.isEmpty)) {
        return;
      }

      final Map<String, dynamic> message = jsonDecode(data.toString());
      log("Parsed message: $message");

      switch (message['type']) {
        case 'message':
          _handleIncomingMessage(message);
          break;
        case 'status_update':
          _handleStatusUpdate(message);
          break;
        case 'ping':
          _sendPong();
          break;
        case 'pong':
          log("Pong received");
          break;
        default:
          log("Unknown message type: ${message['type']}");
      }
    } catch (e, stack) {
      log('Error handling message: $e');
      log('Stack trace: $stack');
    }
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    try {
      final conversationId = data['conversation_id'];
      final messageText = data['message_text'] ?? '';
      final senderId = data['sender_id'];
      final messageId = data['message_id'];
      final createdAt = data['created_at'];

      if (conversationId == null || messageId == null || senderId == null) {
        log("Invalid message data - missing required fields");
        return;
      }

      final message = ChatMessage(
        messageId: messageId,
        senderId: senderId,
        conversationId: conversationId,
        messageText: messageText,
        createdAt:
            createdAt != null ? DateTime.parse(createdAt) : DateTime.now(),
        status: MessageStatus.delivered,
      );

      log("Broadcasting message: ${message.messageId} from ${message.senderId}");
      _messageController.add(message);
    } catch (e) {
      log("Error processing incoming message: $e");
    }
  }

  void _handleStatusUpdate(Map<String, dynamic> data) {
    log("Status update: $data");
    _statusUpdateController.add(data);
  }

  void _handleError(error) {
    log('Socket error: $error');
    if (!_isDisposing) {
      _updateStatus(ConnectionStatus.error);
      _scheduleReconnect();
    }
  }

  void _handleDisconnect() {
    log('Socket disconnected');
    if (!_isDisposing) {
      _updateStatus(ConnectionStatus.disconnected);
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    if (_isDisposing || _reconnectAttempts >= _maxReconnectAttempts) {
      return;
    }

    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();

    final delay = Duration(seconds: 2 * (_reconnectAttempts + 1));
    log('Scheduling reconnect in ${delay.inSeconds} seconds (attempt ${_reconnectAttempts + 1})');

    _updateStatus(ConnectionStatus.reconnecting);
    _reconnectTimer = Timer(delay, () {
      if (!_isDisposing && _userId != null) {
        _reconnectAttempts++;
        connect(_userId!);
      }
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_status == ConnectionStatus.connected && !_isDisposing) {
        _sendPing();
      }
    });
  }

  void _sendPing() {
    try {
      if (_channel != null && _status == ConnectionStatus.connected) {
        _channel!.sink.add(jsonEncode({'type': 'ping'}));
        log("Ping sent");
      }
    } catch (e) {
      log("Error sending ping: $e");
    }
  }

  void _sendPong() {
    try {
      if (_channel != null && _status == ConnectionStatus.connected) {
        _channel!.sink.add(jsonEncode({'type': 'pong'}));
        log("Pong sent");
      }
    } catch (e) {
      log("Error sending pong: $e");
    }
  }

  Future<bool> sendMessage(
      String conversationId, String messageText, String messageId) async {
    if (!isConnected) {
      log('Cannot send message - not connected');
      throw Exception('Not connected to WebSocket');
    }

    final payload = {
      'type': 'message',
      'conversation_id': conversationId,
      'message_id': messageId,
      'message': messageText,
    };

    try {
      log("Sending message: $payload");
      _channel!.sink.add(jsonEncode(payload));
      log("Message sent successfully");
      return true;
    } catch (e) {
      log('Error sending message: $e');
      throw Exception('Failed to send message: $e');
    }
  }

  void updateMessageStatus(String messageId, MessageStatus status) {
    if (!isConnected) {
      log('Cannot update status - not connected');
      return;
    }

    final payload = {
      'type': 'status_update',
      'message_id': messageId,
      'status': status.name,
    };

    try {
      log("Updating message status: $payload");
      _channel!.sink.add(jsonEncode(payload));
    } catch (e) {
      log('Error updating message status: $e');
    }
  }

  void _updateStatus(ConnectionStatus status) {
    if (_status != status) {
      _status = status;
      log("Connection status changed to: $status");
      _statusController.add(status);
    }
  }

  void _cleanup() {
    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();
    try {
      _channel?.sink.close(webStatus.goingAway);
    } catch (e) {
      log('Error closing previous channel: $e');
    }
    _channel = null;
  }

  void disconnect() {
    log('Manually disconnecting socket');
    _isDisposing = true;
    _cleanup();
    _updateStatus(ConnectionStatus.disconnected);
    _userId = null;
    _reconnectAttempts = 0;
  }

  void dispose() {
    log('Disposing socket service');
    disconnect();
    _messageController.close();
    _statusController.close();
    _statusUpdateController.close();
  }
}
