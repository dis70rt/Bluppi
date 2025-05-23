import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/config.dart';

class ApiServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiURL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Track?> getNextRecommendedTrack({required String artist, required String track}) async {
    try {
      final encodedArtist = Uri.encodeComponent(artist);
      final encodedTrack = Uri.encodeComponent(track);
      final response = await dio.get(
        '/recommendations?artist=$encodedArtist&track=$encodedTrack',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Track.fromJson(response.data['recommendation']);
      } else {
        log("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error fetching next recommended track: $e");
      return null;
    }
  }

  // Future<Track?> getNextRecommendatedTrack(Track track) async {
  //   final recommeded = await getNextRecommended(track.artistName, track.trackName);
  //   try {
  //     final encodedQuery = Uri.encodeComponent("${recommeded!['artist']} - ${recommeded['track']}");
  //     final response = await dio.get(
  //       '/search?query=$encodedQuery&limit=1',
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data['results'][0];
  //       if (data != null) {
  //         final track = Track.fromJson(data);
  //         return track;
  //       } else {
  //         log("No recommended track found.");
  //         return null;
  //       }
  //     } else {
  //       log("Error: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     log("Error fetching next recommended track: $e");
  //     return null;
  //   }
  // } 
}
