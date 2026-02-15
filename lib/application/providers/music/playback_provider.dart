import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bluppi/domain/models/track_model.dart';
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
  final List<TrackModel> queue;
  final int currentIndex;
  final PlaybackStatus status;
  final String? error;
  final Duration position;

  TrackModel? get currentTrack => queue.isEmpty ? null : queue[currentIndex];

  const PlayerState({
    required this.queue,
    required this.currentIndex,
    required this.status,
    this.error,
    this.position = Duration.zero,
  });

  PlayerState copyWith({
    List<TrackModel>? queue,
    int? currentIndex,
    PlaybackStatus? status,
    String? error,
    Duration? position,
  }) {
    return PlayerState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      status: status ?? this.status,
      error: error,
      position: position ?? this.position,
    );
  }
}

class PlaybackNotifier extends Notifier<PlayerState> {
  AudioHandler get _handler => audioHandler;
  StreamSubscription<Duration>? _positionSub;

  @override
  PlayerState build() {
    _listen();
    ref.onDispose(() {
      _positionSub?.cancel();
    });
    return const PlayerState(
      queue: [],
      currentIndex: 0,
      status: PlaybackStatus.idle,
    );
  }

  void _listen() {
    _handler.playbackState.listen((ps) {
      if (ps.processingState == AudioProcessingState.loading) {
        state = state.copyWith(status: PlaybackStatus.loading);
      } else if (ps.processingState == AudioProcessingState.buffering) {
        state = state.copyWith(status: PlaybackStatus.buffering);
      } else if (ps.playing) {
        state = state.copyWith(status: PlaybackStatus.playing);
      } else {
        state = state.copyWith(status: PlaybackStatus.paused);
      }
    });

    _handler.mediaItem.listen((mediaItem) {
      if (mediaItem == null) return;

      final track = TrackModel(
        id: mediaItem.extras?['trackId'] ?? mediaItem.id,
        title: mediaItem.title,
        artist: mediaItem.artist ?? '',
        imageLarge: mediaItem.artUri.toString(),
        previewUrl: mediaItem.extras?['audioUrl'] ?? mediaItem.id,
        durationMs: mediaItem.duration?.inMilliseconds ?? 0,
        genres: [],
        imageSmall: '',
        videoId: '',
        listeners: 0,
        playCount: 0,
        popularity: 0,
        createdAt: DateTime.now(),
      );

      state = state.copyWith(queue: [track], currentIndex: 0);
    });
    if (_positionSub == null) {
      final positionStream = (_handler as dynamic).positionStream as Stream<Duration>;
      _positionSub = positionStream.listen((position) {
        state = state.copyWith(position: position);
      });
    }
  }

  Future<void> play() => _handler.play();
  Future<void> pause() => _handler.pause();
  Future<void> next() => _handler.skipToNext();
  Future<void> previous() => _handler.skipToPrevious();
}

final playerProvider = NotifierProvider<PlaybackNotifier, PlayerState>(
  PlaybackNotifier.new,
);
