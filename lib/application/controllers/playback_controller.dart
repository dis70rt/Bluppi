import 'package:bluppi/application/providers/music/playback_provider.dart';
import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/application/providers/music/track_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:riverpod/riverpod.dart';

class TrackActionController extends Notifier<void> {
  @override
  void build() {}

  Future<void> playOrToggleTrack({
    required String trackId,
    required bool isCurrentTrack,
    required void Function(String) onError,
  }) async {
    final currentRoom = ref.read(currentRoomProvider);
    final currentUser = ref.read(userProvider).value;

    if (currentRoom != null && currentRoom.hostUserId != currentUser?.id) {
      onError("Only the host can change tracks.");
      return;
    }

    final playback = ref.read(playerProvider.notifier);
    final queue = ref.read(queueProvider.notifier);
    final playerStatus = ref.read(playerProvider).status;

    if (!isCurrentTrack) {
      try {
        final fullTrack = await ref.read(trackProvider(trackId).future);
        queue.setQueue([fullTrack], QueueSource.user);
      } catch (e) {
        onError("Failed to load track details.");
      }
      return;
    }

    if (playerStatus == PlaybackStatus.playing) {
      playback.pause();
    } else {
      playback.play();
    }
  }
}

final trackActionControllerProvider = NotifierProvider<TrackActionController, void>(
  TrackActionController.new,
);