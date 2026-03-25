import 'package:just_weather_app/just_weather.dart';

abstract class JwWeatherGateway {
  Future<({JwErrorItem? errorItem, JwWeatherResponse? forecastDay})>
  getForecastDay({required String city});

  Future<({JwErrorItem? errorItem, JwSearchDataListModel? searchDataListModel})>
  getSearchData({required String query});

  Future<({JwErrorItem? errorItem, double? elevation})> getElevation({
    required JwLocation location,
  });
}
