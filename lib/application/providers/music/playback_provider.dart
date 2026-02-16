import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/music/stream_provider.dart';
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

  Future<void> _playQueueItem(QueueItem item) async {
    state = state.copyWith(status: PlaybackStatus.loading);

    try {
      final streamRepo = ref.read(streamRepositoryProvider);

      final audioUrl = await streamRepo.getStreamURL(
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

  Future<void> play() => _handler.play();
  Future<void> pause() => _handler.pause();

  Future<void> next() async {
    final notifier = ref.read(queueProvider.notifier);

    if (!ref.read(queueProvider).hasNext) return;
    notifier.skipNext();

    final item = ref.read(queueProvider).currentItem;
    if (item != null) {
      await _playQueueItem(item);
    }
  }

  Future<void> previous() async {
    final notifier = ref.read(queueProvider.notifier);

    if (!ref.read(queueProvider).hasPrevious) return;
    notifier.skipPrevious();

    final item = ref.read(queueProvider).currentItem;
    if (item != null) {
      await _playQueueItem(item);
    }
  }
}

final playerProvider = NotifierProvider<PlaybackNotifier, PlayerState>(
  PlaybackNotifier.new,
);
