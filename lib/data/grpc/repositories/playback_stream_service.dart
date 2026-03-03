import 'dart:async';

import 'package:bluppi/data/grpc/channels/grpc_channel.dart';
import 'package:bluppi/domain/models/playback_stream_model.dart';
import 'package:bluppi/domain/repositories/playback_stream_repository.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/generated/playback.pbgrpc.dart' as proto;

final playbackStreamServiceProvider = Provider<PlaybackStreamServiceRepository>(
  (ref) {
    final channel = ref.watch(grpcChannelProvider);
    return PlaybackStreamServiceRepository(
      proto.PlaybackServiceClient(channel),
    );
  },
);

class PlaybackStreamServiceRepository implements PlaybackStreamRepository {
  final proto.PlaybackServiceClient _client;
  StreamController<proto.ClientCommand>? _commandStream;
  String? _roomId;
  String? _userId;

  PlaybackStreamServiceRepository(this._client);

  proto.ClientCommand _wrap({
    proto.PlayCommand? play,
    proto.PauseCommand? pause,
    proto.TrackChangeCommand? trackChange,
    proto.BufferReady? bufferReady,
  }) {
    return proto.ClientCommand(
      roomId: _roomId ?? '',
      userId: _userId ?? '',
      play: play,
      pause: pause,
      trackChange: trackChange,
      bufferReady: bufferReady,
    );
  }

  @override
  Stream<PlaybackStateModel> joinRoom(String roomId, String userId) {
    _commandStream?.close();
    _commandStream = StreamController<proto.ClientCommand>();
    _roomId = roomId;
    _userId = userId;

    _commandStream!.add(proto.ClientCommand(roomId: roomId, userId: userId));

    final responseStream = _client.streamSession(_commandStream!.stream);
    return responseStream
        .where((event) => event.hasPlaybackState())
        .map((event) => PlaybackStateModel.fromProto(event.playbackState));
  }

  @override
  void leaveRoom() {
    _commandStream?.close();
    _commandStream = null;
    _roomId = null;
    _userId = null;
  }

  @override
  void sendBufferReady(int version) {
    _commandStream?.add(
      _wrap(bufferReady: proto.BufferReady(version: Int64(version))),
    );
  }

  @override
  void sendPlay() => _commandStream?.add(_wrap(play: proto.PlayCommand()));

  @override
  void sendPause() => _commandStream?.add(_wrap(pause: proto.PauseCommand()));

  @override
  void sendTrackChange(PlaybackTrackModel track) {
    _commandStream?.add(
      _wrap(
        trackChange: proto.TrackChangeCommand(
          trackId: track.id,
          title: track.title,
          artist: track.artist,
          audioUrl: track.audioUrl,
          artworkUrl: track.artworkUrl,
          durationMs: Int64(track.durationMs),
        ),
      ),
    );
  }
}