import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/room_service.dart';
import 'package:bluppi/domain/models/room_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentRoomProvider = NotifierProvider<CurrentRoomNotifier, RoomModel?>(
  CurrentRoomNotifier.new,
);

class CurrentRoomNotifier extends Notifier<RoomModel?> {
  @override
  RoomModel? build() {
    return null;
  }

  Future<void> joinRoom(RoomModel room) async {
    state = room;
  }

  Future<void> leaveRoom() async {
    final currentRoom = state;
    final currentUser = ref.read(userProvider).value;

    if (currentRoom == null || currentUser == null) {
      state = null;
      return;
    }

    try {
      await ref
          .read(roomServiceProvider)
          .leaveRoom(currentRoom.id, currentUser.id);
    } catch (_) {}
    state = null;
  }
}
