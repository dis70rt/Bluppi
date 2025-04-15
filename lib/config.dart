import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String apiURL = dotenv.env["API_URL"]!;
  static final String lasfmAPI = dotenv.env["LASTFM_API"]!;
}