import 'package:just_weather_app/just_weather.dart';

class JwSearchResponse {
  final String name;
  final int? id;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final double? tempC;
  final WeatherCondition? condition;

  JwSearchResponse({
    required this.name,
    this.id,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tempC,
    this.condition,
  });
}
