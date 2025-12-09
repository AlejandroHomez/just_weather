import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_weather_app/just_weather.dart';

part 'jw_weather_state.g.dart';

@riverpod
class JwWeatherState extends _$JwWeatherState {
  @override
  JwWeatherResponse? build() {
    return null;
  }

  void setCity(JwWeatherResponse city) {
    state = city;
  }

  void clear() {
    state = null;
  }

  void updateCity(JwWeatherResponse newData) {
    state = newData;
  }
}
