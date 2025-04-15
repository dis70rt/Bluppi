import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/config.dart';


final String _lastFmApiKey = AppConfig.lasfmAPI;
const String _lastFmBaseUrl = 'http://ws.audioscrobbler.com/2.0/';
const String _itunesBaseUrl = 'https://itunes.apple.com/search';

class TrackRepository {
  final Dio _dio;

  TrackRepository(this._dio);

  Future<List<Track>> searchItunesTracks(String query) async {
    // try {
    final _response = await _dio.get(
      _itunesBaseUrl,
      queryParameters: {
        'term': query,
        'media': 'music',
        'entity': 'song',
        'limit': 25,
      },
    );
    // log("Response: ${response.data.runtimeType}");
    final response = jsonDecode(_response.data);
    if (_response.statusCode == 200 &&
        _response.data != null &&
        response['results'] != null) {
      final results = response['results'] as List<dynamic>? ?? [];
      return results
          .map((json) => Track.fromItunesJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load tracks from iTunes');
    }
    // } on DioException catch (e) {
    //   throw Exception('Network error searching iTunes: ${e.message}');
    // } catch (e) {
    //   throw Exception('Error parsing iTunes response: $e');
    // }
  }

  Future<Map<String, String?>?> fetchLastFmTrackInfo(
      String artist, String trackName) async {
    if (_lastFmApiKey == 'YOUR_LASTFM_API_KEY') {
      print("Warning: Last.fm API key not set. Skipping enrichment.");
      return null;
    }
    try {
      final response = await _dio.get(
        _lastFmBaseUrl,
        queryParameters: {
          'method': 'track.getInfo',
          'api_key': _lastFmApiKey,
          'artist': artist,
          'track': trackName,
          'format': 'json',
          'autocorrect': 1,
        },
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['track'] != null) {
        final trackData = response.data['track'] as Map<String, dynamic>;
        return {
          'listeners': trackData['listeners'] as String?,
          'playcount': trackData['playcount'] as String?,
          'url': trackData['url'] as String?,
        };
      } else if (response.data != null && response.data['error'] != null) {
        return null;
      } else {
        return null;
      }
    } on DioException catch (e) {
      print('Network error fetching Last.fm info: ${e.message}');
      return null;
    } catch (e) {
      print('Error parsing Last.fm track info response: $e');
      return null;
    }
  }

  Future<List<Track>> fetchTopTracksByGenre(String genre,
      {int limit = 10}) async {
    if (_lastFmApiKey == 'YOUR_LASTFM_API_KEY') {
      print("Warning: Last.fm API key not set. Skipping genre suggestions.");
      return [];
    }
    if (genre.isEmpty) return [];

    try {
      final response = await _dio.get(
        _lastFmBaseUrl,
        queryParameters: {
          'method': 'tag.getTopTracks',
          'tag': genre,
          'api_key': _lastFmApiKey,
          'format': 'json',
          'limit': limit,
        },
      );

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['toptracks']?['track'] != null) {
        final results =
            response.data['toptracks']['track'] as List<dynamic>? ?? [];
        return results
            .map((json) =>
                Track.fromLastFmTopTrackJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print(
            'Could not fetch top tracks for genre: $genre. Response: ${response.data}');
        return [];
      }
    } on DioException catch (e) {
      print('Network error fetching top tracks by genre: ${e.message}');
      return [];
    } catch (e) {
      print('Error parsing Last.fm top tracks response: $e');
      return [];
    }
  }
}
