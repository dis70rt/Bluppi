import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/config.dart';

class Database {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiURL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );
  Future<void> writeTrack(Track track, int? duration) async {
    final postData = {
      'id': track.trackId,
      'artist': track.artistName,
      'title': track.trackName,
      'album': track.albumName,
      'image_url': track.imageUrl,
      'preview_url': track.previewUrl,
      'genres': track.genres,
      'listeners': track.listeners,
      'play_count': track.playcount,
      'duration': duration ?? 0,
      'popularity': track.popularityScore,
      'video_id': track.videoId ?? '',
    };

    await dio.post(
      '/write-track',
      data: jsonEncode(postData),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getTrack(String trackId) async {
    final response = await dio.get(
      '/track/$trackId',
      // queryParameters: {'id': trackId},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load track');
    }
  }

  Future<String> getUserId(String username) async {
    final response = await dio.get(
      '/user/$username',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data['id'];
    } else {
      throw Exception('Failed to load user ID');
    }
  }
}