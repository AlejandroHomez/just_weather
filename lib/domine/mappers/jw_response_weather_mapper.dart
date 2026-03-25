import 'package:just_weather_app/domine/mappers/jw_forecast_day_mapper.dart';
import 'package:just_weather_app/just_weather.dart';

class JwWeatherResponseMapper extends Mapper<JwWeatherResponse> {
  @override
  JwWeatherResponse fromMap(Map<String, dynamic> json) {
    final Map<String, dynamic> forecastDay = json['forecast']['forecastday'][0];

    final List<dynamic> hour = forecastDay['hour'];
    final Map<String, dynamic> astro = forecastDay['astro'];
    final Map<String, dynamic> day = forecastDay['day'];

    return JwWeatherResponse(
      location: JwLocationMapper().fromMap(json['location']),
      current: JwCurrentWeatherMapper().fromMap(json['current']),
      astro: JwWeatherAstroMapper().fromMap(astro),
      forecastDay: JwForecastDayMapper().fromMap(day),
      forecastDayList: hour
          .map((item) => JwCurrentWeatherMapper().fromMap(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toMap(JwWeatherResponse data) {
    return {
      'location': data.location,
      'current': data.current,
      'forecastDayList': data.forecastDayList,
    };
  }
}
