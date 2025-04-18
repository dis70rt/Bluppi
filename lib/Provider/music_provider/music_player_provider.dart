import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';
import 'package:synqit/Provider/music_provider/current_track_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:synqit/Data/Models/current_track_model.dart';
import 'music_player_state.dart';

final audioPlayer = AudioPlayer();
final ytExplode = YoutubeExplode();

final musicPlayerProvider =
    StateNotifierProvider.autoDispose<MusicPlayerNotifier, MusicPlayerState>(
        (ref) {
  log('[MusicPlayerProvider] Creating MusicPlayerNotifier instance.');
  final notifier = MusicPlayerNotifier(ref, audioPlayer, ytExplode);

  ref.onDispose(() {
    log("[MusicPlayerProvider] Disposing provider scope for MusicPlayerNotifier.");
  });
  return notifier;
});

class MusicPlayerNotifier extends StateNotifier<MusicPlayerState> {
  final Ref _ref;
  final AudioPlayer _audioPlayer;
  final YoutubeExplode _ytExplode;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;

  MusicPlayerNotifier(this._ref, this._audioPlayer, this._ytExplode)
      : super(const MusicPlayerState()) {
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    log('[MusicPlayerNotifier] Subscribing to player streams.');
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      if (!mounted) return;

      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      PlayerStatus currentStatus = state.status;
      PlayerStatus newStatus = currentStatus;

      switch (processingState) {
        case ProcessingState.idle:
          if (currentStatus != PlayerStatus.error &&
              currentStatus != PlayerStatus.completed &&
              currentStatus != PlayerStatus.initial) {
            newStatus = PlayerStatus.initial;
            if (!mounted) return;
            state = state.copyWith(
                status: newStatus,
                position: Duration.zero,
                bufferedPosition: Duration.zero,
                clearDuration: true,
                clearError: true);
          }
          break;

        case ProcessingState.loading:
        case ProcessingState.buffering:
          newStatus = PlayerStatus.loading;
          if (currentStatus != newStatus) {
            if (!mounted) return;
            state = state.copyWith(status: newStatus, clearError: true);
          }
          break;

        case ProcessingState.ready:
          newStatus = isPlaying ? PlayerStatus.playing : PlayerStatus.paused;
          if (currentStatus != newStatus) {
            if (!mounted) return;
            state = state.copyWith(
                status: newStatus,
                clearError: currentStatus == PlayerStatus.loading);
          }
          break;

        case ProcessingState.completed:
          newStatus = PlayerStatus.completed;
          if (currentStatus != newStatus) {
            if (!mounted) return;

            final endPosition = state.duration ?? Duration.zero;
            state = state.copyWith(status: newStatus, position: endPosition);
          }
          break;
      }

      if (currentStatus != newStatus) {
        log("[MusicPlayerNotifier] State Changed: $currentStatus -> $newStatus");
      }
    }, onError: (Object e, StackTrace stackTrace) {
      if (!mounted) return;
      log("[MusicPlayerNotifier] Player State Stream Error: $e",
          error: e, stackTrace: stackTrace);
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Playback error: ${e.toString()}");
      if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
    });

    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (!mounted) return;
      if (!state.isSeeking &&
          (state.status == PlayerStatus.playing ||
              state.status == PlayerStatus.paused)) {
        state = state.copyWith(position: position);
      }
    });

    _bufferedPositionSubscription =
        _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      if (!mounted) return;
      state = state.copyWith(bufferedPosition: bufferedPosition);
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (!mounted) return;
      if (duration != null &&
          duration > Duration.zero &&
          state.duration != duration) {
        log("[MusicPlayerNotifier] Duration updated: $duration");
        state = state.copyWith(duration: duration);
      }
    });
  }

  Future<void> loadTrack(Track track) async {
    log("[MusicPlayerNotifier] loadTrack called for: '${track.trackName}' by '${track.artistName}'");
    final initialTrackData = CurrentTrack(
        name: track.trackName,
        artistName: track.trackName,
        thumbnailUrl: track.imageUrl);

    final currentIntendedTrack = _ref.read(currentTrackProvider);
    if (currentIntendedTrack == initialTrackData) {
      log("[MusicPlayerNotifier] Track '${track.trackName}' is already the current/intended track.");
      if (state.status == PlayerStatus.paused ||
          state.status == PlayerStatus.completed) {
        log("[MusicPlayerNotifier] Resuming playback for '${track.trackName}'.");
        await play();
        return;
      }
      if (state.isLoading || state.isPlaying) {
        log("[MusicPlayerNotifier] Already loading or playing '${track.trackName}'. Ignoring request.");
        return;
      }
      if (state.status == PlayerStatus.error) {
        log("[MusicPlayerNotifier] Track '${track.trackName}' is in error state. Allowing reload attempt.");
      } else {
        log("[MusicPlayerNotifier] Track '${track.trackName}' matches but state is ${state.status}. Ignoring.");
        return;
      }
    }

    if (!mounted) {
      log("[MusicPlayerNotifier] loadTrack aborted: Notifier is not mounted.");
      return;
    }

    log("[MusicPlayerNotifier] Setting current track provider and player state to loading for '${track.trackName}'.");
    _ref.read(currentTrackProvider.notifier).state = initialTrackData;
    state = state.copyWith(
      status: PlayerStatus.loading,
      position: Duration.zero,
      bufferedPosition: Duration.zero,
      clearDuration: true,
      clearError: true,
    );

    try {
      log("[MusicPlayerNotifier] Stopping current playback if any...");
      await _audioPlayer.stop();

      final query = "${track.artistName} - ${track.trackName} Official";
      log("[MusicPlayerNotifier] Searching YouTube for: '$query'");
      final searchResults = await _ytExplode.search.search(query);

      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted after YT search: Notifier disposed.");
        return;
      }

      if (searchResults.isEmpty) {
        throw Exception("No YouTube results found for '$query'");
      }

      final video = searchResults.first;
      log("[MusicPlayerNotifier] Found YouTube video: ${video.title} (ID: ${video.id})");

      final definitiveTrackData = CurrentTrack(
        name: track.trackName,
        artistName: track.artistName,
        youtubeVideoId: video.id.value,
        thumbnailUrl: track.imageUrl,
      );

      final db = Database();
      final postTrack = track.copyWith(ytUrl: video.url);
      await db.writeTrack(postTrack, video.duration?.inSeconds);

      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted before updating provider with details: Notifier disposed.");
        return;
      }
      _ref.read(currentTrackProvider.notifier).state = definitiveTrackData;
      log("[MusicPlayerNotifier] Updated currentTrackProvider with details: $definitiveTrackData");

      log("[MusicPlayerNotifier] Fetching audio stream manifest...");
      // final manifest =
      //     await _ytExplode.videos.streamsClient.getManifest(video.id);

      final manifest = await _ytExplode.videos.streamsClient.getManifest(VideoId(video.id.value));

      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted after fetching manifest: Notifier disposed.");
        return;
      }

      if (manifest.audioOnly.isEmpty) {
        throw Exception("No audio streams available for video ${video.id.value}");
      }

      final bestAudio = manifest.audioOnly.withHighestBitrate();

      final audioStreamInfo = manifest.audioOnly
              .where((s) =>
                  s.codec.mimeType == 'audio/mp4' ||
                  s.codec.mimeType == 'audio/webm')
              .sortByBitrate()
              .lastOrNull ??
          manifest.audioOnly.sortByBitrate().lastOrNull;

      if (audioStreamInfo == null) {
        throw Exception("No suitable audio-only streams found for this video.");
      }
      log("[MusicPlayerNotifier] Selected audio stream: Codec=${audioStreamInfo.codec}, Bitrate=${audioStreamInfo.bitrate}");

      log("[MusicPlayerNotifier] Setting audio source...");

      await _audioPlayer.setUrl(bestAudio.url.toString(),
          initialPosition: Duration.zero, preload: true);

      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted after setting source: Notifier disposed.");
        return;
      }

      log("[MusicPlayerNotifier] Audio source set. Initiating playback...");
      await play();
    } on VideoUnplayableException catch (e) {
      log("[MusicPlayerNotifier] loadTrack Error: Video is unplayable - $e");
      if (!mounted) return;
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: 'Video is unplayable/restricted.');
      if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
    } catch (e, stackTrace) {
      log("[MusicPlayerNotifier] loadTrack Error: Generic error - $e\n$stackTrace",
          error: e, stackTrace: stackTrace);
      if (!mounted) return;
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Failed to load track: ${e.toString()}");
      if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
    }
  }

  Future<void> play() async {
    if (!mounted) {
      log("[MusicPlayerNotifier] play aborted: Notifier not mounted.");
      return;
    }

    if (state.status == PlayerStatus.paused ||
        state.status == PlayerStatus.completed ||
        state.status == PlayerStatus.ready) {
      log("[MusicPlayerNotifier] Attempting to play audio...");
      try {
        await _audioPlayer.play();
        log("[MusicPlayerNotifier] Audio playback initiated via player.");
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.play(): $e",
            error: e, stackTrace: stackTrace);
        if (!mounted) return;
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Error starting playback.");
        if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
      }
    } else {
      log("[MusicPlayerNotifier] Play ignored: Current status is ${state.status}");
    }
  }

  Future<void> pause() async {
    if (!mounted) {
      log("[MusicPlayerNotifier] pause aborted: Notifier not mounted.");
      return;
    }

    if (state.isPlaying || state.status == PlayerStatus.loading) {
      log("[MusicPlayerNotifier] Attempting to pause audio...");
      try {
        await _audioPlayer.pause();
        log("[MusicPlayerNotifier] Audio pause initiated via player.");
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.pause(): $e",
            error: e, stackTrace: stackTrace);
      }
    } else {
      log("[MusicPlayerNotifier] Pause ignored: Status is ${state.status}");
    }
  }

  Future<void> seek(Duration position) async {
    if (!mounted) {
      log("[MusicPlayerNotifier] seek aborted: Notifier not mounted.");
      return;
    }

    if (state.duration != null &&
        state.duration! > Duration.zero &&
        (state.status == PlayerStatus.playing ||
            state.status == PlayerStatus.paused ||
            state.status == PlayerStatus.completed ||
            state.status == PlayerStatus.ready)) {
      final seekPosition = position.isNegative
          ? Duration.zero
          : (position > state.duration! ? state.duration! : position);
      log("[MusicPlayerNotifier] Seeking to: $seekPosition (Duration: ${state.duration})");

      state = state.copyWith(isSeeking: true, position: seekPosition);
      try {
        await _audioPlayer.seek(seekPosition);
        log("[MusicPlayerNotifier] Seek initiated via player.");

        if (mounted) state = state.copyWith(isSeeking: false);
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.seek(): $e",
            error: e, stackTrace: stackTrace);
        if (mounted) state = state.copyWith(isSeeking: false);
      }
    } else {
      log("[MusicPlayerNotifier] Seek ignored: Status is ${state.status} or duration is invalid (${state.duration})");
    }
  }

  Future<void> stop() async {
    if (!mounted) {
      log("[MusicPlayerNotifier] stop aborted: Notifier not mounted.");
      return;
    }
    log("[MusicPlayerNotifier] Stopping player.");
    try {
      await _audioPlayer.stop();
      log("[MusicPlayerNotifier] Player stop initiated.");
      if (!mounted) return;
      state = state.copyWith(
        status: PlayerStatus.initial,
        position: Duration.zero,
        bufferedPosition: Duration.zero,
        clearDuration: true,
        clearError: true,
      );
      if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
    } catch (e, stackTrace) {
      log("[MusicPlayerNotifier] Error stopping player: $e",
          error: e, stackTrace: stackTrace);
      if (mounted) {
        state = state.copyWith(
            status: PlayerStatus.initial,
            position: Duration.zero,
            clearError: true,
            clearDuration: true);
        _ref.read(currentTrackProvider.notifier).state = null;
      }
    }
  }

  void _cancelSubscriptions() {
    log('[MusicPlayerNotifier] Cancelling player stream subscriptions.');
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _bufferedPositionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription = null;
    _positionSubscription = null;
    _bufferedPositionSubscription = null;
    _durationSubscription = null;
  }

  @override
  void dispose() {
    log('[MusicPlayerNotifier] Disposing instance.');
    _cancelSubscriptions();

    super.dispose();
  }
}
