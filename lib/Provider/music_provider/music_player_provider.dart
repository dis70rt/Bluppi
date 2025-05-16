import 'dart:async';
import 'dart:developer';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';
import 'package:synqit/Data/Services/firebase_services.dart';
import 'package:synqit/Data/Services/api_services.dart';
import 'package:synqit/Data/Services/youtube_services.dart';
// Removed: import 'package:synqit/s/database_services.dart'; // Assuming not needed elsewhere now
import 'package:synqit/Provider/music_provider/current_track_provider.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:synqit/Data/Models/current_track_model.dart';
import 'package:synqit/Provider/music_provider/queue_provider.dart';
import 'music_player_state.dart';

final audioPlayer = AudioPlayer();
// final ytExplode = YoutubeExplode();

final musicPlayerProvider =
    StateNotifierProvider.autoDispose<MusicPlayerNotifier, MusicPlayerState>(
        (ref) {
  log('[MusicPlayerProvider] Creating MusicPlayerNotifier instance.');
  final notifier = MusicPlayerNotifier(ref, audioPlayer);

  ref.onDispose(() {
    log("[MusicPlayerProvider] Disposing provider scope for MusicPlayerNotifier.");
  });
  return notifier;
});

class MusicPlayerNotifier extends StateNotifier<MusicPlayerState> {
  final database = Database();
  final firebaseService = FirebaseServices();
  final apiServices = ApiServices();
  bool isHandlingCompletion = false;

  final Ref _ref;
  final AudioPlayer _audioPlayer;
  // final YoutubeExplode _ytExplode;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;

  MusicPlayerNotifier(this._ref, this._audioPlayer)
      : super(const MusicPlayerState()) {
    _listenToPlayerState();
  }

  void _listenToPlayerState() {
    log('[MusicPlayerNotifier] Subscribing to player streams.');
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) async {
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
            final endPosition = state.duration ?? Duration.zero;
            state = state.copyWith(status: newStatus, position: endPosition);

            if (!isHandlingCompletion) {
              isHandlingCompletion = true;
              try {
                await skipToNext();
              } catch (e) {
                log("[MusicPlayerNotifier] Error during skipToNext: $e");
              } finally {
                isHandlingCompletion = false;
              }
            }

            // final queue = _ref.read(queueProvider);
            // if (queue.next != null) {
            //   await skipToNext();
            // } else {
            //   final recs = await apiServices.getNextRecommendatedTrack(queue.current!);
            //   log("[MusicPlayerNotifier] Next recommended track: $recs");
            //   if (recs != null) {
            //     await loadTrack(recs);
            //     _ref.read(queueProvider.notifier).add(recs);
            //   } else {
            //     log("[MusicPlayerNotifier] No next track available.");
            //   }
            // }

            if (!mounted) return;
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
    log("[MusicPlayerNotifier] loadTrack called for: '${track.trackName}' by '${track.artistName}' with provided URL/ID: ${track.videoId}");

    state = state.copyWith(
      status: PlayerStatus.loading,
      position: Duration.zero,
      bufferedPosition: Duration.zero,
      clearDuration: true,
      clearError: true,
    );

    final currentIntendedTrack = _ref.read(currentTrackProvider);
    final potentialNewTrackData = CurrentTrack(
        name: track.trackName,
        artistName: track.artistName,
        thumbnailUrl: track.imageUrl,
        youtubeVideoId: track.videoId);

    if (currentIntendedTrack != null &&
            currentIntendedTrack.trackName == potentialNewTrackData.name &&
            currentIntendedTrack.artistName ==
                potentialNewTrackData.artistName &&
            currentIntendedTrack.videoId ==
                potentialNewTrackData.youtubeVideoId
        ) {
      log("[MusicPlayerNotifier] Track '${track.trackName}' (ID: ${potentialNewTrackData.youtubeVideoId}) is already the current/intended track.");
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

    // if (track.videoId == null || track.videoId!.isEmpty) {
    //    log("[MusicPlayerNotifier] loadTrack Error: Track is missing YouTube URL/ID.");
    //    state = state.copyWith(
    //        status: PlayerStatus.error,
    //        errorMessage: 'Track data is missing the required YouTube link.');
    //    _ref.read(currentTrackProvider.notifier).state = null;
    //    return;
    // }

    Map<String, dynamic> data;
    if (track.videoId != null && track.videoId!.isNotEmpty) {
      data = await getAudioStreamUrlByID(track.videoId!);
    } else {
      data =
          await getAudioStreamUrl("${track.trackName} - ${track.artistName}");
    }

    final videoId = data['videoId'] ?? track.videoId;
    final audioUrl = data['audioUrl'];
    final trackToQueue = track.copyWith(videoId: videoId);

    // try {
    //     if (videoId == null) {
    //       throw Exception("Could not parse Video ID from '${track.videoId}'.");
    //     }
    // } catch (e) {
    //      log("[MusicPlayerNotifier] loadTrack Error: Failed to parse Video ID - $e");
    //      if (!mounted) return;
    //      state = state.copyWith(
    //          status: PlayerStatus.error,
    //          errorMessage: "Invalid YouTube link provided: ${e.toString()}");
    //      _ref.read(currentTrackProvider.notifier).state = null;
    //      return;
    // }

    log("[MusicPlayerNotifier] Setting current track provider and player state to loading for '${track.trackName}' (ID: $videoId).");
    // final initialTrackData = CurrentTrack(
    //   name: track.trackName,
    //   artistName: track.artistName,
    //   thumbnailUrl: track.imageUrl,
    //   // youtubeVideoId: videoId,
    // );
    _ref.read(currentTrackProvider.notifier).state = track;

    try {
      log("[MusicPlayerNotifier] Stopping current playback if any...");
      await _audioPlayer.stop();

      _ref.read(queueProvider.notifier).playTrack(trackToQueue);

      final mediaItem = MediaItem(
        id: videoId ?? track.trackId ?? DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID (videoId is good)
        title: track.trackName,
        artist: track.artistName,
        artUri: Uri.parse(track.imageUrl),
        album: track.albumName,
        duration: state.duration,
        // You can add other details like album, genre, etc. here if available
        // duration: ... // just_audio often discovers this automatically
      );

      final audioSource = AudioSource.uri(
        Uri.parse(audioUrl), 
        tag: mediaItem,      
      );

      // final definitiveTrackData = CurrentTrack(
      //   name: track.trackName,
      //   artistName: track.artistName,
      //   youtubeVideoId: videoId,
      //   thumbnailUrl: track.imageUrl,
      // );
      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted before updating provider with details: Notifier disposed.");
        return;
      }
      _ref.read(currentTrackProvider.notifier).state = track;
      // log("[MusicPlayerNotifier] Updated currentTrackProvider with details: $definitiveTrackData");
      // final manifest = await _ytExplode.videos.streamsClient.getManifest(videoId);

      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted after fetching manifest: Notifier disposed.");
        return;
      }

      // final audioStreamInfo = manifest.audioOnly.withHighestBitrate();
      // log("[MusicPlayerNotifier] Selected audio stream: Codec=${audioStreamInfo.codec}, Bitrate=${audioStreamInfo.bitrate}, Size=${audioStreamInfo.size}");

      // log("[MusicPlayerNotifier] Setting audio source URL: ${audioStreamInfo.url}");

      // await _audioPlayer.setUrl(audioUrl,
      //     initialPosition: Duration.zero, preload: true);

      await _audioPlayer.setAudioSource(
        audioSource,
        initialPosition: Duration.zero,
        preload: true,
      );

      if (!mounted) {
        log("[MusicPlayerNotifier] loadTrack aborted after setting source: Notifier disposed.");
        return;
      }

      log("[MusicPlayerNotifier] Audio source set. Initiating playback...");
      await play();
      database.writeTrack(trackToQueue, state.duration?.inSeconds);
      firebaseService.writeLastPlayedTrack(track.trackId);
      firebaseService.historyTrack(track.trackId);
      // _ref.read(queueProvider.notifier).add(track);
    }
    // on VideoUnplayableException catch (e) {
    //   log("[MusicPlayerNotifier] loadTrack Error: Video is unplayable - $e");
    //   if (!mounted) return;
    //   state = state.copyWith(
    //       status: PlayerStatus.error,
    //       errorMessage: 'Video is unplayable/restricted.');
    //   if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
    // }
    catch (e, stackTrace) {
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
      // Added ready state
      final seekPosition = position.isNegative
          ? Duration.zero
          : (position > state.duration! ? state.duration! : position);
      log("[MusicPlayerNotifier] Seeking to: $seekPosition (Duration: ${state.duration})");

      // Optimistically update position while seeking
      state = state.copyWith(isSeeking: true, position: seekPosition);
      try {
        await _audioPlayer.seek(seekPosition);
        log("[MusicPlayerNotifier] Seek initiated via player.");
        // Position stream might update faster, isSeeking helps prevent jumps
        if (mounted) state = state.copyWith(isSeeking: false);
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.seek(): $e",
            error: e, stackTrace: stackTrace);
        if (mounted) {
          state = state.copyWith(isSeeking: false);
        }
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
      state = const MusicPlayerState();
      if (mounted) _ref.read(currentTrackProvider.notifier).state = null;
    } catch (e, stackTrace) {
      log("[MusicPlayerNotifier] Error stopping player: $e",
          error: e, stackTrace: stackTrace);
      if (mounted) {
        state = const MusicPlayerState();
        _ref.read(currentTrackProvider.notifier).state = null;
      }
    }
  }

  // Future<void> skipToNext() async {
  //   final queue = _ref.read(queueProvider);
  //   log("Is Current Track: ${queue.current?.trackName}");
  //   if (queue.next == null) {
  //     final recs = await apiServices.getNextRecommendedTrack(queue.current!.artistName, queue.current!.trackName);
  //     if (recs == null) {
  //       log("[MusicPlayerNotifier] No next recommended track available.");
  //       return;
  //     }
  //     await loadTrack(recs);
  //     _ref.read(queueProvider.notifier).add(recs);
  //     log("[MusicPlayerNotifier] Next recommended track: $recs");
  //     return;
  //   }
  //   final nextTrack = _ref.read(queueProvider.notifier).next();
  //   if (nextTrack != null) {
  //     log("[MusicPlayerNotifier] Skipping to next track: ${nextTrack.trackName}");
  //     await loadTrack(nextTrack);
  //   }
  // }

  Future<void> skipToNext() async {
    if (!mounted) return;
    if (isHandlingCompletion) return;
    isHandlingCompletion = true;

    try {
      final queueState = _ref.read(queueProvider);
      final current = queueState.current;
      log("Is Current Track: ${current?.trackName}");
      if (current == null) {
        log("[MusicPlayerNotifier] No current track to skip from.");

        if (state.status == PlayerStatus.completed) {
          await stop();
        }
        return;
      }

      final upcoming = queueState.next;
      if (upcoming != null) {
        log("[MusicPlayerNotifier] Skipping to next queued track: ${upcoming.trackName}");
        _ref.read(queueProvider.notifier).next();
        await loadTrack(upcoming);
        return;
      }

      log("[MusicPlayerNotifier] No next track in queue, fetching recommendation for ${current.trackName}");
      final rec = await apiServices.getNextRecommendedTrack(
        current.artistName,
        current.trackName,
      );

      if (rec == null) {
        log("[MusicPlayerNotifier] No next recommended track available. Stopping.");
        if (!mounted) return;
        await stop();
        return;
      }

      log("[MusicPlayerNotifier] Next recommended track found: ${rec.trackName}");

      _ref.read(queueProvider.notifier).playTrack(rec);
      await loadTrack(rec);
    } catch (e, stackTrace) {
      log("[MusicPlayerNotifier] Error during skipToNext: $e",
          error: e, stackTrace: stackTrace);

      if (!mounted) return;
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Failed to skip track: ${e.toString()}");
    } finally {
      isHandlingCompletion = false;
    }
  }

  Future<void> skipToPrevious() async {
    final prevTrack = _ref.read(queueProvider.notifier).previous();
    if (prevTrack != null) {
      await loadTrack(prevTrack);
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
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _bufferedPositionSubscription?.cancel();
    _durationSubscription?.cancel();
    _cancelSubscriptions();
    // audioPlayer.dispose();
    // ytExplode.close();
    super.dispose();
  }
}
