import 'dart:async';
import 'dart:developer';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Data/Services/api_services.dart';
import 'package:synqit/Provider/music_provider/audio_streaming_provider.dart';
import 'package:synqit/Provider/music_provider/queue_provider.dart';
import 'package:synqit/Provider/music_provider/current_track_provider.dart';
import 'music_player_state.dart';

final databaseProvider = Provider<Database>((ref) => Database());
final userServices = Provider<UserServices>((ref) => UserServices());

final audioPlayer = AudioPlayer();

final musicPlayerProvider =
    StateNotifierProvider.autoDispose<MusicPlayerNotifier, MusicPlayerState>(
        (ref) {
  log('[MusicPlayerProvider] Creating MusicPlayerNotifier instance.');
  final notifier = MusicPlayerNotifier(
    ref,
    audioPlayer,
    ref.watch(audioStreamingServiceProvider),
    ApiServices(),
    Database(),
    UserServices(),
  );

  ref.onDispose(() {
    log("[MusicPlayerProvider] Disposing provider scope for MusicPlayerNotifier.");
    notifier._cancelSubscriptions();
  });

  return notifier;
});

class MusicPlayerNotifier extends StateNotifier<MusicPlayerState> {
  final Database _database;
  final UserServices _userServices;
  final ApiServices _apiServices;
  final AudioStreamingService _streamingService;

  bool _isPrefetchingRecommendation = false;

  final Ref _ref;
  final AudioPlayer _audioPlayer;
  ConcatenatingAudioSource? _currentPlaylistSource;

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerIndexSubscription;

  bool _isFetchingRecommendation = false;

  MusicPlayerNotifier(
    this._ref,
    this._audioPlayer,
    this._streamingService,
    this._apiServices,
    this._database,
    this._userServices,
  ) : super(const MusicPlayerState()) {
    log('[MusicPlayerNotifier] Initializing.');
    _listenToPlayerState();
    _listenToPlayerIndex();
    _listenToQueueChanges();
    _listenToPosition();
    _listenToBufferedPosition();
    _listenToDuration();

    final initialQueue = _ref.read(queueProvider);
    if (initialQueue.items.isNotEmpty) {
      log('[MusicPlayerNotifier] Initializing with existing queue items.');
      Future.microtask(() => _updatePlayerPlaylist(
          initialQueue.items, initialQueue.currentIndex,
          shouldPlay: false));
    }
  }

  void _listenToPosition() {
    log('[MusicPlayerNotifier] Subscribing to position stream.');
    _positionSubscription = _audioPlayer.positionStream.listen(
      (position) {
        if (!mounted) return;
        state = state.copyWith(position: position);
      },
    );
  }

  void _listenToBufferedPosition() {
    log('[MusicPlayerNotifier] Subscribing to buffered position stream.');
    _bufferedPositionSubscription = _audioPlayer.bufferedPositionStream.listen(
      (bufferedPosition) {
        if (!mounted) return;
        state = state.copyWith(bufferedPosition: bufferedPosition);
      },
    );
  }

  void _listenToDuration() {
    log('[MusicPlayerNotifier] Subscribing to duration stream.');
    _durationSubscription = _audioPlayer.durationStream.listen(
      (duration) {
        if (!mounted) return;
        if (duration != null) {
          log('[MusicPlayerNotifier] Duration updated: $duration');
          state = state.copyWith(duration: duration);

          if (state.status == PlayerStatus.loading &&
              _audioPlayer.processingState == ProcessingState.ready) {
            state = state.copyWith(
                status: _audioPlayer.playing
                    ? PlayerStatus.playing
                    : PlayerStatus.paused);
          }
        }
      },
    );
  }

  void _listenToPlayerState() {
    log('[MusicPlayerNotifier] Subscribing to player state stream.');
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) async {
      if (!mounted) return;

      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      PlayerStatus currentStatus = state.status;
      PlayerStatus newStatus = currentStatus;

      if (processingState == ProcessingState.ready && isPlaying) {
        _checkAndPrefetchNextTrack();
      }

      switch (processingState) {
        case ProcessingState.idle:
          if (currentStatus != PlayerStatus.error &&
              currentStatus != PlayerStatus.completed &&
              currentStatus != PlayerStatus.initial) {
            newStatus = PlayerStatus.initial;
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
            state = state.copyWith(status: newStatus, clearError: true);
          }
          break;

        case ProcessingState.ready:
          newStatus = isPlaying ? PlayerStatus.playing : PlayerStatus.paused;
          if (currentStatus != newStatus) {
            state = state.copyWith(
                status: newStatus,
                clearError: currentStatus == PlayerStatus.loading);
          }
          break;

        case ProcessingState.completed:
          log("[MusicPlayerNotifier] Player state: completed");
          newStatus = PlayerStatus.completed;
          if (currentStatus != newStatus) {
            final endPosition = state.duration ?? Duration.zero;
            state = state.copyWith(status: newStatus, position: endPosition);

            // final isLastTrackInPlayer = (_audioPlayer.currentIndex != null &&
            //     _currentPlaylistSource != null &&
            //     _audioPlayer.currentIndex ==
            //         _currentPlaylistSource!.children.length - 1);

            // final queue = _ref.read(queueProvider);
            // if (isLastTrackInPlayer || queue.items.isEmpty) {
            //   log("[MusicPlayerNotifier] Player completed last track in source or queue is empty. Attempting recommendation.");

            //   await skipToNext();
            // }

            await skipToNext();
          }
          break;
      }

      if (currentStatus != newStatus) {
        log("[MusicPlayerNotifier] Player Status Changed: $currentStatus -> $newStatus (Playing: $isPlaying, Processing: $processingState)");
      }
    }, onError: (Object e, StackTrace stackTrace) {
      if (!mounted) return;
      log("[MusicPlayerNotifier] Player State Stream Error: $e",
          error: e, stackTrace: stackTrace);
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Playback error: ${e.toString()}");

      _ref.read(currentTrackProvider.notifier).state = null;
      _ref.read(queueProvider.notifier).syncIndex(-1);
    });
  }

  Future<void> _checkAndPrefetchNextTrack() async {
    if (!mounted) return;
    
    final queueState = _ref.read(queueProvider);
    final hasUserAddedNext = queueState.currentIndex + 1 < queueState.items.length && 
                            !queueState.autoRecommendedIndices.contains(queueState.currentIndex + 1);
                            
    if (hasUserAddedNext || _isPrefetchingRecommendation) {
      return;
    }
    
    final shouldPrefetch = queueState.currentIndex == queueState.items.length - 1 ||
                          (queueState.currentIndex + 1 < queueState.items.length && 
                           queueState.autoRecommendedIndices.contains(queueState.currentIndex + 1));
                           
    if (shouldPrefetch) {
      _prefetchNextRecommendation();
    }
  }

  Future<void> _prefetchNextRecommendation() async {
    if (_isPrefetchingRecommendation || !mounted) return;
    
    _isPrefetchingRecommendation = true;
    log("[MusicPlayerNotifier] Started prefetching next recommendation in background");
    
    try {
      final currentTrack = _ref.read(currentTrackProvider);
      if (currentTrack == null) return;
      
      final rec = await _apiServices.getNextRecommendedTrack(
        currentTrack.artistName,
        currentTrack.trackName,
      );
      
      if (!mounted) return;
      
      if (rec != null) {
        log("[MusicPlayerNotifier] Background prefetch successful: ${rec.trackName}");
        
        _ref.read(queueProvider.notifier).addRecommendation(rec);
        
        if (_currentPlaylistSource != null) {
          await _addTrackToExistingPlaylist(rec);
        }
      }
    } catch (e) {
      log("[MusicPlayerNotifier] Error prefetching recommendation: $e", error: e);
    } finally {
      _isPrefetchingRecommendation = false;
    }
  }

  void _listenToPlayerIndex() {
    log('[MusicPlayerNotifier] Subscribing to player index stream.');
    _playerIndexSubscription =
        _audioPlayer.currentIndexStream.listen((index) async {
      if (!mounted) return;

      log("[MusicPlayerNotifier] Player index changed to: $index");

      final queueNotifier = _ref.read(queueProvider.notifier);
      final queueState = queueNotifier.state;

      if (index != null) {
        queueNotifier.syncIndex(index);

        if (index >= 0 && index < queueState.items.length) {
          final track = queueState.items[index];
          _ref.read(currentTrackProvider.notifier).state = track;
          log("[MusicPlayerNotifier] Synced current track provider to: ${track.trackName} at index $index.");

          _database.writeTrack(track, state.duration?.inSeconds);
          _userServices.historyTrack(track.trackId);
        } else {
          _ref.read(currentTrackProvider.notifier).state = null;
          log("[MusicPlayerNotifier] Player index indicates no current track.");
        }
      } else {
        log("[MusicPlayerNotifier] Received null index from currentIndexStream, skipping sync.");
      }
    });
  }

  void _listenToQueueChanges() {
    log('[MusicPlayerNotifier] Subscribing to queue changes.');

    _ref.listen<QueueState>(queueProvider, (previous, next) async {
      if (!mounted) return;

      final itemsChanged = previous?.items != next.items;
      final indexChanged = previous?.currentIndex != next.currentIndex;
      final wasPlaying =
          state.isPlaying || state.status == PlayerStatus.loading;

      log("[MusicPlayerNotifier] Queue listener triggered. Items changed: $itemsChanged, Index changed: $indexChanged. New Queue Index: ${next.currentIndex}, Player Index: ${_audioPlayer.currentIndex}");

      bool isJustAddingToEnd = false;
      if (itemsChanged &&
          previous != null &&
          previous.items.isNotEmpty &&
          next.items.isNotEmpty &&
          previous.currentIndex == next.currentIndex &&
          next.items.length > previous.items.length) {
        isJustAddingToEnd = true;
        for (int i = 0; i < previous.items.length; i++) {
          if (previous.items[i].trackId != next.items[i].trackId) {
            isJustAddingToEnd = false;
            break;
          }
        }
      }

      if (isJustAddingToEnd) {
        log("[MusicPlayerNotifier] Only adding tracks to the end of queue. Not resetting player.");

        if (_currentPlaylistSource != null) {
          for (int i = previous!.items.length; i < next.items.length; i++) {
            await _addTrackToExistingPlaylist(next.items[i]);
          }
        }
        return;
      }

      bool shouldUpdateSource = false;

      if (previous == null || previous.items.isEmpty) {
        shouldUpdateSource = true;
        log("[MusicPlayerNotifier] Initial queue population. Triggering player playlist update.");
      } else if (indexChanged &&
          next.currentIndex != _audioPlayer.currentIndex) {
        shouldUpdateSource = true;
        log("[MusicPlayerNotifier] Queue index changed (${next.currentIndex}) and player index differs (${_audioPlayer.currentIndex}). Triggering player playlist update.");
      } else if (itemsChanged &&
          previous.items.isNotEmpty &&
          next.items.isNotEmpty &&
          (previous.items[0].trackId != next.items[0].trackId ||
              previous.currentIndex != next.currentIndex)) {
        shouldUpdateSource = true;
        log("[MusicPlayerNotifier] Queue items order changed significantly. Triggering player playlist update.");
      }

      if (shouldUpdateSource) {
        await _updatePlayerPlaylist(next.items, next.currentIndex,
            shouldPlay: wasPlaying);
      }
    }, fireImmediately: true);
  }

  Future<void> _addTrackToExistingPlaylist(Track track) async {
    if (!mounted || _currentPlaylistSource == null) return;

    try {
      final streamData = await _streamingService.getAudioStreamData(track);
      final audioUrl = streamData['audioUrl'];

      if (audioUrl != null) {
        final mediaItem = MediaItem(
          id: track.trackId.toString(),
          title: track.trackName,
          artist: track.artistName,
          artUri: Uri.tryParse(track.imageUrl),
          album: track.albumName,
        );

        final audioSource =
            AudioSource.uri(Uri.parse(audioUrl), tag: mediaItem);
        await _currentPlaylistSource!.add(audioSource);
        log("[MusicPlayerNotifier] Added track '${track.trackName}' to existing playlist without reset.");
      }
    } catch (e, st) {
      log("[MusicPlayerNotifier] Failed to add track to existing playlist: $e",
          error: e, stackTrace: st);
    }
  }

  Future<void> _updatePlayerPlaylist(List<Track> items, int initialIndex,
      {bool shouldPlay = true}) async {
    if (!mounted) return;
    log("[MusicPlayerNotifier] _updatePlayerPlaylist called with ${items.length} items, initial index $initialIndex, shouldPlay: $shouldPlay.");

    await _audioPlayer.stop();
    log("[MusicPlayerNotifier] Player stopped for playlist update.");

    final List<AudioSource> sources = [];
    for (final track in items) {
      if (!mounted) return;

      try {
        final streamData = await _streamingService.getAudioStreamData(track);
        final audioUrl = streamData['audioUrl'];

        if (audioUrl != null) {
          final mediaItem = MediaItem(
            id: track.trackId.toString(),
            title: track.trackName,
            artist: track.artistName,
            artUri: Uri.tryParse(track.imageUrl),
            album: track.albumName,
          );
          sources.add(AudioSource.uri(Uri.parse(audioUrl), tag: mediaItem));
          log("[MusicPlayerNotifier] Successfully created AudioSource for '${track.trackName}'.");
        } else {
          log("[MusicPlayerNotifier] Skipping track '${track.trackName}' due to missing audio URL.");
        }
      } catch (e, st) {
        log("[MusicPlayerNotifier] Failed to create AudioSource for '${track.trackName}': $e",
            error: e, stackTrace: st);
        if (!mounted) return;
      }
    }

    if (!mounted) return;

    _currentPlaylistSource = ConcatenatingAudioSource(children: sources);

    try {
      log("[MusicPlayerNotifier] Setting new ConcatenatingAudioSource with ${sources.length} items.");

      await _audioPlayer.stop();

      final effectiveInitialIndex =
          initialIndex >= 0 && initialIndex < sources.length
              ? initialIndex
              : (sources.isNotEmpty ? 0 : -1);

      if (sources.isEmpty) {
        log("[MusicPlayerNotifier] Playlist is empty. Setting empty source.");
        await _audioPlayer.setAudioSource(
          ConcatenatingAudioSource(children: []),
          preload: false,
        );
        log("[MusicPlayerNotifier] Set empty audio source.");
        return;
      }

      if (effectiveInitialIndex != -1) {
        await Future.delayed(const Duration(milliseconds: 100));

        try {
          await _audioPlayer.setAudioSource(
            _currentPlaylistSource!,
            initialIndex: effectiveInitialIndex,
            initialPosition: Duration.zero,
            preload: true,
          );
          log("[MusicPlayerNotifier] setAudioSource completed. Autoplay is $shouldPlay.");
        } catch (e) {
          log("[MusicPlayerNotifier] First attempt to set audio source failed: $e. Retrying...");
          await Future.delayed(const Duration(milliseconds: 300));
          await _audioPlayer.setAudioSource(
            _currentPlaylistSource!,
            initialIndex: effectiveInitialIndex,
            initialPosition: Duration.zero,
            preload: true,
          );
        }

        if (shouldPlay) {
          log("[MusicPlayerNotifier] Auto-playing after setting audio source.");
          await _audioPlayer.play();
        }
      }

      if (_audioPlayer.duration != null) {
        state = state.copyWith(duration: _audioPlayer.duration);
        log("[MusicPlayerNotifier] Initial duration set: ${_audioPlayer.duration}");
      }
    } catch (e, st) {
      log("[MusicPlayerNotifier] Error setting audio source: $e",
          error: e, stackTrace: st);
      if (!mounted) return;
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Failed to load playlist: ${e.toString()}");
      _ref.read(currentTrackProvider.notifier).state = null;
      _ref.read(queueProvider.notifier).syncIndex(-1);
    }
  }

  Future<void> loadTrack(Track track) async {
    if (!mounted) return;
    log("[MusicPlayerNotifier] loadTrack called for: '${track.trackName}'.");

    if (state.status == PlayerStatus.error) {
      state = state.copyWith(clearError: true);
    }

    _ref.read(currentTrackProvider.notifier).state = track;
    state = state.copyWith(status: PlayerStatus.loading);

    try {
      final currentQueueState = _ref.read(queueProvider);
      final int existingIndex = currentQueueState.items.indexOf(track);
      final bool wasAlreadyCurrent = (existingIndex != -1 &&
          existingIndex == currentQueueState.currentIndex);

      if (existingIndex == -1 ) {
        // _ref.read(queueProvider.notifier).playTrack(track);
        _ref.read(queueProvider.notifier).addAfterCurrent(track);
        _ref.read(queueProvider.notifier).next();

        final updatedQueueState = _ref.read(queueProvider);
        await _updatePlayerPlaylist(
            updatedQueueState.items, updatedQueueState.currentIndex,
            shouldPlay: true);
        log("[MusicPlayerNotifier] Updated playlist with selected track as current.");
      } else if (!wasAlreadyCurrent) {
        _ref.read(queueProvider.notifier).playTrack(track);
      }
      else if (wasAlreadyCurrent) {
        log("[MusicPlayerNotifier] Track was already current. Starting playback.");
        await play();
      }
    } catch (e, st) {
      log("[MusicPlayerNotifier] Error during loadTrack execution: $e",
          error: e, stackTrace: st);
      if (!mounted) return;
      state = state.copyWith(
          status: PlayerStatus.error,
          errorMessage: "Error processing track request: ${e.toString()}");
    }
  }

  Future<void> play() async {
    if (!mounted) {
      log("[MusicPlayerNotifier] play aborted: Notifier not mounted.");
      return;
    }

    if (!state.isPlaying) {
      log("[MusicPlayerNotifier] Attempting to call _audioPlayer.play(). Current status: ${state.status}");
      try {
        if (_audioPlayer.audioSource != null &&
            (_audioPlayer.processingState == ProcessingState.idle ||
                _audioPlayer.processingState == ProcessingState.ready ||
                _audioPlayer.processingState == ProcessingState.completed)) {
          await _audioPlayer.play();
          log("[MusicPlayerNotifier] _audioPlayer.play() called.");
        } else if (_audioPlayer.audioSource == null) {
          log("[MusicPlayerNotifier] Play ignored: No audio source loaded.");
          final queue = _ref.read(queueProvider);
          if (queue.items.isNotEmpty &&
              queue.currentIndex != -1 &&
              queue.current != null) {
            log("[MusicPlayerNotifier] No source loaded, but queue has items. Attempting to load current queue track.");

            await _updatePlayerPlaylist(queue.items, queue.currentIndex,
                shouldPlay: true);
          } else {
            log("[MusicPlayerNotifier] Cannot play: No source loaded and queue is empty or invalid.");
          }
        } else {
          log("[MusicPlayerNotifier] Play ignored: Player is in processing state ${_audioPlayer.processingState} which cannot be played/resumed.");
        }
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.play(): $e",
            error: e, stackTrace: stackTrace);
        if (!mounted) return;
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Error starting playback: ${e.toString()}");
      }
    } else {
      log("[MusicPlayerNotifier] Play ignored: Player is already playing.");
    }
  }

  Future<void> pause() async {
    if (!mounted) {
      log("[MusicPlayerNotifier] pause aborted: Notifier not mounted.");
      return;
    }

    if (_audioPlayer.playing ||
        _audioPlayer.processingState == ProcessingState.loading ||
        _audioPlayer.processingState == ProcessingState.buffering) {
      log("[MusicPlayerNotifier] Attempting to call _audioPlayer.pause(). Current status: ${state.status}");
      try {
        await _audioPlayer.pause();
        log("[MusicPlayerNotifier] _audioPlayer.pause() called.");
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.pause(): $e",
            error: e, stackTrace: stackTrace);
        if (!mounted) return;
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Error pausing playback: ${e.toString()}");
      }
    } else {
      log("[MusicPlayerNotifier] Pause ignored: Player is not in a pausable state (Status: ${state.status}).");
    }
  }

  Future<void> seek(Duration position) async {
    if (!mounted) {
      log("[MusicPlayerNotifier] seek aborted: Notifier not mounted.");
      return;
    }

    if (_audioPlayer.audioSource != null &&
        _audioPlayer.processingState != ProcessingState.idle) {
      final currentDuration =
          _audioPlayer.duration ?? state.duration ?? Duration.zero;
      final seekPosition = position.isNegative
          ? Duration.zero
          : (position > currentDuration ? currentDuration : position);

      log("[MusicPlayerNotifier] Seeking to: $seekPosition (Current Duration: $currentDuration)");

      try {
        await _audioPlayer.seek(seekPosition);
        log("[MusicPlayerNotifier] _audioPlayer.seek() called.");
      } catch (e, stackTrace) {
        log("[MusicPlayerNotifier] Error during _audioPlayer.seek(): $e",
            error: e, stackTrace: stackTrace);
        if (!mounted) return;
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Error seeking: ${e.toString()}");
      }
    } else {
      log("[MusicPlayerNotifier] Seek ignored: No audio source loaded or player is idle.");
    }
  }

  Future<void> stop() async {
    if (!mounted) {
      log("[MusicPlayerNotifier] stop aborted: Notifier not mounted.");
      return;
    }
    log("[MusicPlayerNotifier] Attempting to call _audioPlayer.stop().");
    try {
      await _audioPlayer.stop();
      log("[MusicPlayerNotifier] _audioPlayer.stop() called.");

      if (!mounted) return;

      _currentPlaylistSource = null;

      state = const MusicPlayerState();
      _ref.read(currentTrackProvider.notifier).state = null;
      _ref.read(queueProvider.notifier).syncIndex(-1);
    } catch (e, stackTrace) {
      log("[MusicPlayerNotifier] Error stopping player: $e",
          error: e, stackTrace: stackTrace);
      if (mounted) {
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Failed to stop player: ${e.toString()}");
        _ref.read(currentTrackProvider.notifier).state = null;
        _ref.read(queueProvider.notifier).syncIndex(-1);
      }
    }
  }

  void startSeeking() {
    if (!mounted) return;
    state = state.copyWith(isSeeking: true);
    log("[MusicPlayerNotifier] Started seeking");
  }

  void updateSeekPosition(Duration position) {
    if (!mounted) return;
    state = state.copyWith(position: position, isSeeking: true);
  }

  void endSeeking() {
    if (!mounted) return;
    state = state.copyWith(isSeeking: false);
    log("[MusicPlayerNotifier] Ended seeking");
  }

  Future<void> skipToNext() async {
    if (!mounted) return;
    log("[MusicPlayerNotifier] skipToNext called.");

    if (_audioPlayer.hasNext) {
      log("[MusicPlayerNotifier] Skipping to next via player. _audioPlayer.hasNext is true.");
      await _audioPlayer.seekToNext();
      _checkAndPrefetchNextTrack();
    } else {
      // log("[MusicPlayerNotifier] No next item in player source. Checking recommendations.");

      // if (_isFetchingRecommendation) {
      //   log("[MusicPlayerNotifier] Already fetching recommendation, skipping redundant call.");
      //   return;
      // }
      // _isFetchingRecommendation = true;

      // final queue = _ref.read(queueProvider);
      // final currentTrack = queue.current;

      // if (currentTrack != null) {
      //   log("[MusicPlayerNotifier] End of queue reached (or source ended), fetching recommendation for ${currentTrack.trackName}");

      //   try {
      //     state = state.copyWith(status: PlayerStatus.loading);

      //     final rec = await _apiServices.getNextRecommendedTrack(
      //       currentTrack.artistName,
      //       currentTrack.trackName,
      //     );

      //     if (!mounted) return;

      //     if (rec != null) {
      //       log("[MusicPlayerNotifier] Recommendation found: ${rec.trackName}. Adding to queue and playing.");

      //       _ref.read(currentTrackProvider.notifier).state = rec;

      //       _ref.read(queueProvider.notifier).playTrack(rec);
      //     } else {
      //       log("[MusicPlayerNotifier] No next recommended track available. Stopping playback.");
      //       await stop();
      //     }
      //   } catch (e) {
      //     log("[MusicPlayerNotifier] Error fetching next recommended track: $e",
      //         error: e);
      //   } finally {
      //     _isFetchingRecommendation = false;
      //   }
      // } else {}

      log("[MusicPlayerNotifier] No next track available. Waiting for prefetched content.");
      state = state.copyWith(status: PlayerStatus.loading);

      await Future.delayed(const Duration(milliseconds: 500));

      if (!_audioPlayer.hasNext && _ref.read(queueProvider).next == null) {
        log("[MusicPlayerNotifier] No prefetched content available. Stopping playback.");
        await stop();
      }
    }
  }

  Future<void> prepareTrackForDisplay(Track track) async {
    if (!mounted) return;

    log("[MusicPlayerNotifier] Preparing track for immediate display: ${track.trackName}");

    _ref.read(currentTrackProvider.notifier).state = track;

    state = state.copyWith(status: PlayerStatus.loading);
  }

  Future<void> skipToPrevious() async {
    if (!mounted) return;
    log("[MusicPlayerNotifier] skipToPrevious called.");

    if (_audioPlayer.hasPrevious) {
      log("[MusicPlayerNotifier] Skipping to previous via player. _audioPlayer.hasPrevious is true.");
      try {
        await _audioPlayer.seekToPrevious();
        log("[MusicPlayerNotifier] _audioPlayer.seekToPrevious() called.");
      } catch (e, st) {
        log("[MusicPlayerNotifier] Error seeking to previous player item: $e",
            error: e, stackTrace: st);
        if (!mounted) return;
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "Failed to skip previous: ${e.toString()}");
      }
    } else {
      log("[MusicPlayerNotifier] Cannot skip previous: No previous item in player source (_audioPlayer.hasPrevious is false).");
      if (_audioPlayer.currentIndex == 0 && _audioPlayer.audioSource != null) {
        log("[MusicPlayerNotifier] At the start of the queue, restarting current track by seeking to zero.");
        await seek(Duration.zero);
      } else {
        log("[MusicPlayerNotifier] Cannot skip previous. Player current index: ${_audioPlayer.currentIndex}");
      }
    }
  }

  void _cancelSubscriptions() {
    log('[MusicPlayerNotifier] Cancelling player stream subscriptions.');
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _bufferedPositionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerIndexSubscription?.cancel();
    _playerStateSubscription = null;
    _positionSubscription = null;
    _bufferedPositionSubscription = null;
    _durationSubscription = null;
    _playerIndexSubscription = null;
  }

  @override
  void dispose() {
    log('[MusicPlayerNotifier] Disposing MusicPlayerNotifier instance.');
    _cancelSubscriptions();
    super.dispose();
  }
}
