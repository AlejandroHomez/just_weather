import 'package:just_weather_app/just_weather.dart';

class JwWeatherResponse {
  final JwLocation location;
  final JwCurrentWeather current;
  final JwWeatherAstroModel astro;
  final List<JwCurrentWeather> forecastDayList;

  JwWeatherResponse({
    required this.location,
    required this.current,
    required this.astro,
    required this.forecastDayList,
  });
}
