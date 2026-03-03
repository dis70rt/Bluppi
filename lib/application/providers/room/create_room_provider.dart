import 'dart:developer';

import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/room_service.dart';
import 'package:riverpod/riverpod.dart';

class CreateRoomState {
  final String name;
  final bool isPublic;
  final bool inviteOnly;
  final bool isLoading;
  final String? error;

  static const int maxNameLength = 30;

  const CreateRoomState({
    this.name = '',
    this.isPublic = true,
    this.inviteOnly = false,
    this.isLoading = false,
    this.error,
  });

  CreateRoomState copyWith({
    String? name,
    bool? isPublic,
    bool? inviteOnly,
    bool? isLoading,
    String? error,
  }) {
    return CreateRoomState(
      name: name ?? this.name,
      isPublic: isPublic ?? this.isPublic,
      inviteOnly: inviteOnly ?? this.inviteOnly,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final createRoomProvider =
    NotifierProvider.autoDispose<CreateRoomController, CreateRoomState>(
      CreateRoomController.new,
    );

class CreateRoomController extends Notifier<CreateRoomState> {
  @override
  CreateRoomState build() {
    return const CreateRoomState();
  }

  void updateName(String value) {
    if (value.length > CreateRoomState.maxNameLength) {
      state = state.copyWith(
        error: "Max ${CreateRoomState.maxNameLength} characters allowed",
      );
      return;
    }

    state = state.copyWith(
      name: value,
      error: value.trim().isEmpty ? "Room name required" : null,
    );
  }

  void setPublic() {
    state = state.copyWith(isPublic: true);
  }

  void setPrivate() {
    state = state.copyWith(isPublic: false);
  }

  void toggleInviteOnly(bool value) {
    state = state.copyWith(inviteOnly: value);
  }

  Future<void> createRoom() async {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(error: "Room name required");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final hostUserId = ref.read(userProvider).value?.id;
      final repo = ref.read(roomServiceProvider);
      final room = await repo.createRoom(state.name, state.isPublic, state.inviteOnly, hostUserId!);
      ref.read(currentRoomProvider.notifier).setCreatedRoom(room);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      log("Failed to create room: $e", name: "CreateRoomController");
      state = state.copyWith(isLoading: false, error: "Failed to create room");
      return;
    }
  }
}
