import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Provider/music_provider/music_player_provider.dart';

class MediaNotificationService {
  static const MethodChannel _channel = MethodChannel('synqit/media_notification');
  final Ref? _ref;

  MediaNotificationService([this._ref]);
  
  Future<void> showMusicNotification(Track track, bool isPlaying) async {
    try {
      final musicPlayer = _ref?.read(musicPlayerProvider);
      final Duration? duration = musicPlayer?.duration;
      final audioUrl = _ref?.read(audioProvider);

      await _channel.invokeMethod('showMusicNotification', {
        'mediaUri': track.previewUrl,
        'audioUrl': audioUrl, // Send the real audio URL
        'trackId': track.trackId.toString(),
        'title': track.trackName,
        'artist': track.artistName,
        'album': track.albumName,
        'duration': duration?.inMilliseconds ?? 0,
        'imageUrl': track.imageUrl,
        'isPlaying': isPlaying,
      });
    } catch (e) {
      log('Error showing notification: $e');
    }
  }
  
  Future<void> updatePlaybackState(bool isPlaying) async {
    try {
      await _channel.invokeMethod('updatePlaybackState', {
        'isPlaying': isPlaying,
      });
    } catch (e) {
      log('Error updating playback state: $e');
    }
  }
  
  Future<void> hideNotification() async {
    try {
      await _channel.invokeMethod('hideNotification');
    } catch (e) {
      log('Error hiding notification: $e');
    }
  }
}

final mediaNotificationServiceProvider = Provider<MediaNotificationService>((ref) {
  return MediaNotificationService(ref);
});