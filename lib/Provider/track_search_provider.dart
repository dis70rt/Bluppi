import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/config.dart';

final dioProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: AppConfig.apiURL,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  );
  return Dio(options);
});

class TrackRepository {
  final Dio _dio;

  TrackRepository(this._dio);

  Future<List<Track>> searchTracks(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = '/search?query=$encodedQuery';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200 && response.data != null) {
        final searchResponse =
            TrackSearchResponse.fromJson(response.data as Map<String, dynamic>);

        return searchResponse.results;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'API request failed with status ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      log('DioError fetching tracks for query "$query": ${e.message}');

      rethrow;
    } catch (e) {
      log('Error processing track search response for query "$query": $e');
      rethrow;
    }
  }
}

final trackRepositoryProvider = Provider<TrackRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return TrackRepository(dio);
});

final trackSearchProvider = FutureProvider.family<List<Track>, String>(
  (ref, query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    final repository = ref.watch(trackRepositoryProvider);

    return repository.searchTracks(query);
  },
  name: 'trackSearchProvider',
);
