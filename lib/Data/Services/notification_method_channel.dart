import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';

final mediaServiceProvider = Provider<MediaService>((ref) {
  return MediaService();
});

class MediaService {
  static const MethodChannel _channel = MethodChannel('synqit/media_channel');
  static const EventChannel _eventChannel = EventChannel('synqit/media_events');

  final StreamController<Map<String, dynamic>> _playerEventsController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get playerEvents =>
      _playerEventsController.stream;

  Timer? _positionUpdateTimer;

  MediaService() {
    _initEventChannel();
    _startPositionUpdates();
  }

  void _initEventChannel() {
    _eventChannel.receiveBroadcastStream().listen((dynamic event) {
      if (event is Map) {
        _playerEventsController.add(Map<String, dynamic>.from(event));
      }
    }, onError: (error) {
      log('Event channel error: $error');
    });
  }

  void _startPositionUpdates() {
    _positionUpdateTimer?.cancel();
    _positionUpdateTimer =
        Timer.periodic(const Duration(milliseconds: 100), (_) {
      getPosition().then((position) {
        if (position != null) {
          _playerEventsController
              .add({'event': 'position', 'position': position.inMilliseconds});
        }
      });
    });
  }

  Future<bool> queueTracks({required List<Track> tracks}) async {
    try {
      if (tracks.isEmpty) return false;

      final trackMaps = tracks
          .map((track) {
            if (track.audioUrl == null || track.audioUrl!.isEmpty) {
              log('Cannot queue: Track has no audio URL');
              return null;
            }

            return {
              'url': track.audioUrl,
              'title': track.trackName,
              'artist': track.artistName,
              'imageUrl': track.imageUrl.replaceFirstMapped(
                  RegExp(r'(\d+x\d+bb)'), (match) => '1000x1000bb')
            };
          })
          .whereType<Map<String, dynamic>>()
          .toList();

      if (trackMaps.isEmpty) return false;

      final result = await _channel
          .invokeMethod<bool>('queueTracks', {'tracks': trackMaps});

      return result ?? false;
    } on PlatformException catch (e) {
      log('Error queuing tracks: $e');
      return false;
    }
  }

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
        'imageUrl': track.imageUrl.replaceFirstMapped(
            RegExp(r'(\d+x\d+bb)'), (match) => '1000x1000bb')
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

  Future<bool> prewarm({required Track track}) async {
    try {
      if (track.audioUrl == null || track.audioUrl!.isEmpty) {
        log('Cannot prewarm: Track has no audio URL');
        return false;
      }

      final result = await _channel.invokeMethod<bool>('prewarm', {
        'url': track.audioUrl,
        'title': track.trackName,
        'artist': track.artistName,
        'imageUrl': track.imageUrl.replaceFirstMapped(
            RegExp(r'(\d+x\d+bb)'), (match) => '1000x1000bb')
      });

      return result ?? false;
    } on PlatformException catch (e) {
      log('Error prewarming track: $e');
      return false;
    }
  }

  Future<void> skipToNext() async {
    try {
      await _channel.invokeMethod('skipToNext');
    } on PlatformException catch (e) {
      log('Error skipping to next: $e');
      rethrow;
    }
  }

  Future<Track> ensureTrackHasAudioUrl(Track track) async {
    if (track.audioUrl != null && track.audioUrl!.isNotEmpty) {
      return track;
    }

    throw Exception('Track must have audioUrl to play');
  }

  void dispose() {
    _playerEventsController.close();
  }
}
