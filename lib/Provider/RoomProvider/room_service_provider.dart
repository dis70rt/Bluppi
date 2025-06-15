import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:synqit/generated/protobuf/room.pbgrpc.dart';
import 'package:synqit/generated/protobuf/streaming.pbgrpc.dart';
import 'package:synqit/generated/protobuf/common.pbenum.dart';
import 'package:synqit/generated/protobuf/playback.pb.dart';


final grpcChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    '127.0.0.1',
    port: 50051,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      idleTimeout: Duration(minutes: 5),
    ),
  );

  ref.onDispose(() {
    log('Shutting down gRPC channel');
    channel.shutdown();
  });
  return channel;
});

final roomServiceProvider = Provider<RoomServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return RoomServiceClient(channel);
});

final roomStreamServiceProvider = Provider<RoomStreamServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return RoomStreamServiceClient(channel);
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
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      isConnectedToStream: isConnectedToStream ?? this.isConnectedToStream,
      currentPlayback: clearPlayback ? null : currentPlayback ?? this.currentPlayback,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}

class RoomNotifier extends StateNotifier<RoomState> {
  final RoomServiceClient _roomService;
  final RoomStreamServiceClient _streamService;
  StreamSubscription<RoomStreamUpdate>? _streamSubscription;

  RoomNotifier(this._roomService, this._streamService) : super(RoomState()) {
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
      
      await joinRoomStream(newRoom.id, hostUserId);
      return newRoom;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }

  Future<bool> joinRoomStream(String roomId, String userId) async {
    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    
    try {
      final joinRequest = JoinRoomStreamRequest(
        roomId: roomId,
        userId: userId,
      );
      
      final snapshot = await _streamService.joinRoomStream(joinRequest);
      
      state = state.copyWith(
        currentRoom: snapshot.roomInfo,
        currentPlayback: snapshot.currentPlayback,
        memberCount: snapshot.memberCount,
        isLoading: false,
      );
      
      return await _setupRoomStreamConnection(roomId, userId);
    } catch (e) {
      log('Error joining room stream: $e');
      state = state.copyWith(
        isLoading: false, 
        errorMessage: 'Failed to join room stream: ${e.toString()}'
      );
      return false;
    }
  }

  Future<bool> _setupRoomStreamConnection(String roomId, String userId) async {
    try {
      _closeCurrentStream();
      
      final streamRequest = StreamRoomUpdatesRequest(
        roomId: roomId,
        userId: userId,
      );
      
      final stream = _streamService.streamRoomUpdates(streamRequest);
      _streamSubscription = stream.listen(
        _handleRoomUpdate,
        onError: _handleStreamError,
        onDone: _handleStreamClosed,
      );
      
      state = state.copyWith(isConnectedToStream: true);
      return true;
    } catch (e) {
      log('Failed to setup room stream: $e');
      state = state.copyWith(
        isConnectedToStream: false, 
        errorMessage: 'Failed to connect to room stream: ${e.toString()}'
      );
      return false;
    }
  }

  void _handleRoomUpdate(RoomStreamUpdate update) {
    if (update.hasMemberUpdate()) {
      _handleMemberUpdate(update.memberUpdate);
    } else if (update.hasPlaybackUpdate()) {
      _handlePlaybackUpdate(update.playbackUpdate);
    } else if (update.hasRoomStatusUpdate()) {
      _handleRoomStatusUpdate(update.roomStatusUpdate);
    }
  }

  void _handleMemberUpdate(MemberUpdate update) {
    if (update.hasMemberJoin()) {
      state = state.copyWith(
        memberCount: state.memberCount + 1,
      );
    } else if (update.hasMemberLeave()) {
      state = state.copyWith(
        memberCount: state.memberCount - 1 >= 0 ? state.memberCount - 1 : 0,
      );
    }
  }

  void _handlePlaybackUpdate(PlaybackUpdate update) {
    PlaybackState? newPlayback = state.currentPlayback;
    
    if (update.hasTrackChange()) {
      final change = update.trackChange;
      newPlayback = PlaybackState(
        roomId: state.currentRoom!.id,
        currentTrackId: change.currentTrack.trackId,
        positionMs: change.positionMs,
        status: state.currentPlayback?.status ?? PlaybackStatus.PLAYING,
      );
    } else if (update.hasPlayState()) {
      final playState = update.playState;
      newPlayback = PlaybackState(
        roomId: state.currentRoom!.id,
        currentTrackId: state.currentPlayback?.currentTrackId ?? '',
        positionMs: playState.positionMs,
        status: playState.status,
      );
    } else if (update.hasSeek() && state.currentPlayback != null) {
      newPlayback = PlaybackState(
        roomId: state.currentRoom!.id,
        currentTrackId: state.currentPlayback!.currentTrackId,
        positionMs: update.seek.positionMs,
        status: state.currentPlayback!.status,
      );
    }
    
    if (newPlayback != null) {
      state = state.copyWith(currentPlayback: newPlayback);
    }
  }

  void _handleRoomStatusUpdate(RoomStatusUpdate update) {
    if (update.status == RoomStatus.INACTIVE) {
      log('Room became inactive: ${update.reason}');
      leaveRoom();
      state = state.copyWith(
        errorMessage: 'Room closed: ${update.reason}',
      );
    }
  }

  void _handleStreamError(String error) {
    log('Stream error: $error');
    state = state.copyWith(
      isConnectedToStream: false,
      errorMessage: 'Stream error: ${error.toString()}',
    );
  }

  void _handleStreamClosed() {
    log('Room stream closed');
    state = state.copyWith(isConnectedToStream: false);
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
      
      await joinRoomStream(roomId, userId);
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
          // Server method not implemented yet, but we still need to
          // handle the client-side cleanup
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
      isConnectedToStream: false
    );
    
    fetchAvailableRooms();
  }
  
  void _closeCurrentStream() {
    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }
  }
  
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearErrorMessage: true);
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
  final streamService = ref.watch(roomStreamServiceProvider);
  return RoomNotifier(roomService, streamService);
});