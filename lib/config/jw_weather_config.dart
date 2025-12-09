import 'package:just_weather_app/just_weather.dart';

class JwWeatherConfig {
  final JwWeatherUseCase weatherUseCase;

  JwWeatherConfig({required JwWeatherGateway weatherGateway})
    : weatherUseCase = JwWeatherUseCase(weatherGateway: weatherGateway);
}
