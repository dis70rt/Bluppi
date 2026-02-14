import 'package:bluppi/domain/models/track_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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

  TrackModel? get currentTrack => queue.isEmpty ? null : queue[currentIndex];

  const PlayerState({
    required this.queue,
    required this.currentIndex,
    required this.status,
    this.error,
  });

  PlayerState copyWith({
    List<TrackModel>? queue,
    int? currentIndex,
    PlaybackStatus? status,
    String? error,
  }) {
    return PlayerState(
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      status: status ?? this.status,
      error: error,
    );
  }
}

class PlaybackNotifier extends Notifier<PlayerState> {
  late final AudioPlayer _player;

  @override
  PlayerState build() {
    _player = AudioPlayer();

    _listenToEngine();
    return const PlayerState(
      queue: [],
      currentIndex: 0,
      status: PlaybackStatus.idle,
    );
  }

  void _listenToEngine() {
    _player.playerStateStream.listen((ps) {
      final processing = ps.processingState;

      if (processing == ProcessingState.loading) {
        state = state.copyWith(status: PlaybackStatus.loading);
      } else if (processing == ProcessingState.buffering) {
        state = state.copyWith(status: PlaybackStatus.buffering);
      } else if (processing == ProcessingState.completed) {
        state = state.copyWith(status: PlaybackStatus.completed);
      } else if (ps.playing) {
        state = state.copyWith(status: PlaybackStatus.playing);
      } else {
        state = state.copyWith(status: PlaybackStatus.paused);
      }
    });

    _player.currentIndexStream.listen((index) {
      if (index != null) {
        state = state.copyWith(currentIndex: index);
      }
    });
  }

  Future<void> setQueue(List<TrackModel> tracks, {int startIndex = 0}) async {
    state = state.copyWith(
      queue: tracks,
      currentIndex: startIndex,
      status: PlaybackStatus.loading,
    );

    final sources = tracks.map((track) {
      return AudioSource.uri(
        Uri.parse(track.previewUrl), // or resolved later
        tag: MediaItem(id: track.id, title: track.title, artist: track.artist),
      );
    }).toList();

    await _player.setAudioSource(
      ConcatenatingAudioSource(children: sources),
      initialIndex: startIndex,
    );
  }

  Future<void> playIndex(int index) async {
    try {
      state = state.copyWith(
        currentIndex: index,
        status: PlaybackStatus.loading,
      );

      await _player.seek(Duration.zero, index: index);
      await _player.play();
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, error: e.toString());
    }
  }

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> stop() => _player.stop();

  Future<void> next() async {
    if (_player.hasNext) await _player.seekToNext();
  }

  Future<void> previous() async {
    if (_player.hasPrevious) await _player.seekToPrevious();
  }
}

final playerProvider = NotifierProvider<PlaybackNotifier, PlayerState>(
  PlaybackNotifier.new,
);
