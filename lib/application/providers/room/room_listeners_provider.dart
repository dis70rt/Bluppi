import 'dart:async';
import 'dart:developer';

import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/room_service.dart';
import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomListenersProvider =
    NotifierProvider.family<RoomListenersNotifier, List<String>, String>(
      (arg) => RoomListenersNotifier(arg),
    );

class RoomListenersNotifier extends Notifier<List<String>> {
  final String roomId;
  RoomListenersNotifier(this.roomId);

  StreamSubscription<RoomEventModel>? _eventSub;

  @override
  List<String> build() {
    ref.onDispose(() {
      _eventSub?.cancel();
    });

    _listenToEvents(roomId);
    return [];
  }

  void _listenToEvents(String roomId) {
    final repo = ref.read(roomServiceProvider);
    final currentUserId = ref.read(userProvider).value?.id ?? '';

    _eventSub = repo.subscribeToRoomEvents(roomId, currentUserId).listen(
      (event) {
        switch (event.type) {
          case RoomEventType.userJoined:
            log('User Joined: ${event.targetUserId}', name: 'RoomListenersNotifier');
            addListener(event.targetUserId);
            break;
          case RoomEventType.userLeft:
            log('User Left: ${event.targetUserId}', name: 'RoomListenersNotifier');
            removeListener(event.targetUserId);
            break;
          case RoomEventType.roomEnded:
            log('Room Ended', name: 'RoomListenersNotifier');
            clear();
            break;
          case RoomEventType.unknown:
            break;
        }
      },
      onError: (err) {
        log('Listener Stream Error: $err', name: 'RoomListenersNotifier', error: err);
      },
    );
  }

  void addListener(String userId) {
    if (!state.contains(userId)) {
      state = [...state, userId];
    }
  }

  void removeListener(String userId) {
    state = state.where((id) => id != userId).toList();
  }

  void clear() {
    state = [];
  }
}
