import 'dart:convert';
import 'dart:developer';
import 'package:bluppi/Data/Models/live_chat_model.dart';
import 'package:bluppi/Utils/get_mqtt_client_id.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class LiveChatState {
  final String? roomId;
  final List<LiveChatModel> messages;
  final bool isConnected;

  LiveChatState({
    this.roomId,
    this.messages = const [],
    this.isConnected = false,
  });

  LiveChatState copyWith({
    String? roomId,
    List<LiveChatModel>? messages,
    bool? isConnected,
  }) {
    return LiveChatState(
      roomId: roomId ?? this.roomId,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  LiveChatState addMessage(LiveChatModel message) {
    final updatedMessages = [...messages, message];
    return copyWith(messages: updatedMessages);
  }

  LiveChatState clear() {
    return copyWith(messages: [], roomId: null, isConnected: false);
  }

  List<LiveChatModel> get sortedMessages {
    final sorted = [...messages];
    sorted.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return sorted;
  }
}

class LiveChatService extends StateNotifier<LiveChatState> {
  MqttServerClient? _client;

  LiveChatService() : super(LiveChatState());

  Future<bool> connect(String roomId) async {
    try {
      if (state.isConnected && state.roomId != roomId) {
        await disconnect();
      }

      if (state.isConnected && state.roomId == roomId) {
        return true;
      }

      final clientId = await getMqttClientId();
      final brokerUrl = dotenv.env["API_URL"]!;
      final username = dotenv.env["MQTT_USERNAME"]!;
      final password = dotenv.env["MQTT_PASSWORD"]!;

      _client = MqttServerClient(brokerUrl, clientId);
      _client!.logging(on: false);
      _client!.setProtocolV311();
      _client!.keepAlivePeriod = 20;
      _client!.connectTimeoutPeriod = 2000;
      _client!.autoReconnect = true;
      _client!.resubscribeOnAutoReconnect = true;

      final connMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
          .authenticateAs(username, password);

      _client!.connectionMessage = connMessage;

      _client!.onConnected = () {
        log('Connected to room $roomId', name: "MQTT");
        state = state.copyWith(isConnected: true, roomId: roomId);
        _subscribeToRoom(roomId);
      };

      _client!.onDisconnected = () {
        log('Disconnected from room', name: "MQTT");
        state = state.copyWith(isConnected: false);
      };

      _client!.onSubscribed = (String topic) {
        log('Subscribed to $topic', name: "MQTT");
      };

      _client!.updates!
          .listen((List<MqttReceivedMessage<MqttMessage>> messages) {
        for (final message in messages) {
          _handleIncomingMessage(message);
        }
      });

      await _client!.connect();

      return state.isConnected;
    } catch (e) {
      log('Connection error: $e', name: "MQTT ERROR");
      state = state.copyWith(isConnected: false);
      return false;
    }
  }

  Future<void> disconnect() async {
    if (_client != null && state.isConnected) {
      try {
        _client!.disconnect();
        _client = null;
        state = state.clear();
        log('Disconnected successfully', name: "MQTT");
      } catch (e) {
        log('Disconnect error: $e', name: "MQTT");
      }
    }
  }

  void _subscribeToRoom(String roomId) {
    if (_client != null && state.isConnected) {
      final topic = 'chat/room/$roomId';
      _client!.subscribe(topic, MqttQos.atMostOnce);
    }
  }

  void _handleIncomingMessage(MqttReceivedMessage<MqttMessage> mqttMessage) {
    final topic = mqttMessage.topic;
    final message = mqttMessage.payload as MqttPublishMessage;
    final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);

    log('Received message from $topic: $payload', name: "MQTT");

    try {
      final jsonData = json.decode(payload);
      final chatMessage = LiveChatModel.fromJson(jsonData);

      state = state.addMessage(chatMessage);
    } catch (e) {
      log('Error parsing message: $e', name: "MQTT ERROR");
    }
  }

  void sendMessage(String messageText, ChatUser currentUser) {
    if (_client != null && state.isConnected && state.roomId != null) {
      final chatMessage = LiveChatModel(
        sender: currentUser,
        message: messageText,
        timestamp: DateTime.now(),
      );

      final topic = 'chat/room/${state.roomId}';
      final payload = json.encode(chatMessage.toJson());

      final builder = MqttClientPayloadBuilder();
      builder.addString(payload);

      _client!.publishMessage(
        topic,
        MqttQos.atMostOnce,
        builder.payload!,
      );

      log('Sent message to $topic', name: "MQTT");
    }
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
  }
}

final liveChatServiceProvider =
    StateNotifierProvider<LiveChatService, LiveChatState>((ref) {
  final service = LiveChatService();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
});

final chatMessagesProvider = Provider<List<LiveChatModel>>((ref) {
  final state = ref.watch(liveChatServiceProvider);
  return state.sortedMessages;
});
