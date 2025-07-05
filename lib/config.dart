import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String apiURL = dotenv.env["API_URL"]!;
  static final String lasfmAPI = dotenv.env["LASTFM_API"]!;
  static final String appUrl = dotenv.env["APP_URL"]!;
  static final String socketUrl = dotenv.env["SOCKET_URL"]!;
  static final String httpSocketUrl = dotenv.env["HTTP_SOCKET_URL"]!;
}