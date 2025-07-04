import 'package:dio/dio.dart';
import 'package:bluppi/config.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: AppConfig.apiURL,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 10),
  ),
);

// Future<Map<String, dynamic>> getAudioStreamUrl(String query) async {
//   final response = await dio.get(
//     '/audio-stream?q=$query',
//     options: Options(
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     ),
//   );

//   if (response.statusCode == 200) {
//     return response.data;
//   } else {
//     throw Exception('Failed to load audio stream URL');
//   }
// }

Future<Map<String, dynamic>> getAudioStreamUrl(String videoId) async {
  final response = await dio.get(
    '/audio-stream?id=$videoId',
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
    throw Exception('Failed to load audio stream URL');
  }
}