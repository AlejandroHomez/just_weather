import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_weather_app/just_weather.dart';

class WeatherApi implements JwWeatherGateway {
  @override
  Future<({JwErrorItem? errorItem, JwWeatherResponse? forecastDay})>
  getForecastDay({required String city}) async {
    try {
      final Map<String, dynamic> currentResponse =
          await _getForecastDayResponse(city);

      final response = JwWeatherResponseMapper().fromMap(currentResponse);

      return (errorItem: null, forecastDay: response);
    } catch (e) {
      return (errorItem: JwErrorItem(), forecastDay: null);
    }
  }

  Future<Map<String, dynamic>> _getForecastDayResponse(String city) async {
    final String apiKey = EnvConfig.weatherApiKey;
    final String defaultDay = '1';
    final String alerts = 'no';
    final String aqi = 'no';

    final uri = Uri.parse(
      '${EndpointsApi.getUrlForecastDay()}?key=$apiKey&q=$city&days=$defaultDay&aqi=$aqi&alerts=$alerts&lang=es',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Weather API error: ${response.body}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  Future<({JwErrorItem? errorItem, JwSearchDataListModel? searchDataListModel})>
  getSearchData({required String query}) async {
    try {
      final Map<String, dynamic> currentResponse = await _getSearchResponse(
        query,
      );

      final response = JwSearchDataListMapper().fromMap(currentResponse);

      return (errorItem: null, searchDataListModel: response);
    } catch (e) {
      return (
        errorItem: JwErrorItem(code: JwConstants.EMPTY_SEARCH_RESULT),
        searchDataListModel: null,
      );
    }
  }

  Future<Map<String, dynamic>> _getSearchResponse(String query) async {
    final String apiKey = EnvConfig.weatherApiKey;
    final tempCRequired = "temp_c";
    final conditionRequired = "condition";

    final String currentFields = "$tempCRequired,$conditionRequired";

    final uri = Uri.parse(
      '${EndpointsApi.getUrlSearch()}?key=$apiKey&q=$query&current_fields=$currentFields&lang=es',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Weather API error: ${response.body}');
    }

    return {"data": jsonDecode(response.body)};
  }
}
