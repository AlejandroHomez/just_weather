import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_weather_app/just_weather.dart';

import 'config/theme/theme_norifier.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    final themeMode = themeNotifier.getThemeMode() ?? ThemeMode.system;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      key: globalKey,
      title: 'Just Weather',
      themeMode: themeMode,
      darkTheme: JwThemeData.darkTheme,
      theme: JwThemeData.lightTheme,
      routes: AppRoutes.routes,
      initialRoute: JwSplashScreen.routeName,
      home: JwSplashScreen(),
    );
  }
}
