import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:bluppi/config.dart';

class UserSearchResult {
  final List<Map<String, dynamic>> users;
  final int count;
  final int limit;
  final int offset;

  UserSearchResult({
    this.users = const [],
    this.count = 0,
    this.limit = 10,
    this.offset = 0,
  });
}

final _dioProvider = Provider((ref) => Dio(BaseOptions(
      baseUrl: AppConfig.apiURL,
      headers: {'Content-Type': 'application/json'},
    )));

final userSearchProvider =
    FutureProvider.family<UserSearchResult, String>((ref, query) async {
  if (query.isEmpty) {
    return UserSearchResult();
  }

  final dio = ref.read(_dioProvider);

  try {
    final response = await dio.get(
      '/users/search',
      queryParameters: {
        'q': query,
        'limit': 10,
        'offset': 0,
      },
    );

    final result = UserSearchResult(
      users: response.data["users"] is List
          ? List<Map<String, dynamic>>.from(response.data["users"])
          : [],
      count: response.data["total"] ?? 0,
      limit: 10,
      offset: 0,
    );
    return result;
  } on DioException catch (e) {
    throw 'Failed to search users: ${e.message}';
  } catch (e) {
    throw 'Exception when searching users: $e';
  }
});

// final userSearchPaginatedProvider = FutureProvider.family<UserSearchResult,
//     ({String query, int limit, int offset})>((ref, params) async {
//   if (params.query.isEmpty) {
//     return UserSearchResult(limit: params.limit, offset: params.offset);
//   }

//   final dio = ref.read(_dioProvider);

//   try {
//     final response = await dio.get(
//       '/users/search',
//       queryParameters: {
//         'q': params.query,
//         'limit': params.limit,
//         'offset': params.offset,
//       },
//     );
//     log("Response data: ${response.data}");
//     final List<Map<String, dynamic>> users =
//         List<Map<String, dynamic>>.from(response.data);

//     return UserSearchResult(
//       users: users,
//       limit: params.limit,
//       offset: params.offset,
//     );
//   } on DioException catch (e) {
//     throw 'Failed to search users: ${e.message}';
//   } catch (e) {
//     throw 'Exception when searching users: $e';
//   }
// });
