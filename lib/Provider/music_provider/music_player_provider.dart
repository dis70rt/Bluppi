import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:synqit/Data/Models/last_track_model.dart';
import 'music_player_state.dart';

final audioPlayer = AudioPlayer();
final ytExplode = YoutubeExplode();

final musicPlayerProvider =
    StateNotifierProvider.autoDispose<MusicPlayerNotifier, MusicPlayerState>(
        (ref) {
  final notifier = MusicPlayerNotifier(audioPlayer, ytExplode);

  ref.onDispose(() {
    audioPlayer.stop();
  });
  return notifier;
});

class MusicPlayerNotifier extends StateNotifier<MusicPlayerState> {
  final AudioPlayer _audioPlayer;
  final YoutubeExplode _ytExplode;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;

  LastTrack? _intendedTrack;

  MusicPlayerNotifier(this._audioPlayer, this._ytExplode)
      : super(const MusicPlayerState()) {
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      PlayerStatus newStatus = state.status;

      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        if (state.status != PlayerStatus.loading) {
          newStatus = PlayerStatus.loading;
        }
      } else if (processingState == ProcessingState.ready) {
        newStatus = isPlaying ? PlayerStatus.playing : PlayerStatus.paused;

        if (state.status == PlayerStatus.loading) {
          state = state.copyWith(status: newStatus, clearError: true);
        } else {
          state = state.copyWith(status: newStatus);
        }
      } else if (processingState == ProcessingState.completed) {
        newStatus = PlayerStatus.completed;

        state = state.copyWith(status: newStatus, position: Duration.zero);
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      } else if (processingState == ProcessingState.idle) {
        if (state.status != PlayerStatus.error &&
            state.status != PlayerStatus.completed) {
          newStatus = PlayerStatus.initial;
          state = state.copyWith(
              status: newStatus,
              currentTrack: null,
              duration: null,
              position: Duration.zero,
              bufferedPosition: Duration.zero);
        }
      }

      if (state.status != newStatus && state.status != PlayerStatus.loading) {
        state = state.copyWith(status: newStatus);
      }
    }, onError: (Object e, StackTrace stackTrace) {
      log("Player State Stream Error: $e");
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Playback error: ${e.toString()}");
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (!state.isSeeking) {
        state = state.copyWith(position: position);
      }
    });

    _bufferedPositionSubscription =
        _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      state = state.copyWith(bufferedPosition: bufferedPosition);
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      state = state.copyWith(duration: duration);
    });
  }

  Future<void> loadTrack(LastTrack track) async {
    if (state.isLoading || _intendedTrack == track) {
      if (_intendedTrack == track &&
          (state.status == PlayerStatus.paused ||
              state.status == PlayerStatus.completed)) {
        play();
        return;
      }
      if (state.isLoading) return;
    }

    _intendedTrack = track;
    state = state.copyWith(
      status: PlayerStatus.loading,
      currentTrack: track,
      position: Duration.zero,
      bufferedPosition: Duration.zero,
      duration: null,
      clearError: true,
    );

    try {
      await _audioPlayer.stop();

      final query = "${track.artist.name} - ${track.name} music";
      log("Searching YouTube for: $query");
      final searchResults = await _ytExplode.search.search(query);

      if (searchResults.isEmpty) {
        throw Exception("No YouTube results found for '$query'");
      }

      final video = searchResults.first;
      log("Found video: ${video.title} (ID: ${video.id})");

      final manifest =
          await _ytExplode.videos.streamsClient.getManifest(video.id);
      final audioStreams = manifest.audioOnly.sortByBitrate();

      log("Available audio streams: $audioStreams");

      if (audioStreams.isEmpty) {
        throw Exception("No audio-only streams found for this video.");
      }

      // final _random = math.Random();
      // final audioStreamInfo = audioStreams[_random.nextInt(audioStreams.length)];

      final audioStreamInfo = audioStreams.first;
      log(
          "Selected audio stream: ${audioStreamInfo.codec} / ${audioStreamInfo.bitrate}");

      await _audioPlayer.setUrl(audioStreamInfo.url.toString());

      play();
    } on VideoUnplayableException catch (e) {
      log("Error: Video is unplayable: $e");
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: 'This video is unplayable or restricted.');
      _intendedTrack = null;
    } catch (e, stackTrace) {
      log("Error loading track: $e\n$stackTrace");
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Failed to load track: ${e.toString()}");
      _intendedTrack = null;
    }
  }

  Future<void> play() async {
    if (state.status != PlayerStatus.loading) {
      try {
        await _audioPlayer.play();
      } catch (e) {
        log("Error playing: $e");
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Error starting playback.");
      }
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      log("Error pausing: $e");
    }
  }

  Future<void> seek(Duration position) async {
    state = state.copyWith(isSeeking: true);
    try {
      await _audioPlayer.seek(position);

      state = state.copyWith(position: position, isSeeking: false);
    } catch (e) {
      log("Error seeking: $e");
      state = state.copyWith(isSeeking: false);
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      state =
          state.copyWith(status: PlayerStatus.initial, position: Duration.zero);
      _intendedTrack = null;
    } catch (e) {
      log("Error stopping: $e");
    }
  }

  @override
  void dispose() {
    log('Disposing MusicPlayerNotifier');
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _bufferedPositionSubscription?.cancel();
    _durationSubscription?.cancel();

    super.dispose();
  }
}
