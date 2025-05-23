import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/music_provider/audio_streaming_provider.dart';
import 'package:synqit/Provider/music_provider/queue_manager_provider.dart';
import 'package:synqit/Provider/music_provider/queue_provider.dart';
import 'package:synqit/Provider/music_provider/current_track_provider.dart';
import 'music_player_state.dart';

final audioPlayer = AudioPlayer();
final _database = Database();
final _userServics = UserServices();

final musicPlayerProvider =
    StateNotifierProvider.autoDispose<MusicPlayerNotifier, MusicPlayerState>(
        (ref) {
  final notifier = MusicPlayerNotifier(
    ref,
    audioPlayer,
    ref.watch(audioStreamingServiceProvider),
    ref.watch(queueManagerProvider),
  );

  ref.onDispose(() {
    notifier._disposed = true;
    notifier._cancelSubscriptions();
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
  final AudioPlayer _audioPlayer;
  final AudioStreamingService _streamingService;
  final QueueManager _queueManager;

  ConcatenatingAudioSource? _playlist;
  bool _disposed = false;
  bool _pendingPlay = false;

  final Map<String, Completer<void>> _locks = {};
  final List<int> _playHistory = [];
  int _historyIndex = -1;
  bool _isHistoryNavigation = false;

  int _currentQueueVersion = 0;

  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _bufferedPositionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerIndexSubscription;
  StreamSubscription? _sequenceStateSubscription;

  MusicPlayerNotifier(
    this._ref,
    this._audioPlayer,
    this._streamingService,
    this._queueManager,
  ) : super(const MusicPlayerState()) {
    _initStreams();
    _restorePlayHistory();
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

  void _initStreams() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen(
      (playerState) {
        if (_disposed) return;

        final status = _mapPlayerState(playerState);
        state = state.copyWith(status: status);

        if (status == PlayerStatus.completed) {
          _handleTrackCompleted();
        }
      },
      onError: (error) {
        if (_disposed) return;
        state = state.copyWith(
            status: PlayerStatus.error, errorMessage: error.toString());
        _updateOperationState(false, "Player error: $error", "playback");
      },
    );

    _positionSubscription = _audioPlayer.positionStream.listen(
      (position) {
        if (_disposed || state.isSeeking) return;
        state = state.copyWith(position: position);
      },
    );

    _bufferedPositionSubscription = _audioPlayer.bufferedPositionStream.listen(
      (bufferedPosition) {
        if (_disposed) return;
        state = state.copyWith(bufferedPosition: bufferedPosition);
      },
    );

    _durationSubscription = _audioPlayer.durationStream.listen(
      (duration) {
        if (_disposed) return;
        state = state.copyWith(duration: duration);
      },
    );

    _playerIndexSubscription = _audioPlayer.currentIndexStream.listen(
      (index) {
        _handleIndexChange(index);
      },
    );

    _sequenceStateSubscription = _audioPlayer.sequenceStateStream.listen(
      (sequenceState) {
        if (_disposed || sequenceState == null) return;

        if (_pendingPlay && sequenceState.currentIndex != null) {
          _pendingPlay = false;
          _audioPlayer.play();
        }
      },
    );

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
        await _audioPlayer.stop();
        _playlist = null;
        _releaseLock('queue_sync');
        return;
      }

      final updateType = _determineUpdateType(previous, current);

      switch (updateType) {
        case QueueUpdateType.fullRebuild:
          await _rebuildPlaylist(current.items, current.currentIndex);
          break;

        case QueueUpdateType.append:
          if (previous != null) {
            await _appendToPlaylist(current.items, previous.items.length);
          }
          break;

        case QueueUpdateType.indexOnly:
          if (_audioPlayer.currentIndex != current.currentIndex &&
              current.currentIndex >= 0 &&
              current.currentIndex <
                  (_audioPlayer.audioSource?.sequence.length ?? 0)) {
            _audioPlayer.seek(Duration.zero, index: current.currentIndex);
          }
          break;

        case QueueUpdateType.none:
          break;
      }
    } finally {
      _releaseLock('queue_sync');
    }
  }

  QueueUpdateType _determineUpdateType(
      QueueState? previous, QueueState current) {
    if (previous == null || previous.items.isEmpty) return QueueUpdateType.fullRebuild;
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

  Future<void> _rebuildPlaylist(List<Track> tracks, int initialIndex) async {
    if (_disposed) return;

    if (await _acquireLock('rebuild_playlist')) return;

    try {
      _updateOperationState(true, null, "rebuilding playlist");

      final wasPlaying = _audioPlayer.playing;
      await _audioPlayer.stop();

      if (tracks.isEmpty) {
        _playlist = null;
        _updateOperationState(false, null, "playlist empty");
        return;
      }

      final sources = <AudioSource>[];
      for (final track in tracks) {
        try {
          final data = await _streamingService.getAudioStreamData(track);
          if (data['audioUrl'] != null) {
            sources.add(AudioSource.uri(Uri.parse(data['audioUrl']!)));
          } else {
            sources.add(AudioSource.uri(Uri.parse('')));
          }
        } catch (_) {
          sources.add(AudioSource.uri(Uri.parse('')));
        }
      }

      if (_disposed || sources.isEmpty) return;

      _playlist = ConcatenatingAudioSource(children: sources);

      final validIndex = initialIndex.clamp(0, tracks.length - 1);
      await _audioPlayer.setAudioSource(
        _playlist!,
        initialIndex: validIndex,
        preload: true,
      );

      if (wasPlaying) {
        await _audioPlayer.play();
      }

      // _pendingPlay = false;

      _updateOperationState(false, null, "playlist ready");
    } catch (e) {
      _updateOperationState(false, "Failed to build playlist: $e", "playlist");
    } finally {
      _releaseLock('rebuild_playlist');
    }
  }

  Future<void> _appendToPlaylist(List<Track> allTracks, int startIdx) async {
    if (_disposed || _playlist == null) return;

    if (await _acquireLock('append_playlist')) return;

    try {
      final newTracks = allTracks.sublist(startIdx);
      if (newTracks.isEmpty) return;

      for (final track in newTracks) {
        if (_disposed) break;

        try {
          final data = await _streamingService.getAudioStreamData(track);
          if (data['audioUrl'] != null && _playlist != null) {
            await _playlist!.add(AudioSource.uri(Uri.parse(data['audioUrl']!)));
          } else {
            await _playlist!.add(AudioSource.uri(Uri.parse('')));
          }
        } catch (_) {
          if (_playlist != null) {
            await _playlist!.add(AudioSource.uri(Uri.parse('')));
          }
        }
      }
    } finally {
      _releaseLock('append_playlist');
    }
  }

  void _handleIndexChange(int? index) {
    if (_disposed || index == null) return;

    final queueNotifier = _ref.read(queueProvider.notifier);
    queueNotifier.syncIndex(index);

    final queueState = _ref.read(queueProvider);
    if (queueState.current != null) {
      _ref.read(currentTrackProvider.notifier).state = queueState.current;

      if (!_isHistoryNavigation && queueState.currentIndex >= 0) {
        _addToHistory(queueState.currentIndex);
      }

      _checkForRecommendations(queueState);
    } else {
      _ref.read(currentTrackProvider.notifier).state = null;
    }
  }

  void _addToHistory(int index) async{
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
        await _database.writeTrack(queueState.current!, state.duration?.inSeconds ?? 0);
        await _userServics.historyTrack(queueState.current!.trackId);

      }
    }
  }

  void _checkForRecommendations(QueueState state) {
    if (state.currentIndex == -1 || state.items.isEmpty) return;

    if (state.remainingTracks <= 1) {
      _queueManager.fetchRecommendations(state.current!);
    }
  }

  void _handleTrackCompleted() {
    final queueState = _ref.read(queueProvider);

    if (queueState.next != null) {
      skipToNext();
    } else {
      _queueManager.fetchRecommendations(queueState.current!).then((_) {
        Future.delayed(const Duration(milliseconds: 300), () {
          final updatedQueue = _ref.read(queueProvider);
          if (updatedQueue.next != null) {
            skipToNext();
          } else {
            state = state.copyWith(
              status: PlayerStatus.completed,
              position: Duration.zero,
            );
          }
        });
      });
    }
  }

  Future<void> loadTrack(Track track) async {
    if (_disposed) return;
    if (await _acquireLock('load_track')) return;

    try {
      _ref.read(currentTrackProvider.notifier).state = track;
      _updateOperationState(true, null, "loading track");
      state = state.copyWith(status: PlayerStatus.loading);

      await _audioPlayer.stop();

      _ref.read(queueProvider.notifier).clear();
      _queueManager.resetRecommendationTracking();

      _isHistoryNavigation = false;

      final queueActions = _ref.read(queueActionsProvider);
      final index = queueActions.playTrack(track);

      Future.microtask(() async {
        await _rebuildPlaylist(_ref.read(queueProvider).items, index);

        // _pendingPlay = true;
        await _audioPlayer.play();
        log("JUST ADD TRACK ON-CLICK");
        _queueManager.fetchRecommendations(track);
        _updateOperationState(false, null, "track loaded");
      });
    } catch (e) {
      _updateOperationState(false, "Failed to load track: $e", "load");
      state = state.copyWith(
          status: PlayerStatus.error, errorMessage: e.toString());
    } finally {
      _releaseLock('load_track');
    }
  }

  Future<void> play() async {
    if (_disposed) return;

    try {
      await _audioPlayer.play();
    } catch (e) {
      state = state.copyWith(
          status: PlayerStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> pause() async {
    if (_disposed) return;

    try {
      await _audioPlayer.pause();
    } catch (e) {
      _updateOperationState(false, "Failed to pause: $e", "pause");
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
        _updateOperationState(false, "Invalid track index", "index");
        _releaseLock('play_at_index');
        return;
      }

      if (index > queueState.currentIndex + 1) {
        final queueNotifier = _ref.read(queueProvider.notifier);
        final targetTrack = queueState.items[index];

        final tracksToRemove = <int>[];
        for (int i = queueState.items.length - 1; i > index; i--) {
          tracksToRemove.add(i);
        }

        for (final i in tracksToRemove) {
          queueNotifier.removeAt(i);
        }

        queueNotifier.playTrack(targetTrack);
      } else {
        _ref.read(queueProvider.notifier).playTrackAtIndex(index);
      }

      await _audioPlayer.seek(Duration.zero, index: index);
      await _audioPlayer.play();

      _updateOperationState(false, null, "playing track");
    } catch (e) {
      _updateOperationState(false, "Failed to play track: $e", "play_track");
    } finally {
      _releaseLock('play_at_index');
    }
  }

  Future<void> skipToNext() async {
    if (_disposed) return;
    if (await _acquireLock('skip_next')) return;

    try {
      _updateOperationState(true, null, "next track");
      _isHistoryNavigation = false;

      if (_audioPlayer.hasNext) {
        await _audioPlayer.seekToNext();
        await _audioPlayer.play();
        _updateOperationState(false, null, "playing next");
      } else {
        final success = await _queueManager.forceRefreshRecommendations();

        if (success && _audioPlayer.hasNext) {
          await _audioPlayer.seekToNext();
          await _audioPlayer.play();
          _updateOperationState(false, null, "playing recommended");
        } else {
          _updateOperationState(false, "No more tracks", "end of queue");
        }
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

      if (_audioPlayer.position >= const Duration(seconds: 3)) {
        await _audioPlayer.seek(Duration.zero);
        _updateOperationState(false, null, "restarted track");
        _releaseLock('skip_previous');
        return;
      }

      if (_historyIndex > 0) {
        _isHistoryNavigation = true;
        _historyIndex--;
        final previousIndex = _playHistory[_historyIndex];

        final queueState = _ref.read(queueProvider);
        if (previousIndex >= 0 && previousIndex < queueState.items.length) {
          await _audioPlayer.seek(Duration.zero, index: previousIndex);
          await _audioPlayer.play();
          _updateOperationState(false, null, "playing previous (history)");
          _releaseLock('skip_previous');
          return;
        }

        _isHistoryNavigation = false;
      }

      if (_audioPlayer.hasPrevious) {
        await _audioPlayer.seekToPrevious();
        await _audioPlayer.play();
        _updateOperationState(false, null, "playing previous");
      } else {
        _updateOperationState(false, "No previous tracks", "previous");
      }
    } catch (e) {
      _updateOperationState(false, "Failed to go back: $e", "previous");
    } finally {
      _releaseLock('skip_previous');
    }
  }

  Future<void> seek(Duration position) async {
    if (_disposed) return;

    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      _updateOperationState(false, "Failed to seek: $e", "seek");
    }
  }

  Future<void> stop() async {
    if (_disposed) return;
    if (await _acquireLock('stop')) return;

    try {
      _updateOperationState(true, null, "stopping");

      await _audioPlayer.stop();
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

  Future<void> clearQueueAndStop() async {
    if (_disposed) return;
    if (await _acquireLock('clear_queue')) return;

    try {
      _updateOperationState(true, null, "clearing queue");

      await _audioPlayer.stop();
      _ref.read(queueProvider.notifier).clear();
      _ref.read(currentTrackProvider.notifier).state = null;

      state = state.copyWith(
        status: PlayerStatus.initial,
        position: Duration.zero,
        clearDuration: true,
      );

      _updateOperationState(false, null, "queue cleared");
    } catch (e) {
      _updateOperationState(false, "Failed to clear queue: $e", "clear");
    } finally {
      _releaseLock('clear_queue');
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
      state = state.copyWith(isSeeking: false);
    }
  }

  PlayerStatus _mapPlayerState(PlayerState playerState) {
    if (playerState.processingState == ProcessingState.loading ||
        playerState.processingState == ProcessingState.buffering) {
      return PlayerStatus.loading;
    }

    if (playerState.processingState == ProcessingState.ready) {
      return playerState.playing ? PlayerStatus.playing : PlayerStatus.paused;
    }

    if (playerState.processingState == ProcessingState.completed) {
      return PlayerStatus.completed;
    }

    return PlayerStatus.initial;
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

  void _cancelSubscriptions() {
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _bufferedPositionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerIndexSubscription?.cancel();
    _sequenceStateSubscription?.cancel();
  }
}

enum QueueUpdateType {
  none,
  indexOnly,
  append,
  fullRebuild,
}
