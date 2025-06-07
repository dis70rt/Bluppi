import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';

final mediaServiceProvider = Provider<MediaService>((ref) {
  return MediaService();
});

class MediaService {
  static const MethodChannel _channel = MethodChannel('synqit/media_channel');

  MediaService();

  Future<void> play({required Track track}) async {
    try {
      if (track.audioUrl == null || track.audioUrl!.isEmpty) {
        log('Cannot play: Track has no audio URL');
        throw Exception('Track has no audio URL');
      }
      
      await _channel.invokeMethod('play', {
        'url': track.audioUrl,
        'title': track.trackName,
        'artist': track.artistName,
        'imageUrl': track.imageUrl
      });
    } on PlatformException catch (e) {
      log('Error playing media: $e');
      rethrow;
    }
  }

  Future<void> pause() async {
    try {
      await _channel.invokeMethod('pause');
    } on PlatformException catch (e) {
      log('Error pausing media: $e');
      rethrow;
    }
  }

  Future<void> stop() async {
    try {
      await _channel.invokeMethod('stop');
    } on PlatformException catch (e) {
      log('Error stopping media: $e');
      rethrow;
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _channel
          .invokeMethod('seekTo', {'position': position.inMilliseconds});
    } on PlatformException catch (e) {
      log('Error seeking: $e');
      rethrow;
    }
  }

  Future<Duration?> getPosition() async {
    try {
      final result = await _channel.invokeMethod<int>('getPosition');
      return result != null ? Duration(milliseconds: result) : null;
    } on PlatformException catch (e) {
      log('Error getting position: $e');
      return null;
    }
  }

  Future<Track> ensureTrackHasAudioUrl(Track track) async {
    if (track.audioUrl != null && track.audioUrl!.isNotEmpty) {
      return track;
    }
    
    throw Exception('Track must have audioUrl to play');
  }
}