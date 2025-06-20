import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/notification_method_channel.dart';
import 'package:synqit/Provider/MusicProvider/audio_streaming_provider.dart';
import 'package:synqit/Provider/MusicProvider/queue_manager_provider.dart';
import 'package:synqit/Provider/MusicProvider/queue_provider.dart';
import 'package:synqit/Provider/MusicProvider/current_track_provider.dart';
import 'package:synqit/PubSub/publisher.dart';
import 'package:synqit/PubSub/subscriber.dart';
import 'music_player_state.dart';

// final _database = Database();
// final _userServics = UserServices();

final musicPlayerProvider =
    StateNotifierProvider.autoDispose<MusicPlayerNotifier, MusicPlayerState>(
        (ref) {
  final notifier = MusicPlayerNotifier(
    ref,
    ref.watch(audioStreamingServiceProvider),
    ref.watch(queueManagerProvider),
    ref.watch(mediaServiceProvider),
  );

  ref.onDispose(() {
    notifier._disposed = true;
  });

  return notifier;
});

final playerOperationProvider = StateProvider<PlayerOperation>((ref) {
  return const PlayerOperation();
});

class PlayerOperation {
  final bool isLoading;
  final String? errorMessage;
  final String? operationName;

  const PlayerOperation(
      {this.isLoading = false, this.errorMessage, this.operationName});

  PlayerOperation copyWith({
    bool? isLoading,
    String? errorMessage,
    String? operationName,
    bool clearError = false,
  }) {
    return PlayerOperation(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      operationName: operationName ?? this.operationName,
    );
  }

  bool get hasError => errorMessage != null;
}

class MusicPlayerNotifier extends StateNotifier<MusicPlayerState> {
  final Ref _ref;
  final AudioStreamingService _streamingService;
  final QueueManager _queueManager;
  final MediaService _mediaService;

  bool _disposed = false;

  final Map<String, Completer<void>> _locks = {};
  final List<int> _playHistory = [];
  int _historyIndex = -1;
  bool _isHistoryNavigation = false;

  int _currentQueueVersion = 0;

  MusicPlayerNotifier(
    this._ref,
    this._streamingService,
    this._queueManager,
    this._mediaService,
  ) : super(const MusicPlayerState()) {
    _initPlaybackHandling();
    _restorePlayHistory();

    _ref.read(trackDatabaseSubscriberProvider);
    _ref.read(trackHistorySubscriberProvider);
  }

  Future<void> _restorePlayHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList('play_history');
      if (history != null && history.isNotEmpty) {
        _playHistory.addAll(history.map(int.parse));
        _historyIndex = _playHistory.length - 1;
      }
    } catch (_) {}
  }

  Future<void> _savePlayHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_playHistory.isNotEmpty) {
        await prefs.setStringList(
            'play_history', _playHistory.map((id) => id.toString()).toList());
      }
    } catch (_) {}
  }

  void _initPlaybackHandling() {
    _mediaService.playerEvents.listen((event) {
      if (_disposed) return;

      switch (event['event']) {
        case 'state':
          break;

        case 'playing':
          final isPlaying = event['playing'] as bool;
          state = state.copyWith(
              status: isPlaying ? PlayerStatus.playing : PlayerStatus.paused);
          break;

        case 'track_change':
          handleManualNextTrackChange();

        case 'seek':
        case 'position':
          final position = event['position'] as int;

          state = state.copyWith(position: Duration(milliseconds: position));

          break;
        case 'duration':
          final duration = event['duration'] as int;
          if (duration > 0) {
            state = state.copyWith(duration: Duration(milliseconds: duration));
          }
          break;
      }
    }, onError: (e) {
      log('Player events error: $e');
    });

    _ref.listen<QueueState>(queueProvider, (previous, next) {
      if (_disposed) return;
      if (_currentQueueVersion == next.version) return;

      _currentQueueVersion = next.version;
      _syncPlayerWithQueue(previous, next);
    });
  }

  void _syncPlayerWithQueue(QueueState? previous, QueueState current) async {
    if (await _acquireLock('queue_sync')) return;

    try {
      if (current.items.isEmpty) {
        await _mediaService.stop();
        _releaseLock('queue_sync');
        return;
      }

      final updateType = _determineUpdateType(previous, current);

      if (updateType == QueueUpdateType.fullRebuild) {
        if (current.currentIndex >= 0 &&
            current.currentIndex < current.items.length) {
          final track = current.items[current.currentIndex];
          final enrichedTrack = await _fetchAndEnsureAudioUrl(track);
          if (enrichedTrack != null) {
            _ref.read(currentTrackProvider.notifier).state = enrichedTrack;
          }
        }
      } else if (updateType == QueueUpdateType.indexOnly) {
        if (current.currentIndex >= 0 &&
            current.currentIndex < current.items.length) {
          final track = current.items[current.currentIndex];
          final enrichedTrack = await _fetchAndEnsureAudioUrl(track);
          if (enrichedTrack != null) {
            _ref.read(currentTrackProvider.notifier).state = enrichedTrack;

            if (state.status == PlayerStatus.playing) {
              await _playCurrentTrack();
            }
          }
        }
      }
    } finally {
      _releaseLock('queue_sync');
    }
  }

  QueueUpdateType _determineUpdateType(
      QueueState? previous, QueueState current) {
    if (previous == null || previous.items.isEmpty) {
      return QueueUpdateType.fullRebuild;
    }
    if (current.items.isEmpty) return QueueUpdateType.fullRebuild;

    if (current.items.length < previous.items.length ||
        !_isPrefixEqual(previous.items, current.items, previous.items.length)) {
      return QueueUpdateType.fullRebuild;
    }

    if (current.items.length > previous.items.length) {
      return QueueUpdateType.append;
    }

    if (previous.currentIndex != current.currentIndex) {
      return QueueUpdateType.indexOnly;
    }

    return QueueUpdateType.none;
  }

  bool _isPrefixEqual(List<Track> a, List<Track> b, int length) {
    if (length > b.length) return false;
    for (int i = 0; i < length; i++) {
      if (a[i].trackId != b[i].trackId) return false;
    }
    return true;
  }

  Future<void> queueTracksToPlayer(List<Track> tracks) async {
    if (_disposed) return;
    if (tracks.isEmpty) return;

    final tracksWithAudio = <Track>[];
    for (final track in tracks) {
      final enrichedTrack = await _fetchAndEnsureAudioUrl(track);
      if (enrichedTrack != null) {
        tracksWithAudio.add(enrichedTrack);
      }
    }

    if (tracksWithAudio.isNotEmpty) {
      await _mediaService.queueTracks(tracks: tracksWithAudio);
    }
  }

  Future<void> _handleIndexChange(int index) async {
    if (_disposed) return;

    final queueNotifier = _ref.read(queueProvider.notifier);
    queueNotifier.syncIndex(index);

    final queueState = _ref.read(queueProvider);
    if (queueState.current != null) {
      Track currentTrack = queueState.current!;

      if (currentTrack.audioUrl == null || currentTrack.audioUrl!.isEmpty) {
        final enrichedTrack = await _fetchAndEnsureAudioUrl(currentTrack);
        if (enrichedTrack != null) {
          currentTrack = enrichedTrack;
          queueNotifier.updateTrackWithAudioUrl(
              currentTrack.trackId, enrichedTrack);
        } else {
          log("Error: Could not fetch audio URL for track ${currentTrack.trackName} in _handleIndexChange");
        }
      }

      _ref.read(currentTrackProvider.notifier).state = currentTrack;

      state = state.copyWith(
        position: Duration.zero,
        track: currentTrack,
      );

      if (!_isHistoryNavigation && queueState.currentIndex >= 0) {
        _addToHistory(queueState.currentIndex);
      }

      _checkForRecommendations(queueState);
      _prewarmMultipleTracks();
    } else {
      _ref.read(currentTrackProvider.notifier).state = null;
      state = state.copyWith(
          status: PlayerStatus.paused,
          position: Duration.zero,
          clearDuration: true,
          clearTrack: true);
    }
  }

  void _addToHistory(int index) async {
    if (_historyIndex >= 0 && _historyIndex < _playHistory.length - 1) {
      _playHistory.removeRange(_historyIndex + 1, _playHistory.length);
    }

    if (_playHistory.isEmpty || _playHistory.last != index) {
      _playHistory.add(index);
      _historyIndex = _playHistory.length - 1;

      if (_playHistory.length > 50) {
        _playHistory.removeAt(0);
        _historyIndex = _playHistory.length - 1;
      }

      _savePlayHistory();
      final queueState = _ref.read(queueProvider);
      if (queueState.current != null) {
        // await _database.writeTrack(
        //     queueState.current!, state.duration?.inSeconds ?? 0);
        // await _userServics.historyTrack(queueState.current!.trackId);

        final eventBus = _ref.read(trackEventBusProvider);
        eventBus.publish(TrackEvent(
          track: queueState.current!,
          type: TrackEventType.play,
          durationSeconds: state.duration?.inSeconds ?? 0,
        ));
      }
    }
  }

  void _checkForRecommendations(QueueState state) {
    if (state.currentIndex == -1 || state.items.isEmpty) return;

    if (state.remainingTracks <= 1) {
      _queueManager.fetchRecommendations(state.current!);
    }
  }

  Future<void> playTrackAtIndex(int index) async {
    if (_disposed) return;
    if (await _acquireLock('play_at_index')) return;

    try {
      _updateOperationState(true, null, "playing track");
      _isHistoryNavigation = false;

      final queueState = _ref.read(queueProvider);
      if (index < 0 || index >= queueState.items.length) {
        _updateOperationState(false, "Invalid track index", null);
        _releaseLock('play_at_index');
        return;
      }

      _ref.read(queueProvider.notifier).syncIndex(index);

      final track = queueState.items[index];
      final enrichedTrack = await _fetchAndEnsureAudioUrl(track);
      if (enrichedTrack == null) {
        _updateOperationState(false, "Failed to get audio for track", null);
        _releaseLock('play_at_index');
        return;
      }

      _ref.read(currentTrackProvider.notifier).state = enrichedTrack;

      await _mediaService.play(track: enrichedTrack);
      state = state.copyWith(
        status: PlayerStatus.playing,
        position: Duration.zero,
        track: enrichedTrack,
      );

      _handleIndexChange(index);
      _prewarmMultipleTracks();
      _updateOperationState(false, null, "track playing");
    } catch (e) {
      _updateOperationState(false, "Failed to play track: $e", null);
    } finally {
      _releaseLock('play_at_index');
    }
  }

  Future<void> _prewarmMultipleTracks() async {
    final queueState = _ref.read(queueProvider);
    if (queueState.currentIndex == -1 || queueState.items.isEmpty) return;

    const int maxPrewarmTracks = 3;
    List<Future<void>> prewarmFutures = [];

    for (int i = 1; i <= maxPrewarmTracks; i++) {
      final nextIndex = queueState.currentIndex + i;
      if (nextIndex < queueState.items.length) {
        final track = queueState.items[nextIndex];

        if (track.audioUrl != null && track.audioUrl!.isNotEmpty) {
          log('[PlayerProvider] Pre-warming track (URL exists): ${track.trackName}');
          prewarmFutures.add(_mediaService.prewarm(track: track));
        } else {
          prewarmFutures.add(_fetchAndPrewarmTrack(track));
        }
      }
    }

    for (var future in prewarmFutures) {
      await future;
      await Future.delayed(const Duration(milliseconds: 150));
    }
  }

  Future<void> _fetchAndPrewarmTrack(Track track) async {
    try {
      final enrichedTrack = await _fetchAndEnsureAudioUrl(track);
      if (enrichedTrack != null) {
        log('[PlayerProvider] Pre-warming track (fetched URL): ${track.trackName}');
        await _mediaService.prewarm(track: enrichedTrack);

        _ref
            .read(queueProvider.notifier)
            .updateTrackWithAudioUrl(track.trackId, enrichedTrack);
      }
    } catch (e) {
      log('[PlayerProvider] Failed to fetch and pre-warm track: ${track.trackName} - $e');
    }
  }

  Future<Track?> _fetchAndEnsureAudioUrl(Track track) async {
    try {
      final streamData = await _streamingService.getAudioStreamData(track);
      log("Stream data. $streamData");
      if (streamData['audioUrl'] != null &&
          streamData['audioUrl']!.isNotEmpty) {
        return track.copyWith(
          audioUrl: streamData['audioUrl'],
          videoId: streamData['videoId'] ?? track.videoId,
        );
      }
      _updateOperationState(
          false, "Failed to get audio stream for track", null);
      return null;
    } catch (e) {
      _updateOperationState(false, "Error retrieving audio: $e", null);
      return null;
    }
  }

  Future<void> _playCurrentTrack() async {
    final currentTrack = _ref.read(currentTrackProvider);
    if (currentTrack == null ||
        currentTrack.audioUrl == null ||
        currentTrack.audioUrl!.isEmpty) {
      throw Exception('Cannot play track without audio URL');
    }

    await _mediaService.play(track: currentTrack);

    _prewarmMultipleTracks();
  }

  Future<void> loadTrack(Track track) async {
    // if (_disposed) return;
    if (await _acquireLock('load_track')) return;

    try {
      _updateOperationState(true, null, "loading track");

      _ref.read(currentTrackProvider.notifier).state = track;
      state = state.copyWith(status: PlayerStatus.loading, track: track);

      await _mediaService.stop();
      _ref.read(queueProvider.notifier).clear();
      _queueManager.resetRecommendationTracking();
      _isHistoryNavigation = false;

      final enrichedTrack = await _fetchAndEnsureAudioUrl(track);
      if (enrichedTrack == null) {
        _updateOperationState(
            false, "Failed to get audio for this track", null);
        state = state.copyWith(
            status: PlayerStatus.error,
            errorMessage: "No audio available for this track");
        _releaseLock('load_track');
        return;
      }

      _ref.read(currentTrackProvider.notifier).state = enrichedTrack;
      final queueActions = _ref.read(queueActionsProvider);
      final index = queueActions.playTrack(enrichedTrack);

      await _queueManager.fetchRecommendations(enrichedTrack);
      final queueState = _ref.read(queueProvider);

      final tracksToQueue = [enrichedTrack];
      if (queueState.items.length > 1) {
        for (int i = index + 1; i < queueState.items.length; i++) {
          tracksToQueue.add(queueState.items[i]);
        }
      }

      await _mediaService.queueTracks(tracks: tracksToQueue);
      await _mediaService.play(track: enrichedTrack);

      state = state.copyWith(
        status: PlayerStatus.playing,
        position: Duration.zero,
        track: enrichedTrack,
      );
      _handleIndexChange(index);

      _updateOperationState(false, null, "track loaded");
    } catch (e) {
      _updateOperationState(false, "Failed to load track: $e", "load");
      state = state.copyWith(
          status: PlayerStatus.error, errorMessage: e.toString());
    } finally {
      _releaseLock('load_track');
    }
  }

  Future<void> clearQueueAndStop() async {
    if (_disposed) return;
    if (await _acquireLock('clear_queue')) return;

    try {
      _updateOperationState(true, null, "clearing queue");

      await _mediaService.stop();
      _ref.read(queueProvider.notifier).clear();
      _ref.read(currentTrackProvider.notifier).state = null;

      state = state.copyWith(
        status: PlayerStatus.initial,
        position: Duration.zero,
        clearDuration: true,
        clearTrack: true,
      );

      _updateOperationState(false, null, "queue cleared");
    } catch (e) {
      _updateOperationState(false, "Failed to clear queue: $e", "clear");
    } finally {
      _releaseLock('clear_queue');
    }
  }

  Future<void> play() async {
    if (_disposed) return;

    try {
      final currentTrack = _ref.read(currentTrackProvider);
      if (currentTrack == null) {
        _updateOperationState(false, "No track available to play", "play");
        return;
      }

      if (currentTrack.audioUrl == null || currentTrack.audioUrl!.isEmpty) {
        final enrichedTrack = await _fetchAndEnsureAudioUrl(currentTrack);
        if (enrichedTrack == null) {
          _updateOperationState(
              false, "No audio available for this track", null);
          return;
        }
        _ref.read(currentTrackProvider.notifier).state = enrichedTrack;
        await _mediaService.play(track: enrichedTrack);
      } else {
        await _mediaService.play(track: currentTrack);
      }

      state = state.copyWith(status: PlayerStatus.playing);

      // ignore: unnecessary_null_comparison
      if (state.status == PlayerStatus.playing && currentTrack != null) {
      final eventBus = _ref.read(trackEventBusProvider);
      eventBus.publish(TrackEvent(
        track: currentTrack,
        type: TrackEventType.play,
        durationSeconds: state.duration?.inSeconds ?? 0,
      ));
    }
    } catch (e) {
      state = state.copyWith(
          status: PlayerStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> pause() async {
    if (_disposed) return;

    try {
      await _mediaService.pause();
      state = state.copyWith(status: PlayerStatus.paused);
    } catch (e) {
      _updateOperationState(false, "Failed to pause: $e", "pause");
    }
  }

  void handleManualNextTrackChange() async {
    if (_disposed) return;

    try {
      final queueState = _ref.read(queueProvider);
      final nextIndex = queueState.currentIndex + 1;

      if (nextIndex >= queueState.items.length) {
        log('No next track available for UI update');
        return;
      }

      final nextTrack = queueState.items[nextIndex];

      _ref.read(currentTrackProvider.notifier).state = nextTrack;
      _ref.read(queueProvider.notifier).syncIndex(nextIndex);

      state = state.copyWith(
        status: PlayerStatus.playing,
        position: Duration.zero,
        track: nextTrack,
      );

      _handleIndexChange(nextIndex);

      log('Manual UI update triggered for next track: ${nextTrack.trackName}');
    } catch (e) {
      log('Error in handleManualNextTrackChange: $e');
    }
  }

  Future<void> skipToNext() async {
    if (_disposed) return;
    if (await _acquireLock('skip_next')) return;

    try {
      _updateOperationState(true, null, "next track");
      _isHistoryNavigation = false;

      final queueState = _ref.read(queueProvider);
      final nextIndex = queueState.currentIndex + 1;

      if (nextIndex >= queueState.items.length) {
        _updateOperationState(false, "No more tracks", "next");
        _releaseLock('skip_next');
        return;
      }

      final nextTrack = queueState.items[nextIndex];

      final enrichedTrack = await _fetchAndEnsureAudioUrl(nextTrack);
      if (enrichedTrack == null) {
        _updateOperationState(
            false, "Failed to get audio for next track", null);
        _releaseLock('skip_next');
        return;
      }

      if (nextTrack.audioUrl == null ||
          nextTrack.audioUrl != enrichedTrack.audioUrl) {
        _ref
            .read(queueProvider.notifier)
            .updateTrackWithAudioUrl(nextTrack.trackId, enrichedTrack);
      }

      await _mediaService.skipToNext();

      _ref.read(currentTrackProvider.notifier).state = enrichedTrack;
      _ref.read(queueProvider.notifier).syncIndex(nextIndex);

      state = state.copyWith(
        status: PlayerStatus.playing,
        position: Duration.zero,
        track: enrichedTrack,
      );

      _handleIndexChange(nextIndex);

      _updateOperationState(false, null, "skip initiated");
    } on PlatformException catch (e) {
      if (e.code == "NO_NEXT") {
        _updateOperationState(false, "No more tracks", "next");
      } else {
        _updateOperationState(false, "Failed to skip: ${e.message}", "next");
      }
    } catch (e) {
      _updateOperationState(false, "Failed to skip: $e", "next");
    } finally {
      _releaseLock('skip_next');
    }
  }

  Future<void> skipToPrevious() async {
    if (_disposed) return;
    if (await _acquireLock('skip_previous')) return;

    try {
      _updateOperationState(true, null, "previous track");

      if (_historyIndex > 0) {
        _isHistoryNavigation = true;
        _historyIndex--;
        final previousIndex = _playHistory[_historyIndex];

        final queueState = _ref.read(queueProvider);
        if (previousIndex >= 0 && previousIndex < queueState.items.length) {
          _ref.read(queueProvider.notifier).playTrackAtIndex(previousIndex);

          final previousTrack = queueState.items[previousIndex];
          final enrichedTrack = await _fetchAndEnsureAudioUrl(previousTrack);
          if (enrichedTrack == null) {
            _updateOperationState(
                false, "Failed to get audio for previous track", null);
            _isHistoryNavigation = false;
            _releaseLock('skip_previous');
            return;
          }

          _ref.read(currentTrackProvider.notifier).state = enrichedTrack;

          await _mediaService.play(track: enrichedTrack);

          state = state.copyWith(
            status: PlayerStatus.playing,
            position: Duration.zero,
          );

          _updateOperationState(false, null, "playing previous (history)");
          _handleIndexChange(previousIndex);
          _releaseLock('skip_previous');
          return;
        }

        _isHistoryNavigation = false;
      }

      _updateOperationState(false, "No previous tracks", "previous");
    } catch (e) {
      _updateOperationState(false, "Failed to go back: $e", "previous");
    } finally {
      _releaseLock('skip_previous');
    }
  }

  Future<void> seek(Duration position) async {
    if (_disposed) return;

    try {
      await _mediaService.seek(position);
      if (!state.isSeeking) {
        state = state.copyWith(position: position);
      }
    } catch (e) {
      _updateOperationState(false, "Failed to seek: $e", "seek");
    }
  }

  Future<void> stop() async {
    if (_disposed) return;
    if (await _acquireLock('stop')) return;

    try {
      _updateOperationState(true, null, "stopping");

      await _mediaService.stop();
      state = state.copyWith(
        status: PlayerStatus.initial,
        position: Duration.zero,
        clearDuration: true,
      );

      _updateOperationState(false, null, "stopped");
    } catch (e) {
      _updateOperationState(false, "Failed to stop: $e", "stop");
    } finally {
      _releaseLock('stop');
    }
  }

  void startSeeking() {
    if (!_disposed) {
      state = state.copyWith(isSeeking: true);
    }
  }

  void updateSeekPosition(Duration position) {
    if (!_disposed && state.isSeeking) {
      state = state.copyWith(position: position);
    }
  }

  void endSeeking() {
    if (!_disposed) {
      seek(state.position);
      state = state.copyWith(isSeeking: false);
    }
  }

  Future<bool> _acquireLock(String operation) async {
    if (_locks.containsKey(operation)) {
      return true;
    }

    _locks[operation] = Completer<void>();
    return false;
  }

  void _releaseLock(String operation) {
    final completer = _locks.remove(operation);
    completer?.complete();
  }

  void _updateOperationState(bool isLoading, String? error, String? operation) {
    if (_disposed) return;

    _ref.read(playerOperationProvider.notifier).state = PlayerOperation(
      isLoading: isLoading,
      errorMessage: error,
      operationName: operation,
    );
  }
}

enum QueueUpdateType {
  none,
  indexOnly,
  append,
  fullRebuild,
}
