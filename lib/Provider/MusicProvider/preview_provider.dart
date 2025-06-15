import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

enum AudioPlaybackState { initial, loading, playing, paused, completed, error }

class PlayerState extends Equatable {
  final AudioPlaybackState playbackState;
  final String? currentUrl;
  final String? errorMessage;

  const PlayerState({
    this.playbackState = AudioPlaybackState.initial,
    this.currentUrl,
    this.errorMessage,
  });

  PlayerState copyWith({
    AudioPlaybackState? playbackState,
    String? currentUrl,
    String? errorMessage,
    bool clearUrl = false,
    bool clearError = false,
  }) {
    return PlayerState(
      playbackState: playbackState ?? this.playbackState,
      currentUrl: clearUrl ? null : currentUrl ?? this.currentUrl,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [playbackState, currentUrl, errorMessage];
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  final AudioPlayer _audioPlayer;
  StreamSubscription? _playerStateSubscription;

  PlayerNotifier()
      : _audioPlayer = AudioPlayer(),
        super(const PlayerState()) {
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      AudioPlaybackState newPlaybackState = state.playbackState;

      switch (processingState) {
        case ProcessingState.idle:
          if (state.currentUrl != null) {
            newPlaybackState = AudioPlaybackState.initial;
          } else {
            newPlaybackState = AudioPlaybackState.initial;
          }
          break;
        case ProcessingState.loading:
          newPlaybackState = AudioPlaybackState.loading;
          break;
        case ProcessingState.buffering:
          newPlaybackState = AudioPlaybackState.loading;
          break;
        case ProcessingState.ready:
          newPlaybackState = isPlaying
              ? AudioPlaybackState.playing
              : AudioPlaybackState.paused;
          break;
        case ProcessingState.completed:
          newPlaybackState = AudioPlaybackState.completed;

          _stopPlayback(clearUrl: false);
          break;
      }

      if (mounted && newPlaybackState != state.playbackState) {
        state =
            state.copyWith(playbackState: newPlaybackState, clearError: true);
      }
    }, onError: (error, stackTrace) {
      log("Audio Player Error: $error");
      if (mounted) {
        state = state.copyWith(
            playbackState: AudioPlaybackState.error,
            errorMessage: error.toString(),
            clearUrl: true);
        _audioPlayer.stop();
      }
    });
  }

  Future<void> play(String url) async {
    if (url.isEmpty) return;

    if (_audioPlayer.playing && state.currentUrl == url) {
      await pause();
      return;
    }

    if (state.currentUrl != null && state.currentUrl != url) {
      await _stopPlayback();
    }

    if (mounted) {
      state = state.copyWith(
        currentUrl: url,
        playbackState: AudioPlaybackState.loading,
        clearError: true,
      );
    }

    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      log("Error setting URL or playing: $e");
      if (mounted) {
        state = state.copyWith(
          playbackState: AudioPlaybackState.error,
          errorMessage: "Failed to play preview: ${e.toString()}",
          clearUrl: true,
        );
      }
      await _stopPlayback();
    }
  }

  Future<void> pause() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    }
  }

  Future<void> _stopPlayback({bool clearUrl = true}) async {
    await _audioPlayer.stop();
    if (mounted) {
      state = state.copyWith(
        playbackState: AudioPlaybackState.initial,
        clearUrl: clearUrl,
      );
    }
  }

  @override
  void dispose() {
    log("Disposing PlayerNotifier");
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}

final playerNotifierProvider =
    StateNotifierProvider<PlayerNotifier, PlayerState>((ref) {
  log("Creating PlayerNotifier Provider");
  final notifier = PlayerNotifier();

  return notifier;
});
