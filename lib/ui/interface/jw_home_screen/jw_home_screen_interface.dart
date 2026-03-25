import 'package:just_weather_app/just_weather.dart';

abstract class JwHomeScreenInterface {
  Future<void> getCurrentWeather(JwWeatherResponse currentWeather);
  Future<void> getElevation(double elevation);
  void showSkeleton();
  void showAlert(JwErrorItem error);
}
