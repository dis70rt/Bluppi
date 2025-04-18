import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/config.dart';

class Database {
  final Dio dio = Dio();
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
      'youtube_url': track.ytUrl ?? '',
    };

    log(postData.toString());
    final response = await dio.post(
      '${AppConfig.apiURL}/write_track',
      data: jsonEncode(postData),
    );
    log("[Response] ${response.statusCode}");
  }
}