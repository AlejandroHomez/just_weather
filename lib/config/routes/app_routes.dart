import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class AppRoutes {
  static const String home = JwHomeScreen.roteName;
  static const String settings = JwSettingsScreen.routeName;
  static const String splash = JwSplashScreen.routeName;
  static const String notFound = '/404';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const JwSplashScreen(),
    home: (_) => const JwHomeScreen(),
    settings: (_) => const JwSettingsScreen(),
  };
}
