import 'dart:async';
import 'dart:developer';
import 'package:bluppi/Provider/RoomProvider/grpc_channel_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/generated/protobuf/room.pbgrpc.dart';
import 'package:bluppi/generated/protobuf/common.pbenum.dart';
import 'package:bluppi/generated/protobuf/playback.pb.dart';

final roomServiceProvider = Provider<RoomServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return RoomServiceClient(channel);
});

class RoomState {
  final Room? currentRoom;
  final List<Room> availableRooms;
  final bool isLoading;
  final String? errorMessage;
  final bool isConnectedToStream;
  final PlaybackState? currentPlayback;
  final int memberCount;

  bool get isInRoom => currentRoom != null && !isLoading;

  RoomState({
    this.currentRoom,
    this.availableRooms = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isConnectedToStream = false,
    this.currentPlayback,
    this.memberCount = 0,
  });

  RoomState copyWith({
    Room? currentRoom,
    List<Room>? availableRooms,
    bool? isLoading,
    String? errorMessage,
    bool? isConnectedToStream,
    PlaybackState? currentPlayback,
    int? memberCount,
    bool clearCurrentRoom = false,
    bool clearErrorMessage = false,
    bool clearPlayback = false,
  }) {
    return RoomState(
      currentRoom: clearCurrentRoom ? null : currentRoom ?? this.currentRoom,
      availableRooms: availableRooms ?? this.availableRooms,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      isConnectedToStream: isConnectedToStream ?? this.isConnectedToStream,
      currentPlayback:
          clearPlayback ? null : currentPlayback ?? this.currentPlayback,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}

class RoomNotifier extends StateNotifier<RoomState> {
  final RoomServiceClient _roomService;

  RoomNotifier(this._roomService) : super(RoomState()) {
    fetchAvailableRooms();
  }

  Future<void> fetchAvailableRooms() async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final request = ListRoomsRequest(
        pageSize: 10,
        pageToken: '',
      );
      final response = await _roomService.listRooms(request);

      state = state.copyWith(
        availableRooms: response.rooms,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<Room?> createRoom({
    required String name,
    required String description,
    required bool inviteOnly,
    required RoomVisibility visibility,
    required String hostUserId,
  }) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final request = CreateRoomRequest(
        name: name,
        description: description,
        inviteOnly: inviteOnly,
        visibility: visibility,
        hostUserId: hostUserId,
      );

      final newRoom = await _roomService.createRoom(request);

      state = state.copyWith(
        currentRoom: newRoom,
        availableRooms: [...state.availableRooms, newRoom],
        isLoading: false,
      );

      return newRoom;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }

  Future<Room?> joinRoom(String roomId, String userId) async {
    if (state.currentRoom?.id == roomId) return state.currentRoom;

    state = state.copyWith(isLoading: true, clearErrorMessage: true);

    try {
      final request = JoinRoomRequest(
        roomId: roomId,
        userId: userId,
      );

      final joinedRoom = await _roomService.joinRoom(request);

      state = state.copyWith(
        currentRoom: joinedRoom,
        isLoading: false,
      );

      return joinedRoom;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }

  Future<void> leaveRoom() async {
    if (state.currentRoom != null) {
      try {
        final request = LeaveRoomRequest(
          roomId: state.currentRoom!.id,
          userId: state.currentRoom!.hostUserId,
        );

        try {
          await _roomService.leaveRoom(request);
        } catch (e) {
          log('Error leaving room: $e');
        }
      } catch (e) {
        log('Error preparing leave room request: $e');
      }
    }

    _closeCurrentStream();
    state = state.copyWith(
        clearCurrentRoom: true,
        clearPlayback: true,
        isConnectedToStream: false);

    fetchAvailableRooms();
  }

  void _closeCurrentStream() {}

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearErrorMessage: true);
    }
  }

  void toggleRoom() {
    if (state.currentRoom == null) {
      final debugRoom = Room(
        id: 'debug-room',
        name: 'Debug Room',
        description: 'Room for testing only',
        inviteOnly: false,
        visibility: RoomVisibility.PUBLIC,
        hostUserId: 'debug-user',
      );

      state = state.copyWith(
        currentRoom: debugRoom,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        clearCurrentRoom: true,
        isLoading: false,
      );
    }
  }

  @override
  void dispose() {
    _closeCurrentStream();
    super.dispose();
  }
}

final roomProvider = StateNotifierProvider<RoomNotifier, RoomState>((ref) {
  final roomService = ref.watch(roomServiceProvider);

  return RoomNotifier(roomService);
});
