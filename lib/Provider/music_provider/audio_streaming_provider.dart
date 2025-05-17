import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/youtube_services.dart';

class AudioStreamingService {
  AudioStreamingService();

  Future<Map<String, String?>> getAudioStreamData(Track track) async {
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

      return {
        'audioUrl': data['audioUrl'] as String?,
        'videoId': data['videoId'] as String?,
      };
    } catch (e, st) {
      log('[AudioStreamingService] Error fetching stream data for ${track.trackName}: $e',
          error: e, stackTrace: st);

      rethrow;
    }
  }
}

final audioStreamingServiceProvider = Provider<AudioStreamingService>((ref) {
  return AudioStreamingService();
});
