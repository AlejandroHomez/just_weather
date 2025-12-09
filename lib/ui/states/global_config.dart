import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_weather_app/just_weather.dart';

final servicesConfigProvider = Provider<JwWeatherConfig>((ref) {
  return JwWeatherConfig(weatherGateway: WeatherApi());
});
