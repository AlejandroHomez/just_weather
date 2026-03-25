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
              decoration: JwStyles.currentTempDecoration(isDark),
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
              decoration: JwStyles.contentWeatherStatusDecoration(isDark),
              child: Image.network(
                "https:${_weatherDate.current.condition.icon}",
                height: 80,
                width: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),

          Positioned(
            top: 30,
            left: 60,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_up_outlined, size: 20),
                  Text(
                    "${_weatherDate.forecastDay!.maxTempC}°",
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 30,
            right: 60,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_drop_down_outlined, size: 20),
                  Text(
                    "${_weatherDate.forecastDay!.minTempC}°",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
