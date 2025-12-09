import 'package:just_weather_app/just_weather.dart';

class JwSearchResponseMapper extends Mapper<JwSearchResponse> {
  @override
  JwSearchResponse fromMap(Map<String, dynamic> json) {
    return JwSearchResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      region: json['region'],
      country: json['country'],
      tempC: (json['temp_c'] is num)
          ? (json['temp_c'] as num).toDouble()
          : null,
      condition: json['condition'] != null
          ? WeatherCondition(
              text: json['condition']['text'],
              icon: json['condition']['icon'],
              code: json['condition']['code'],
            )
          : null,
      lat: (json['lat'] is int) ? (json['lat'] as int).toDouble() : json['lat'],
      lon: (json['lon'] is int) ? (json['lon'] as int).toDouble() : json['lon'],
    );
  }

  @override
  Map<String, dynamic>? toMap(JwSearchResponse data) {
    return {
      'id': data.id,
      'name': data.name,
      'region': data.region,
      'country': data.country,
      'lat': data.lat,
      'lon': data.lon,
      'temp_c': data.tempC,
      'condition': data.condition,
    };
  }
}
