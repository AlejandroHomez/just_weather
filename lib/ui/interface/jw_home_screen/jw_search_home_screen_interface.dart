import 'package:just_weather_app/just_weather.dart';

abstract class JwSearchHomeScreenInterface {
  Future<void> getSearchData(JwSearchDataListModel searchData);
  void updateWeatherState(JwWeatherResponse weatherResponse);
  void showError(bool showError);
  void loading(bool isLoading);
  void emptyData(bool isEmptyData);
  void updateHistory();
}
