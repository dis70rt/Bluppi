import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bluppi/Data/Models/message_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  String? _conversationId;
  ConnectionStatus _status = ConnectionStatus.disconnected;
  bool _isDisposing = false;

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

  Future<bool> connectToConversation(String userId, String conversationId) async {
    if (_isDisposing) return false;

    if (_status == ConnectionStatus.connected && 
        _userId == userId && 
        _conversationId == conversationId) {
      return true;
    }

    if (_status == ConnectionStatus.connected) {
      disconnect();
    }

    _userId = userId;
    _conversationId = conversationId;
    _updateStatus(ConnectionStatus.connecting);
    
    log("Connecting to conversation: $conversationId as user: $userId");

    try {
      final uri = Uri.parse('$baseUrl/ws/v1/$userId/$conversationId');
      log("WebSocket URI: ${uri.toString()}");

      _channel = IOWebSocketChannel.connect(uri.toString(), pingInterval: const Duration(seconds: 30));

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
        cancelOnError: false,
      );

      _updateStatus(ConnectionStatus.connected);
      log('Connected to conversation: $conversationId');
      return true;
    } catch (e) {
      log('Connection failed: $e');
      _updateStatus(ConnectionStatus.error);
      return false;
    }
  }

  void _handleMessage(dynamic data) {
    if (_isDisposing) return;

    try {
      final Map<String, dynamic> message = jsonDecode(data);
      log("Received message: $message");

      switch (message['type']) {
        case 'text':
        case 'track':
          _handleIncomingMessage(message);
          break;
        case 'status_update':
          _handleStatusUpdate(message);
          break;
        default:
          log("Unknown message type: ${message['type']}");
      }
    } catch (e, stack) {
      log('Error handling message: $e\n$stack');
    }
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    try {
      final message = ChatMessage.fromJson(data);
      
      _messageController.add(message);
    } catch (e) {
      log('Error parsing message: $e');
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
    }
  }

  void _handleDisconnect() {
    log('Socket disconnected');
    if (!_isDisposing) {
      _updateStatus(ConnectionStatus.disconnected);
    }
  }

  Future<bool> sendMessage(String messageId, String message, String type) async {
    if (!isConnected || _channel == null) {
      log('Cannot send message: not connected');
      return false;
    }

    try {
      final messageData = {
        'type': type,
        'message_id': messageId,
        'message': message,
      };

      _channel!.sink.add(jsonEncode(messageData));
      log('Message sent: $messageData');
      return true;
    } catch (e) {
      log('Error sending message: $e');
      return false;
    }
  }

  void updateMessageStatus(String messageId, MessageStatus status) {
    if (!isConnected || _channel == null) return;

    try {
      final statusData = {
        'type': 'status_update',
        'message_id': messageId,
        'status': status.name,
      };

      _channel!.sink.add(jsonEncode(statusData));
      log('Status update sent: $statusData');
    } catch (e) {
      log('Error sending status update: $e');
    }
  }

  void _updateStatus(ConnectionStatus status) {
    if (_status != status) {
      _status = status;
      _statusController.add(status);
    }
  }

  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
    _updateStatus(ConnectionStatus.disconnected);
    _userId = null;
    _conversationId = null;
  }

  void dispose() {
    _isDisposing = true;
    disconnect();
    _messageController.close();
    _statusController.close();
    _statusUpdateController.close();
  }
}