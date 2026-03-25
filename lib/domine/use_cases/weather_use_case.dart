import 'package:just_weather_app/just_weather.dart';

class JwWeatherUseCase {
  final JwWeatherGateway _weatherGateway;

  JwWeatherUseCase({required JwWeatherGateway weatherGateway})
    : _weatherGateway = weatherGateway;

  Future<({JwErrorItem? errorItem, JwWeatherResponse? forecastDay})>
  getForecastDay({required String city}) =>
      _weatherGateway.getForecastDay(city: city);

  Future<({JwErrorItem? errorItem, JwSearchDataListModel? searchDataListModel})>
  getSearchData({required String query}) =>
      _weatherGateway.getSearchData(query: query);

  Future<({JwErrorItem? errorItem, double? elevation})> getElevation({
    required JwLocation location,
  }) => _weatherGateway.getElevation(location: location);
}
