import 'dart:async';
import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/audio/player_handler.dart';
import 'package:bluppi/data/grpc/repositories/playback_stream_service.dart';
import 'package:bluppi/domain/models/playback_stream_model.dart';
import 'package:bluppi/domain/repositories/playback_stream_repository.dart';
import 'package:bluppi/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playbackStreamProvider =
    NotifierProvider.family<
      PlaybackStreamNotifier,
      PlaybackStateModel?,
      String
    >(PlaybackStreamNotifier.new);

class PlaybackStreamNotifier extends Notifier<PlaybackStateModel?> {
  final String roomId;
  StreamSubscription<PlaybackStateModel>? _serverSub;
  Timer? _scheduledPlayTimer;

  PlaybackStreamNotifier(this.roomId);

  PlaybackStreamRepository get _repo => ref.read(playbackStreamServiceProvider);
  PlayerHandler get _handler => audioHandler as PlayerHandler;

  int get _serverNowUs {
    final clock = ref.read(clockDisciplineProvider);
    final clientNowUs = DateTime.now().microsecondsSinceEpoch;
    return (clientNowUs * clock.alpha + clock.thetaUs).round();
  }

  @override
  PlaybackStateModel? build() {
    ref.onDispose(() {
      _serverSub?.cancel();
      _scheduledPlayTimer?.cancel();
    });

    _initRoom(roomId);
    return null;
  }

  void _initRoom(String roomId) {
    final userId = ref.read(userProvider).value?.id;

    _serverSub = _repo
        .joinRoom(roomId, userId!)
        .listen(
          _handleServerState,
          onError: (err) => log("Playback Stream Error: $err"),
        );
  }

  Future<void> _handleServerState(PlaybackStateModel newState) async {
    final oldState = state;
    state = newState;

    log(
      'Server State: track=${newState.track.id}, isPlaying=${newState.isPlaying}, '
      'posMs=${newState.positionMs}, version=${newState.version}, '
      'schedStartUs=${newState.scheduledStartServerUs}',
      name: 'StreamProvider',
    );

    if (oldState == null || oldState.track.id != newState.track.id) {
      log(
        'Track Change Detected! Loading: ${newState.track.title}',
        name: 'StreamProvider',
      );

      _scheduledPlayTimer?.cancel();

      final newTrack = newState.track;
      final item = MediaItem(
        id: newTrack.id,
        title: newTrack.title,
        artist: newTrack.artist,
        artUri: Uri.tryParse(newTrack.artworkUrl),
        duration: Duration(milliseconds: newTrack.durationMs),
        extras: {'trackId': newTrack.id, 'audioUrl': newTrack.audioUrl},
      );

      try {
        await _handler.loadMediaItem(item);
        log(
          'Track loaded successfully in local player.',
          name: 'StreamProvider',
        );
        _repo.sendBufferReady(newState.version);
        log(
          'Sent BufferReady to server for version: ${newState.version}',
          name: 'StreamProvider',
        );
      } catch (e) {
        log("Error loading track: $e");
      }
      return;
    }

    if (newState.isPlaying && (!oldState.isPlaying)) {
      log('Server says PLAY', name: 'StreamProvider');
      _scheduleFuturePlayback(newState);
      return;
    }

    if (!newState.isPlaying && (oldState.isPlaying)) {
      log(
        'Server says PAUSE at ${newState.positionMs}ms',
        name: 'StreamProvider',
      );
      _scheduledPlayTimer?.cancel();
      await _handler.pause();
      await _handler.seek(Duration(milliseconds: newState.positionMs));
      return;
    }

    log('Server state update (no action change)', name: 'StreamProvider');
  }

  void _scheduleFuturePlayback(PlaybackStateModel newState) {
    _scheduledPlayTimer?.cancel();

    final serverNow = _serverNowUs;
    final targetUs = newState.scheduledStartServerUs;
    final delayUs = targetUs - serverNow;

    log(
      'Schedule: serverNow=$serverNow, targetUs=$targetUs, delayUs=$delayUs (${delayUs ~/ 1000}ms)',
      name: 'StreamProvider',
    );

    final startPos = Duration(milliseconds: newState.positionMs);
    _handler.seek(startPos);

    const int maxFutureWaitUs = 5 * 1000 * 1000;
    const int driftToleranceUs = 40 * 1000;

    if (delayUs > 0 && delayUs < maxFutureWaitUs) {
      log('Scheduling play in ${delayUs ~/ 1000}ms', name: 'StreamProvider');

      final waitDuration = Duration(
        microseconds: delayUs > 100000 ? delayUs - 50000 : 0,
      );
      _scheduledPlayTimer = Timer(waitDuration, () {
        while (_serverNowUs < targetUs) {}
        _handler.play();
        log('Exact-fire play triggered', name: 'StreamProvider');
      });
    } else if (delayUs <= 0) {
      final latenessUs = -delayUs;
      if (latenessUs > driftToleranceUs) {
        final catchUpMs = newState.positionMs + (latenessUs ~/ 1000);
        log(
          'Late by ${latenessUs ~/ 1000}ms (echo territory). Skipping to $catchUpMs ms',
          name: 'StreamProvider',
        );
        _handler.seek(Duration(milliseconds: catchUpMs));
      } else {
        log(
          'Late by ${latenessUs ~/ 1000}ms (within tolerance). Playing immediately.',
          name: 'StreamProvider',
        );
      }
      _handler.play();
    } else {
      log(
        'WARNING: delayUs=$delayUs too large, playing immediately',
        name: 'StreamProvider',
      );
      _handler.play();
    }
  }

  void play() => _repo.sendPlay();
  void pause() => _repo.sendPause();

  void changeTrack(PlaybackTrackModel newTrack) =>
      _repo.sendTrackChange(newTrack);
}
