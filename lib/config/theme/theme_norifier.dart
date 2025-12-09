import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_weather_app/just_weather.dart';

final themeNotifierProvider = ChangeNotifierProvider<JwThemeNotifier>((ref) {
  final notifier = JwThemeNotifier();
  notifier.getSystemPreferences(); // ← carga el tema guardado
  return notifier;
});
