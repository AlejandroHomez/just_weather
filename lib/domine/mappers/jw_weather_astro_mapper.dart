import 'package:just_weather_app/just_weather.dart';

class JwWeatherAstroMapper extends Mapper<JwWeatherAstroModel> {
  @override
  JwWeatherAstroModel fromMap(Map<String, dynamic> json) {
    return JwWeatherAstroModel(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  @override
  Map<String, dynamic>? toMap(JwWeatherAstroModel data) {
    return {'sunrise': data.sunrise, 'sunset': data.sunset};
  }
}
