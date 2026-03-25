import 'package:just_weather_app/just_weather.dart';

class JwHomeScreenPresenter {
  final JwHomeScreenInterface _interface;
  final JwWeatherConfig config;

  JwHomeScreenPresenter(this._interface, this.config);

  Future<void> getCurrentWeather(String city) async {
    _interface.showSkeleton();
    final response = await config.weatherUseCase.getForecastDay(city: city);

    if (response.errorItem != null) {
      _interface.showAlert(response.errorItem!);
    }

    if (response.forecastDay != null) {
      _interface.getCurrentWeather(response.forecastDay!);
    }
  }

  Future<void> getElevation(JwLocation location) async {
    _interface.showSkeleton();
    final response = await config.weatherUseCase.getElevation(
      location: location,
    );

    if (response.elevation != null) {
      _interface.getElevation(response.elevation!);
    }
  }
}
