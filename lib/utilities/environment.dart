import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

///It reads the API URL from the environment
class Environment {
  ///getter for the filename depends on if it is release or production
  static String get fileName =>
      kReleaseMode ? ".env.production" : ".env.development";

  ///return the api url from the environment file
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
}
