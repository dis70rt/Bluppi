import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/music/stream_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/playback_stream_service.dart';
import 'package:bluppi/domain/models/playback_stream_model.dart';
import 'package:bluppi/main.dart';
import 'package:riverpod/riverpod.dart';

enum PlaybackStatus {
  idle,
  loading,
  buffering,
  playing,
  paused,
  completed,
  error,
}

class PlayerState {
  final PlaybackStatus status;
  final String? error;
  final Duration position;

  const PlayerState({
    required this.status,
    this.error,
    this.position = Duration.zero,
  });

  PlayerState copyWith({
    PlaybackStatus? status,
    String? error,
    Duration? position,
  }) {
    return PlayerState(
      status: status ?? this.status,
      error: error,
      position: position ?? this.position,
    );
  }
}

class PlaybackNotifier extends Notifier<PlayerState> {
  AudioHandler get _handler => audioHandler;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<QueueState>? _queueSub;

  @override
  PlayerState build() {
    _listen();
    ref.onDispose(() {
      _positionSub?.cancel();
      _queueSub?.cancel();
    });
    return const PlayerState(status: PlaybackStatus.idle);
  }

  bool get _canControlPlayback {
    final currentRoom = ref.read(currentRoomProvider);
    final currentUser = ref.read(userProvider).value;

    // 1. Not in a room? Do whatever you want.
    if (currentRoom == null) return true;
    // 2. Are you the host? Do whatever you want.
    if (currentRoom.hostUserId == currentUser?.id) return true;

    // 3. You are a listener. Hands off the DJ booth!
    return false;
  }

  bool get _isHost {
    final currentRoom = ref.read(currentRoomProvider);
    final currentUser = ref.read(userProvider).value;
    return currentRoom != null && currentRoom.hostUserId == currentUser?.id;
  }

  void _listen() {
    _handler.playbackState.listen((ps) {
      if (ps.processingState == AudioProcessingState.loading) {
        state = state.copyWith(status: PlaybackStatus.loading);
      } else if (ps.processingState == AudioProcessingState.buffering) {
        state = state.copyWith(status: PlaybackStatus.buffering);
      } else if (ps.playing) {
        state = state.copyWith(status: PlaybackStatus.playing);
      } else if (ps.processingState == AudioProcessingState.completed) {
        final queue = ref.read(queueProvider);

        if (queue.hasNext) {
          ref.read(queueProvider.notifier).skipNext();
        } else {
          state = state.copyWith(status: PlaybackStatus.completed);
        }
      } else {
        state = state.copyWith(status: PlaybackStatus.paused);
      }
    });

    if (_positionSub == null) {
      final positionStream =
          (_handler as dynamic).positionStream as Stream<Duration>;
      _positionSub = positionStream.listen((position) {
        state = state.copyWith(position: position);
      });
    }

    ref.listen(queueProvider, (prev, next) {
      final prevTrackId = prev?.currentItem?.track.id;
      final nextItem = next.currentItem;

      if (nextItem != null && nextItem.track.id != prevTrackId) {
        _playQueueItem(nextItem);
      }
    });
  }

  Future<void> _playQueueItem(QueueItem item, {bool isUserInitiated = false}) async {
    if (isUserInitiated && !_canControlPlayback) {
      state = state.copyWith(error: "Only the host can pick songs.");
      return; 
    }

    final currentRoom = ref.read(currentRoomProvider);
    final user = ref.read(userProvider).value;
    final isListener = currentRoom != null && currentRoom.hostUserId != user?.id;
    
    if (isListener) return;

    try {
      final audioStreamRepo = ref.read(streamRepositoryProvider);

      if(_isHost) {
        state = state.copyWith(status: PlaybackStatus.loading);

        final audioUrl = await audioStreamRepo.getStreamURL(
          item.track.artist,
          item.track.title,
          item.track.id,
        );

        final streamRepo = ref.read(playbackStreamServiceProvider);
        streamRepo.sendTrackChange(
          PlaybackTrackModel(
            id: item.track.id,
            title: item.track.title,
            artist: item.track.artist,
            audioUrl: audioUrl,
            artworkUrl: item.track.imageLarge,
            durationMs: item.track.durationMs,
          )
        );

        return;
      } 

      state = state.copyWith(status: PlaybackStatus.loading);

      final audioUrl = await audioStreamRepo.getStreamURL(
        item.track.artist,
        item.track.title,
        item.track.id,
      );

      final mediaItem = MediaItem(
        id: item.track.id,
        title: item.track.title,
        artist: item.track.artist,
        artUri: Uri.tryParse(item.track.imageLarge),
        duration: Duration(milliseconds: item.track.durationMs),
        extras: {'trackId': item.track.id, 'audioUrl': audioUrl},
      );

      await _handler.playMediaItem(mediaItem);  
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, error: e.toString());
    }
  }

  Future<void> play() async {
    if (!_canControlPlayback) {
      state = state.copyWith(error: "Only the host can resume playback.");
      return;
    }

    if (_isHost) {
      ref.read(playbackStreamServiceProvider).sendPlay();
    } else {
      await _handler.play();
    }
  }

  Future<void> pause() async {
    if (!_canControlPlayback) {
      state = state.copyWith(error: "Only the host can pause playback.");
      return;
    }

    if (_isHost) {
      ref.read(playbackStreamServiceProvider).sendPause();
    } else {
      await _handler.pause();
    }
  }

  Future<void> next() async {
    if (!_canControlPlayback) {
      state = state.copyWith(error: "Only the host can skip tracks.");
      return;
    }

    final notifier = ref.read(queueProvider.notifier);

    if (!ref.read(queueProvider).hasNext) return;
    notifier.skipNext();

    final item = ref.read(queueProvider).currentItem;
    if (item != null) {
      await _playQueueItem(item);
    }
  }

  Future<void> previous() async {
    if (!_canControlPlayback) {
      state = state.copyWith(error: "Only the host can skip tracks.");
      return;
    }

    final notifier = ref.read(queueProvider.notifier);

    if (!ref.read(queueProvider).hasPrevious) return;
    notifier.skipPrevious();

    final item = ref.read(queueProvider).currentItem;
    if (item != null) {
      await _playQueueItem(item);
    }
  }

  Future<void> syncRemoteTrack(QueueItem incomingTrack) async {
    await _playQueueItem(incomingTrack, isUserInitiated: false);
  }
}

final playerProvider = NotifierProvider<PlaybackNotifier, PlayerState>(
  PlaybackNotifier.new,
);
