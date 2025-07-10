
import 'dart:async';
import 'dart:developer';

import 'package:bluppi/Data/Models/track_model.dart' as t;
import 'package:bluppi/Provider/RoomProvider/host_sync_state.dart';
import 'package:bluppi/Provider/RoomProvider/room_provider.dart';
import 'package:bluppi/Provider/RoomProvider/sync_provider.dart';
import 'package:bluppi/generated/protobuf/streaming.pbgrpc.dart';
import 'package:bluppi/generated/protobuf/track.pb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomSyncState {
  final ServerResponse? response;
  final ServerBroadcast? broadcast;
  final String? error;

  RoomSyncState({
    this.response,
    this.broadcast,
    this.error,
  });
}

class RoomSyncNotifier extends StateNotifier<RoomSyncState> {
  final SyncServiceClient syncClient;
  final Ref ref;

  late final StreamController<HostCommand> _requestController;
  late final Stream<ServerResponse> _responseStream;

  RoomSyncNotifier(this.syncClient, this.ref) : super(RoomSyncState()) {
    _requestController = StreamController<HostCommand>();
    _responseStream = syncClient.sendHostCommand(_requestController.stream);
    _responseStream.listen((event) {
      log("$event", name: "ServerResponse");
    });
  }

  HostPlaybackCommand_CommandType hostCommandType(CommandType type) {
    switch (type) {
      case CommandType.PLAY:
        return HostPlaybackCommand_CommandType.PLAY;
      case CommandType.PAUSE:
        return HostPlaybackCommand_CommandType.PAUSE;
      case CommandType.SEEK:
        return HostPlaybackCommand_CommandType.SEEK;
      case CommandType.TRACK_CHANGE:
        return HostPlaybackCommand_CommandType.TRACK_CHANGE;
      case CommandType.ADJUST_RATE:
        return HostPlaybackCommand_CommandType.ADJUST_RATE;
    }
  }
  
  HostTrackCommand trackCommand({required t.Track track,required int startPosition,required int duration}) {
    final room = ref.read(roomProvider);
    if (room.currentRoom == null) {
      throw StateError('Cannot create track command: Not in a $room');
    }
    
    return HostTrackCommand(
     roomId: room.currentRoom!.id,
     hostUserId: room.currentRoom!.hostUserId,
     startPosition: Int64(startPosition),
     startAtServerMs: Int64(0),
     track: Track(
      artist: track.artistName,
      audioUrl: track.audioUrl,
      durationMs: duration,
      imageUrl: track.imageUrl,
      title: track.trackName,
      trackId: track.trackId
     )
    );
  }

  HostPositionUpdate positionUpdate(int currentPositionMs) {
    final room = ref.read(roomProvider);
    return HostPositionUpdate(
      roomId: room.currentRoom!.id,
      hostUserId: room.currentRoom!.hostUserId,
      currentPositionMs: Int64(currentPositionMs),
      serverTimestampMs: Int64(0)
    );
  }

  HostPlaybackCommand playbackCommand(CommandType type, int positionMs) {
    final room = ref.read(roomProvider);
    return HostPlaybackCommand(
      roomId: room.currentRoom!.id,
      hostUserId: room.currentRoom!.hostUserId,
      type: hostCommandType(type),
      executeAtServerMs: Int64(0),
      positionMs: Int64(positionMs)
    );
  }

  void hostCommand({
    HostTrackCommand? trackCommand,
    HostPositionUpdate? positionUpdate,
    HostPlaybackCommand? playbackCommand,
  }) async {
    final room = ref.read(roomProvider);
    final hostCommand = HostCommand();
    log("Room Details", name: "RoomSyncNotifier");

    if ([trackCommand, positionUpdate, playbackCommand]
        .whereType<Object>().toList().length != 1) {
      throw ArgumentError('Exactly one command must be provided');
    }
    
    if (trackCommand != null) hostCommand.trackCommand = trackCommand;
    if (positionUpdate != null) hostCommand.positionUpdate = positionUpdate;
    if (playbackCommand != null) hostCommand.controlCommand = playbackCommand;

    if(room.isInRoom && room.currentRoom != null) {
      if (FirebaseAuth.instance.currentUser!.uid == room.currentRoom!.hostUserId) {
        log("Sending host command", name: "RoomSyncNotifier");
        _requestController.add(hostCommand);
      } else {
        log("Cannot send host command: Not the room host", name: "RoomSyncNotifier");
      }
    } else {
      throw StateError('Cannot send command: Not in a room');
    }
  }
}

final roomSyncProvider = StateNotifierProvider<RoomSyncNotifier, RoomSyncState>((ref) {
  final client = ref.read(syncService);
  return RoomSyncNotifier(client, ref);
});