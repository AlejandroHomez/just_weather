import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  EnvConfig._();

  static final weatherApiKeyValue = 'WEATHER_API_KEY';

  static String get weatherApiKey {
    final key = dotenv.env[weatherApiKeyValue];
    if (key == null || key.isEmpty) {
      throw Exception('$weatherApiKeyValue not found in .env');
    }
    return key;
  }
}
