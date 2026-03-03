import 'package:bluppi/domain/models/playback_stream_model.dart';

abstract class PlaybackStreamRepository {
  Stream<PlaybackStateModel> joinRoom(String roomId, String userId);
  void sendPlay();
  void sendPause();
  void sendBufferReady(int version);
  void sendTrackChange(PlaybackTrackModel track);
  void leaveRoom();
}