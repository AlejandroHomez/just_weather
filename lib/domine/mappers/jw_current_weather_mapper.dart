import 'package:just_weather_app/just_weather.dart';

class JwCurrentWeatherMapper extends Mapper<JwCurrentWeather> {
  @override
  JwCurrentWeather fromMap(Map<String, dynamic> json) {
    return JwCurrentWeather(
      tempC: (json['temp_c'] as num).toDouble(),
      tempF: (json['temp_f'] as num).toDouble(),
      isDay: json['is_day'] == 1,
      condition: WeatherCondition(
        text: json['condition']['text'],
        icon: json['condition']['icon'],
        code: json['condition']['code'],
      ),
      windMph: (json['wind_mph'] as num).toDouble(),
      windKph: (json['wind_kph'] as num).toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: (json['pressure_mb'] as num).toDouble(),
      pressureIn: (json['pressure_in'] as num).toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelsLikeC: (json['feelslike_c'] as num).toDouble(),
      feelsLikeF: (json['feelslike_f'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
      dateTime: json['time'],
      visKm: (json['vis_km'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic>? toMap(JwCurrentWeather data) {
    return {
      'temp_c': data.tempC,
      'temp_f': data.tempF,
      'is_day': data.isDay ? 1 : 0,
      'condition': {
        'text': data.condition.text,
        'icon': data.condition.icon,
        'code': data.condition.code,
      },
      'wind_mph': data.windMph,
      'wind_kph': data.windKph,
      'wind_degree': data.windDegree,
      'wind_dir': data.windDir,
      'pressure_mb': data.pressureMb,
      'pressure_in': data.pressureIn,
      'humidity': data.humidity,
      'cloud': data.cloud,
      'feelslike_c': data.feelsLikeC,
      'feelslike_f': data.feelsLikeF,
      'uv': data.uv,
      'vis_km': data.visKm,
      'time': data.dateTime,
    };
  }
}
