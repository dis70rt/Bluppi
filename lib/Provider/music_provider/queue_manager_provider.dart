import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/api_services.dart';
import 'package:synqit/Provider/music_provider/queue_provider.dart';

class QueueManager {
  final ApiServices _apiServices;
  final Ref _ref;

  bool _isFetchingRecommendation = false;
  String? _lastSourceTrackId;

  final Map<String, List<Track>> _recommendationCache = {};
  Timer? _recommendationDebounceTimer;

  QueueManager(this._ref, this._apiServices) {
    _loadRecommendationCache();
  }

  Future<void> _loadRecommendationCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();

      for (final key in keys) {
        if (key.startsWith('rec_')) {
          final trackId = key.substring(4);

          _recommendationCache[trackId] = [];
        }
      }
    } catch (e) {
      log('[QueueManager] Failed to load cache: $e');
    }
  }

  void resetRecommendationTracking() {
    _lastSourceTrackId = null;
    _isFetchingRecommendation = false;
    _recommendationDebounceTimer?.cancel();
  }

  Future<void> fetchRecommendations(Track currentTrack) async {
    if (_isFetchingRecommendation) return;
    if (currentTrack.trackId.toString() == _lastSourceTrackId) return;

    _recommendationDebounceTimer?.cancel();
    _recommendationDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchRecommendationInBackground(currentTrack);
    });
  }

  Future<bool> forceRefreshRecommendations() async {
    final queueState = _ref.read(queueProvider);
    if (queueState.current == null) return false;

    _lastSourceTrackId = null;
    await _fetchRecommendationInBackground(queueState.current!,
        forceRefresh: true);

    final updatedQueue = _ref.read(queueProvider);
    return updatedQueue.items.length > queueState.items.length;
  }

  Future<void> _fetchRecommendationInBackground(Track currentTrack,
      {bool forceRefresh = false}) async {
    if (_isFetchingRecommendation) return;

    final trackId = currentTrack.trackId.toString();
    _isFetchingRecommendation = true;

    try {
      final queueState = _ref.read(queueProvider);

      if (!forceRefresh && queueState.remainingTracks > 1) {
        _isFetchingRecommendation = false;
        return;
      }

      Track? recommendation;
      if (!forceRefresh &&
          _recommendationCache.containsKey(trackId) &&
          _recommendationCache[trackId]!.isNotEmpty) {
        recommendation = _recommendationCache[trackId]!.first;
        _recommendationCache[trackId]!.removeAt(0);
      } else {
        recommendation = await _fetchRecommendation(currentTrack);

        _saveRecommendationToCache(trackId);
      }

      if (recommendation != null) {
        final latestQueueState = _ref.read(queueProvider);
        if (forceRefresh || latestQueueState.remainingTracks <= 1) {
          _ref.read(queueProvider.notifier).addRecommendation(recommendation);
          _lastSourceTrackId = trackId;
        }
      }
    } catch (e) {
      log('[QueueManager] Recommendation fetch error: $e');
    } finally {
      _isFetchingRecommendation = false;
    }
  }

  Future<void> _saveRecommendationToCache(String trackId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('rec_$trackId', 'cached');

      if (!_recommendationCache.containsKey(trackId)) {
        _recommendationCache[trackId] = [];
      }
    } catch (_) {}
  }

  Future<Track?> _fetchRecommendation(Track currentTrack) async {
    try {
      return await _apiServices.getNextRecommendedTrack(
        artist: currentTrack.artistName,
        track: currentTrack.trackName,
      );
    } catch (e) {
      log('[QueueManager] API error: $e');
      return null;
    }
  }
}

final queueManagerProvider = Provider.autoDispose<QueueManager>((ref) {
  return QueueManager(
    ref,
    ApiServices(),
  );
});

final queueActionsProvider = Provider.autoDispose<QueueActions>((ref) {
  return QueueActions(ref);
});

class QueueActions {
  final Ref _ref;

  QueueActions(this._ref);

  void addTrack(Track track) {
    _ref.read(queueProvider.notifier).add(track);
  }

  void addTrackNext(Track track) {
    _ref.read(queueProvider.notifier).addAfterCurrent(track);
  }

  int playTrack(Track track) {
    return _ref.read(queueProvider.notifier).playTrack(track);
  }

  void removeTrack(int index) {
    _ref.read(queueProvider.notifier).removeAt(index);
  }

  void clearQueue() {
    _ref.read(queueProvider.notifier).clear();
  }

  void removeUpcomingTracks() {
    _ref.read(queueProvider.notifier).removeUpcoming();
  }
}
