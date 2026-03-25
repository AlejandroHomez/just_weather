import 'package:just_weather_app/just_weather.dart';

class JwForecastDayMapper extends Mapper<JwForecastDay> {
  @override
  JwForecastDay fromMap(Map<String, dynamic> json) {
    return JwForecastDay(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      maxTempF: json['maxtemp_f'],
      minTempF: json['mintemp_f'],
    );
  }

  @override
  Map<String, dynamic>? toMap(JwForecastDay data) {
    return {
      'maxtemp_c': data.maxTempC,
      'mintemp_c': data.minTempC,
      'maxtemp_f': data.maxTempF,
      'mintemp_f': data.minTempF,
    };
  }
}