import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/room_service.dart';
import 'package:bluppi/domain/models/live_chat_bubble.dart';
import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final liveChatProvider =
    NotifierProvider.family<LiveChatNotifier, List<LiveChatBubble>, String>(
  (arg) => LiveChatNotifier(arg),
);

class LiveChatNotifier extends Notifier<List<LiveChatBubble>> {
  final String roomId;
  LiveChatNotifier(this.roomId);

  static const int _maxMessages = 200;

  @override
  List<LiveChatBubble> build() {
     ref.onDispose(() {
      clear();
    });
    return [];
  }

  void addSystemMessage(String text) {
    final message = LiveChatBubble.system(text);
    _appendMessage(message);
  }

  void addUserMessage({
    required LiveChatMessageModel msg,
    required JoinedMemberModel profile,
  }) {
    final currentUserId = ref.read(userProvider).value?.id ?? '';
    final currentRoom = ref.read(currentRoomProvider);

    if (currentRoom == null) {
      return;
    }

    final hostUserId = currentRoom.hostUserId;

    final isHost = profile.userId == hostUserId;
    final isCurrentUser = profile.userId == currentUserId;

    final message = LiveChatBubble.user(
      msg: msg,
      profile: profile,
      isHost: isHost,
      isCurrentUser: isCurrentUser,
    );

    _appendMessage(message);
  }

  void _appendMessage(LiveChatBubble message) {
    state = [...state, message];
    if (state.length > _maxMessages) {
      state = state.sublist(state.length - _maxMessages);
    }
  }

  Future<void> sendMessage(String message) async {
    final userId = ref.read(userProvider).value?.id;
    if (userId == null) {
      throw Exception('User is not logged in. Cannot send message.');
    }
    final repo = ref.read(roomServiceProvider);
    await repo.sendLiveChatMessage(roomId, message);
  }

  void clear() {
    state = [];
  }
}