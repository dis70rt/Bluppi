import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/last_track_model.dart';

class SpotifyService {
  final Dio dio = Dio();
  final String? currentToken;
  // final WidgetRef ref;

  SpotifyService(this.currentToken) {
    dio.options
      ..baseUrl = 'https://api.spotify.com/v1/'
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 5)
      ..sendTimeout = const Duration(seconds: 5)
      ..headers['Content-Type'] = 'application/json';
  }

  Future<Response> _request(String path,
      {Map<String, dynamic>? queryParameters}) async {
    // final currentToken = ref.read(authProvider).value?.accessToken;

    if (currentToken == null) {
      throw Exception('No access token available');
    }

    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: {'Authorization': 'Bearer $currentToken'}),
    );
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final response = await _request('me');
      return response.data;
    } catch (e) {
      log('Error getting user profile: $e');
      return null;
    }
  }

  Future<LastTrack?> getLastPlayedSong() async {
    try {
      final response = await _request(
        'me/player/recently-played',
        queryParameters: {'limit': 1},
      );

      final String trackID = response.data['items'][0]['track']['id'];
      final String artistID =
          response.data['items'][0]['track']['artists'][0]['id'];

      final trackResponse = await _request('tracks/$trackID');
      final artistResponse = await _request('artists/$artistID');

      return LastTrack(
        id: trackID,
        name: trackResponse.data['name'],
        artist: Artist(
            id: artistID,
            name: artistResponse.data['name'],
            spotifyUrl: artistResponse.data["external_urls"]["spotify"],
            imageUrl: artistResponse.data['images'].isNotEmpty
                ? artistResponse.data['images'].last['url']
                : null
            ),
        duartion: Duration(milliseconds: trackResponse.data['duration_ms']),
        trackUrl: trackResponse.data['external_urls']['spotify'],
        imageUrl: trackResponse.data['album']['images'].isNotEmpty
            ? trackResponse.data['album']['images'].last['url']
            : null,
        previewUrl: trackResponse.data['preview_url'],
        playedAt: response.data['items'][0]['played_at'],
      );
    } catch (e, stack) {
      log('Unexpected error: $e', error: e, stackTrace: stack);
      return null;
    }
  }
}
