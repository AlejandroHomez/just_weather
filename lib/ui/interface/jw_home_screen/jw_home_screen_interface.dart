import 'package:just_weather_app/just_weather.dart';

abstract class JwHomeScreenInterface {
  Future<void> getCurrentWeather(JwWeatherResponse currentWeather);
  void showSkeleton();
  void showAlert(JwErrorItem error);
}
