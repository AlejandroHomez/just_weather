import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class WeatherDayCard extends StatelessWidget {
  final String day;
  final String temp;
  final String icon;

  const WeatherDayCard({
    super.key,
    required this.day,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: JwStyles.extraInfoBoxDecoration(isDark),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day),
          const SizedBox(height: 6),
          Center(
            child: Image.network(
              "https:$icon",
              height: 35,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            temp,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
