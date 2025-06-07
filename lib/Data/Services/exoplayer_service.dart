import 'dart:async';
import 'package:flutter/services.dart';

class ExoPlayerService {
  static const MethodChannel _channel = MethodChannel('synqit/exo_player');
  
  // Stream controllers to mimic just_audio streams
  final StreamController<PlayerState> _playerStateController = StreamController<PlayerState>.broadcast();
  final StreamController<Duration> _positionController = StreamController<Duration>.broadcast();
  final StreamController<Duration> _bufferedPositionController = StreamController<Duration>.broadcast();
  final StreamController<Duration?> _durationController = StreamController<Duration?>.broadcast();
  final StreamController<int?> _currentIndexController = StreamController<int?>.broadcast();
  final StreamController<SequenceState?> _sequenceStateController = StreamController<SequenceState?>.broadcast();

  // Public streams
  Stream<PlayerState> get playerStateStream => _playerStateController.stream;
  Stream<Duration> get positionStream => _positionController.stream;
  Stream<Duration> get bufferedPositionStream => _bufferedPositionController.stream;
  Stream<Duration?> get durationStream => _durationController.stream;
  Stream<int?> get currentIndexStream => _currentIndexController.stream;
  Stream<SequenceState?> get sequenceStateStream => _sequenceStateController.stream;

  // Player properties
  bool _playing = false;
  bool get playing => _playing;
  
  Duration _position = Duration.zero;
  Duration get position => _position;
  
  Duration _bufferedPosition = Duration.zero;
  Duration get bufferedPosition => _bufferedPosition;
  
  Duration? _duration;
  Duration? get duration => _duration;
  
  int? _currentIndex;
  int? get currentIndex => _currentIndex;
  
  bool get hasNext => _currentIndex != null && _playlist != null && _currentIndex! < _playlist!.children.length - 1;
  bool get hasPrevious => _currentIndex != null && _currentIndex! > 0;
  
  ConcatenatingAudioSource? _playlist;

  ExoPlayerService() {
    _setupMethodCallHandler();
    init();
  }
  
  Future<void> init() async {
    await _channel.invokeMethod('init');
  }

  void _setupMethodCallHandler() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onPlayerStateChanged':
          final isPlaying = call.arguments['playing'] as bool;
          final processingState = _mapProcessingState(call.arguments['processingState'] as String);
          _playing = isPlaying;
          _playerStateController.add(PlayerState(playing: isPlaying, processingState: processingState));
          break;
        
        case 'onPositionChanged':
          final position = Duration(milliseconds: call.arguments['position'] as int);
          _position = position;
          _positionController.add(position);
          break;
        
        case 'onBufferedPositionChanged':
          final buffered = Duration(milliseconds: call.arguments['bufferedPosition'] as int);
          _bufferedPosition = buffered;
          _bufferedPositionController.add(buffered);
          break;
        
        case 'onDurationChanged':
          final durationMs = call.arguments['duration'] as int?;
          final duration = durationMs != null ? Duration(milliseconds: durationMs) : null;
          _duration = duration;
          _durationController.add(duration);
          break;
        
        case 'onCurrentIndexChanged':
          final index = call.arguments['index'] as int?;
          _currentIndex = index;
          _currentIndexController.add(index);
          
          if (index != null && _playlist != null) {
            _sequenceStateController.add(SequenceState(
              sequence: _playlist!.sequence,
              currentIndex: index,
            ));
          }
          break;
          
        case 'onMediaItemChanged':
          // You can handle additional media item change events here if needed
          break;
      }
      return null;
    });
  }

  Future<void> setAudioSource(
    ConcatenatingAudioSource source, {
    bool preload = true,
    int? initialIndex,
  }) async {
    _playlist = source;
    
    final audioSourceList = source.sequence.map((audioSource) {
      if (audioSource is UriAudioSource) {
        return {
          'type': 'uri',
          'uri': audioSource.uri.toString(),
        };
      }
      return null;
    }).where((item) => item != null).toList();
    
    await _channel.invokeMethod('setAudioSources', {
      'audioSources': audioSourceList,
      'preload': preload,
      'initialIndex': initialIndex ?? 0,
    });
  }

  Future<void> play() async {
    await _channel.invokeMethod('play');
    _playing = true;
  }

  Future<void> pause() async {
    await _channel.invokeMethod('pause');
    _playing = false;
  }

  Future<void> stop() async {
    await _channel.invokeMethod('stop');
    _playing = false;
  }

  Future<void> seek(Duration position, {int? index}) async {
    await _channel.invokeMethod('seek', {
      'position': position.inMilliseconds,
      'index': index,
    });
  }

  Future<bool> seekToNext() async {
    final result = await _channel.invokeMethod<bool>('seekToNext');
    return result ?? false;
  }

  Future<bool> seekToPrevious() async {
    final result = await _channel.invokeMethod<bool>('seekToPrevious');
    return result ?? false;
  }

  ProcessingState _mapProcessingState(String state) {
    switch (state) {
      case 'idle':
        return ProcessingState.idle;
      case 'loading':
        return ProcessingState.loading;
      case 'buffering':
        return ProcessingState.buffering;
      case 'ready':
        return ProcessingState.ready;
      case 'completed':
        return ProcessingState.completed;
      default:
        return ProcessingState.idle;
    }
  }

  void dispose() {
    _playerStateController.close();
    _positionController.close();
    _bufferedPositionController.close();
    _durationController.close();
    _currentIndexController.close();
    _sequenceStateController.close();
    _channel.invokeMethod('dispose');
  }
}

// Classes to mimic just_audio types
class PlayerState {
  final bool playing;
  final ProcessingState processingState;
  
  PlayerState({
    required this.playing,
    required this.processingState,
  });
}

enum ProcessingState {
  idle,
  loading,
  buffering,
  ready,
  completed,
}

class ConcatenatingAudioSource {
  final List<AudioSource> children;
  List<AudioSource> get sequence => children;
  
  ConcatenatingAudioSource({required this.children});
  
  Future<void> add(AudioSource source) async {
    children.add(source);
    // Implement native add functionality
  }
}

abstract class AudioSource {}

class UriAudioSource extends AudioSource {
  final Uri uri;
  UriAudioSource(this.uri);
}

class SequenceState {
  final List<AudioSource> sequence;
  final int currentIndex;
  
  SequenceState({
    required this.sequence,
    required this.currentIndex,
  });
}