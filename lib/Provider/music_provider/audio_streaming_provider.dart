import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/youtube_services.dart';

class AudioStreamingService {
  final Map<int, Map<String, String?>> _streamCache = {};
  final int _maxCacheSize = 20;

  Future<Map<String, String?>> getAudioStreamData(Track track) async {
    if (_streamCache.containsKey(track.trackId)) {
      log('[AudioStreamingService] Cache hit for: ${track.trackName}');
      return _streamCache[track.trackId]!;
    }

    log('[AudioStreamingService] Fetching stream data for: ${track.trackName}');
    try {
      Map<String, dynamic> data;
      if (track.videoId != null && track.videoId!.isNotEmpty) {
        data = await getAudioStreamUrlByID(track.videoId!);
      } else {
        data =
            await getAudioStreamUrl("${track.trackName} - ${track.artistName}");
      }

      if (data['audioUrl'] == null || data['audioUrl'].isEmpty) {
        log('[AudioStreamingService] Failed to get audio URL for ${track.trackName}');
        throw Exception('Failed to get audio URL for track.');
      }

      final result = {
        'audioUrl': data['audioUrl'] as String?,
        'videoId': data['videoId'] as String?,
      };

      _addToCache(track.trackId, result);
      return result;
    } catch (e) {
      log('[AudioStreamingService] Error: $e');
      rethrow;
    }
  }

  void _addToCache(int trackId, Map<String, String?> data) {
    if (_streamCache.length >= _maxCacheSize) {
      final oldestKey = _streamCache.keys.first;
      _streamCache.remove(oldestKey);
    }
    _streamCache[trackId] = data;
  }

  void clearCache() {
    _streamCache.clear();
  }
}

final audioStreamingServiceProvider = Provider<AudioStreamingService>((ref) {
  return AudioStreamingService();
});
