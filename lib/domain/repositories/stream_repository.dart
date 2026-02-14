abstract class StreamRepository {
  Future<String> getStreamURL(String artist, String title, String trackId);
  Future<String> getStreamURLByVideoId(String videoId);
}