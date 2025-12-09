import 'dart:convert';
import 'package:just_weather_app/just_weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String key = 'search_history';

  Future<void> saveSearch(String city, String region) async {
    final prefs = await SharedPreferences.getInstance();

    final rawList = prefs.getStringList(key) ?? [];

    final list = rawList
        .map<Map<String, String>>(
          (item) => Map<String, String>.from(jsonDecode(item)),
        )
        .toList();

    final exists = list.any(
      (item) => item["city"] == city && item["region"] == region,
    );
    if (!exists) {
      list.insert(0, {"city": city, "region": region});
    }

    if (list.length > 10) {
      list.removeRange(10, list.length);
    }

    final encodedList = list.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(key, encodedList);
  }

  Future<List<JwSearchResponse>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    return rawList.map((item) {
      final decoded = jsonDecode(item);
      return JwSearchResponse(name: decoded['city'], region: decoded['region']);
    }).toList();
  }

  Future<void> deleteItem(String city, String region) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    List<Map<String, String>> list = rawList
        .map<Map<String, String>>(
          (item) => Map<String, String>.from(jsonDecode(item)),
        )
        .toList();

    list.removeWhere(
      (item) => item["city"] == city && item["region"] == region,
    );

    final encodedList = list.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList(key, encodedList);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
