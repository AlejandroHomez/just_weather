import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class JwStyles {
  static Gradient backgroundGradient(bool isDark) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.2, 0.7, 0.8],
    colors: [
      isDark ? JwColors.JW_PRIMARY_BLACK_600 : JwColors.JW_PRIMARY_WHITE,
      isDark ? JwColors.JW_SCALE_PRIMARY : JwColors.JW_PRIMARY_WHITE_500,
      isDark ? JwColors.JW_SEQUENTIAL_BLACK_700 : JwColors.JW_PRIMARY_WHITE,
    ],
  );

  static Decoration boxDetailDecoration(bool isDark) => BoxDecoration(
    color: isDark ? JwColors.JW_PRIMARY_BLACK : JwColors.JW_PRIMARY_WHITE,
    boxShadow: [
      BoxShadow(
        blurRadius: 30,
        color: isDark
            ? JwColors.JW_PRIMARY_BLACK_600
            : JwColors.JW_PRIMARY_WHITE_500,
      ),
    ],
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(25),
      topLeft: Radius.circular(25),
    ),
  );

  static Decoration currentTempDecoration(bool isDark) => BoxDecoration(
    shape: BoxShape.circle,
    color: isDark ? JwColors.JW_PRIMARY_BLACK : JwColors.JW_PRIMARY_WHITE,

    boxShadow: [
      BoxShadow(
        color: isDark ? JwColors.JW_SCALE_PRIMARY : JwColors.JW_PRIMARY_GREY,
        offset: Offset(-6, -6),
        blurRadius: 16,
      ),

      BoxShadow(
        color: isDark
            ? JwColors.JW_PRIMARY_BLACK_600
            : JwColors.JW_PRIMARY_GREY_600,
        offset: Offset(6, 6),
        blurRadius: 16,
      ),
    ],
  );

  static Decoration contentWeatherStatusDecoration(isDark) => BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: isDark
          ? JwColors.JW_SEQUENTIAL_BLACK_700
          : JwColors.JW_PRIMARY_WHITE_500,
    ),
    color: isDark ? JwColors.JW_PRIMARY_BLACK : JwColors.JW_PRIMARY_WHITE,
  );

  static Decoration extraInfoBoxDecoration(bool isDark) => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: isDark ? JwColors.JW_PRIMARY_BLACK : JwColors.JW_PRIMARY_WHITE,
    boxShadow: [
      BoxShadow(
        color: isDark ? JwColors.JW_SCALE_PRIMARY : JwColors.JW_PRIMARY_GREY,
        offset: Offset(-6, -6),
        blurRadius: 16,
      ),

      BoxShadow(
        color: isDark
            ? JwColors.JW_PRIMARY_BLACK_600
            : JwColors.JW_PRIMARY_GREY_600,
        offset: Offset(6, 6),
        blurRadius: 16,
      ),
    ],
  );

  static Decoration searchContentDecoration(isDark) => BoxDecoration(
    color: isDark
        ? JwColors.JW_SEQUENTIAL_BLACK_700
        : JwColors.JW_PRIMARY_WHITE,
    borderRadius: BorderRadius.circular(10),
  );
}
