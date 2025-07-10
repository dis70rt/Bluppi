import 'dart:async';
import 'dart:developer';
import 'package:bluppi/Data/Models/track_model.dart';
import 'package:bluppi/Data/Services/notification_method_channel.dart';
import 'package:bluppi/Provider/MusicProvider/music_player_provider.dart';
import 'package:bluppi/Provider/RoomProvider/grpc_channel_provider.dart';
import 'package:bluppi/Provider/RoomProvider/sync_provider.dart';
import 'package:bluppi/generated/protobuf/streaming.pbgrpc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixnum/fixnum.dart';
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
  final MemberStatus_StatusType? memberStatus;
  final int memberCount;

  bool get isInRoom => currentRoom != null && !isLoading;

  RoomState({
    this.currentRoom,
    this.availableRooms = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isConnectedToStream = false,
    this.currentPlayback,
    this.memberStatus,
    this.memberCount = 0,
  });

  RoomState copyWith({
    Room? currentRoom,
    List<Room>? availableRooms,
    bool? isLoading,
    String? errorMessage,
    bool? isConnectedToStream,
    PlaybackState? currentPlayback,
    MemberStatus_StatusType? memberStatus,
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
      memberStatus: memberStatus ?? this.memberStatus,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}

class RoomNotifier extends StateNotifier<RoomState> {
  final RoomServiceClient _roomService;
  final SyncServiceClient _syncService;
  final Ref ref;

  RoomNotifier(this._roomService, this._syncService, this.ref)
      : super(RoomState()) {
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

      startListeningForBroadcasts(joinedRoom.id, userId);
      return joinedRoom;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }

  Stream<MemberStatus> _memberStatus() async* {
    while (true) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (state.currentRoom == null) {
        StateError('Cannot yield member status: Not in a room');
      }
      yield MemberStatus(
        roomId: state.currentRoom!.id,
        userId: userId,
        status: state.memberStatus,
        actualPositionMs: state.currentRoom!.currentPositionMs,
        clientTimestampMs: Int64(DateTime.now().millisecondsSinceEpoch),
      );
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  StreamSubscription<ServerBroadcast>? currentStreamSubscription;
  Future<void> startListeningForBroadcasts(String roomId, String userId) async {
    _closeCurrentStream();

    final requestStream = _memberStatus();
    final responseStream = _syncService.memberSync(requestStream);

    currentStreamSubscription = responseStream.listen(
      (broadcast) => _handleBroadcast(broadcast),
      onError: (e) => log('gRPC error in broadcast listener: $e'),
      onDone: () => log('Broadcast stream closed'),
      cancelOnError: true,
    );

    state = state.copyWith(isConnectedToStream: true);
  }

  void _handleBroadcast(ServerBroadcast broadcast) {
    switch (broadcast.type) {
      case ServerBroadcast_BroadcastType.POSITION_UPDATE:
        log('''
Position Update Received:
  - Room ID: ${broadcast.positionUpdate.roomId}
  - Host User ID: ${broadcast.positionUpdate.hostUserId.substring(0, 8)}...
  - Current Position: ${broadcast.positionUpdate.currentPositionMs.toInt()}ms
  - Server Timestamp: ${broadcast.positionUpdate.serverTimestampMs.toInt()}ms
''', name: 'ServerBroadcast');
        break;

      case ServerBroadcast_BroadcastType.CONTROL_COMMAND:
        log('''
Control Command Received:
  - Type: ${broadcast.controlCommand.type}
  - Execute At Server: ${broadcast.controlCommand.executeAtServerMs}
  - Position: ${broadcast.controlCommand.positionMs}ms
  - Host User ID: ${broadcast.controlCommand.hostUserId.substring(0, 8)}...
''', name: 'ServerBroadcast');
        break;

      case ServerBroadcast_BroadcastType.TRACK_COMMAND:
        final _mediaService = ref.read(mediaServiceProvider);
        final _track = broadcast.trackCommand.track;
        final track = Track(
                trackId: _track.trackId,
                artistName: _track.artist,
                trackName: _track.title,
                albumName: "",
                imageUrl: _track.imageUrl,
                previewUrl: "",
                genres: [],
                listeners: 0,
                playcount: 0,
                lastFmUrl: "",
                audioUrl: _track.audioUrl);
        _mediaService.play(
            track: track);
          ref.read(musicPlayerProvider.notifier).statePlay(track);
        break;

      case ServerBroadcast_BroadcastType.MEMBER_JOINED:
        log('Member Joined: ${broadcast.affectedUserId.substring(0, 8)}...',
            name: 'ServerBroadcast');
        break;

      case ServerBroadcast_BroadcastType.MEMBER_LEFT:
        log('Member Left: ${broadcast.affectedUserId.substring(0, 8)}...',
            name: 'ServerBroadcast');
        break;

      default:
        log('Unknown broadcast type: ${broadcast.type}',
            name: 'ServerBroadcast');
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

  void _closeCurrentStream() {
    currentStreamSubscription?.cancel();
    currentStreamSubscription = null;

    state = state.copyWith(isConnectedToStream: false);
  }

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
  final sync = ref.watch(syncService);

  return RoomNotifier(roomService, sync, ref);
});
