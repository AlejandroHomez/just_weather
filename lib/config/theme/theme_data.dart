import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_weather_app/config/theme/jw_colors.dart';

class JwThemeData {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: JwColors.JW_STATUS_GENERIC,
    primaryColor: JwColors.JW_PRIMARY_BLACK,
    cardColor: JwColors.JW_PRIMARY_WHITE,
    brightness: Brightness.light,
    focusColor: JwColors.JW_PRIMARY_BLACK,
    appBarTheme: _getAppBarTheme(),
    colorScheme: _getColorScheme().copyWith(
      secondary: JwColors.JW_STATUS_GENERIC,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: JwColors.JW_PRIMARY_BLACK,
    ),
    fontFamily: 'NotoSans',
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: JwColors.JW_PRIMARY_BLACK,
    primaryColor: JwColors.JW_PRIMARY_BLACK,
    cardColor: JwColors.JW_SCALE_PRIMARY,
    brightness: Brightness.dark,
    focusColor: JwColors.JW_PRIMARY_WHITE,
    appBarTheme: _getAppBarThemeDark(),
    colorScheme: _getColorSchemeDark().copyWith(
      secondary: JwColors.JW_SCALE_PRIMARY,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: JwColors.JW_PRIMARY_WHITE,
    ),
    fontFamily: 'NotoSans',
  );

  static ColorScheme _getColorScheme() {
    return const ColorScheme.light(
      primary: JwColors.JW_PRIMARY_BLACK,
      secondary: JwColors.JW_SECONDARY_BLUE,
      surface: JwColors.JW_STATUS_GENERIC,
      // ignore: deprecated_member_use
      background: JwColors.JW_STATUS_GENERIC,
      error: JwColors.JW_SECONDARY_ORANGE,
      onPrimary: JwColors.JW_STATUS_GENERIC,
      onSecondary: JwColors.JW_STATUS_GENERIC,
      onSurface: JwColors.JW_PRIMARY_BLACK,
      onError: JwColors.JW_STATUS_GENERIC,
      // ignore: deprecated_member_uses
      onBackground: JwColors.JW_PRIMARY_BLACK,
    );
  }

  static ColorScheme _getColorSchemeDark() {
    return const ColorScheme.dark(
      primary: JwColors.JW_PRIMARY_WHITE,
      secondary: JwColors.JW_SECONDARY_BLUE,
      surface: JwColors.JW_SCALE_PRIMARY,
      // ignore: deprecated_member_use
      background: JwColors.JW_SCALE_PRIMARY,
      error: JwColors.JW_RED,
      onPrimary: JwColors.JW_SCALE_PRIMARY,
      onSecondary: JwColors.JW_SCALE_PRIMARY,
      onError: JwColors.JW_SCALE_PRIMARY,
    );
  }

  static AppBarTheme _getAppBarTheme() {
    return const AppBarTheme(
      color: JwColors.JW_STATUS_GENERIC,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  static AppBarTheme _getAppBarThemeDark() {
    return const AppBarTheme(
      color: JwColors.JW_SCALE_PRIMARY,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
