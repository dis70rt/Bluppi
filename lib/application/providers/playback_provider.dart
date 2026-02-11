import 'package:riverpod/riverpod.dart';

class PlaybackState {
  final String? playingTrackId;
  const PlaybackState({this.playingTrackId});
}

class PlaybackNotifier extends Notifier<PlaybackState> {
  @override
  PlaybackState build() => const PlaybackState();

  void play(String trackId) {
    state = PlaybackState(playingTrackId: trackId);
  }

  void stop() {
    state = const PlaybackState();
  }

  void toggle(String trackId) {
    if (state.playingTrackId == trackId) {
      stop();
    } else {
      play(trackId);
    }
  }
}

final playbackProvider =
    NotifierProvider<PlaybackNotifier, PlaybackState>(
  PlaybackNotifier.new,
);