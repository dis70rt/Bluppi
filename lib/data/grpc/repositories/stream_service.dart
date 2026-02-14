import 'package:dio/dio.dart';
import 'package:bluppi/domain/repositories/stream_repository.dart';

class StreamServiceRepository implements StreamRepository {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:  "http://localhost:8001", // "https://bluppi.saikat.in/api/v2",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  @override
  Future<String> getStreamURL(String artist, String title, String trackId) async {
    try {
      final res = await _dio.get(
        "/search",
        queryParameters: {
          "artist": artist,
          "title": title,
          "track_id": trackId,
        },
      );

      return res.data["audio_url"];
    } on DioException catch (e) {
      throw Exception("Search failed: ${e.response?.data ?? e.message}");
    }
  }

  @override
  Future<String> getStreamURLByVideoId(String videoId) async {
    try {
      final res = await _dio.get("/audio/$videoId");

      return res.data["audio_url"];
    } on DioException catch (e) {
      throw Exception("Audio lookup failed: ${e.response?.data ?? e.message}");
    }
  }
}
