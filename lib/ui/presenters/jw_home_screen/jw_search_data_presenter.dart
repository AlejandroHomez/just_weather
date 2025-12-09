import 'package:just_weather_app/just_weather.dart';

class JwSearchDataPresenter {
  final JwSearchHomeScreenInterface _interface;
  final JwWeatherConfig config;

  JwSearchDataPresenter(this._interface, this.config);

  Future<void> getSearchResult(String query) async {
    final response = await config.weatherUseCase.getSearchData(query: query);
    final JwErrorItem? errorItem = response.errorItem;
    final JwSearchDataListModel? searchDataListModel =
        response.searchDataListModel;

    if (errorItem != null) {
      errorItem.code == JwConstants.EMPTY_SEARCH_RESULT
          ? _interface.emptyData(true)
          : _interface.showError(true);
    }

    if (response.searchDataListModel != null) {
      _interface.getSearchData(searchDataListModel!);
    }
  }

  Future<void> getCurrentWeather(String city) async {
    final response = await config.weatherUseCase.getForecastDay(city: city);

    if (response.forecastDay != null) {
      _interface.updateWeatherState(response.forecastDay!);
    }
  }

  Future<void> updateHistory() async {
    _interface.updateHistory();
  }
}
