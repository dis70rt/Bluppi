import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/last_track_model.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';
import 'package:synqit/Data/Services/firebase_services.dart';
import 'package:synqit/config.dart';

class UserServices {
  final database = Database();
  final firebaseServices = FirebaseServices();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiURL, // Replace with your API URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Map<String, dynamic>?> getLastPlayedSong() async {
    final doc = await firebaseServices.getLastPlayedTrack();
    final trackId = doc?['trackId'];
    if (trackId != null) {
      final data = await database.getTrack(trackId.toString());
      if (data.isNotEmpty) {
        final track = Track.fromJson(data['track']);
        return {
          "track": track,
          "lastPlayed": doc!['lastPlayed'],
        };
      } else {
        log("No track found with ID: $trackId");
        return null;
      }
    } else {
      log("No last played track found.");
      return null;
    }
  }
}
