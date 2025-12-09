import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class ConditionText extends StatelessWidget {
  const ConditionText({
    super.key,
    required JwWeatherResponse? weatherDate,
    required this.isDark,
  }) : _weatherDate = weatherDate;

  final JwWeatherResponse? _weatherDate;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _weatherDate!.current.condition.text,
        style: TextStyle(
          fontSize: 18,
          color: isDark
              ? JwColors.JW_SEQUENTIAL_BLACK_600
              : JwColors.JW_SEQUENTIAL_BLACK_600,
        ),
        textAlign: TextAlign.center,
        maxLines: 3,
      ),
    );
  }
}
