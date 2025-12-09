import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class CurrentTempWidget extends StatelessWidget {
  const CurrentTempWidget({
    super.key,
    required this.isDark,
    required JwWeatherResponse? weatherDate,
  }) : _weatherDate = weatherDate;

  final bool isDark;
  final JwWeatherResponse? _weatherDate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ElasticIn(
            child: Container(
              padding: EdgeInsets.all(60),

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? JwColors.JW_PRIMARY_BLACK
                    : JwColors.JW_PRIMARY_WHITE,

                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? JwColors.JW_SCALE_PRIMARY
                        : JwColors.JW_PRIMARY_GREY,
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
              ),
              child: Text(
                "${_weatherDate!.current.tempC.toInt().toString()}°",
                style: TextStyle(fontSize: 90, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? JwColors.JW_SEQUENTIAL_BLACK_700
                      : JwColors.JW_PRIMARY_WHITE_500,
                ),
                color: isDark
                    ? JwColors.JW_PRIMARY_BLACK
                    : JwColors.JW_PRIMARY_WHITE,
              ),
              child: Image.network(
                "https:${_weatherDate!.current.condition.icon}",
                height: 80,
                width: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
