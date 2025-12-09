import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

class AstroWidgets extends StatelessWidget {
  const AstroWidgets({super.key, required JwWeatherResponse? weatherDate})
    : _weatherDate = weatherDate;

  final JwWeatherResponse? _weatherDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 50,
      children: [
        Column(
          spacing: 10,
          children: [
            Image.asset("assets/icons/sunrise.png", height: 80),
            Text(_weatherDate!.astro.sunrise ?? ''),
          ],
        ),
        Column(
          spacing: 10,
          children: [
            Image.asset("assets/icons/sunset.png", height: 80),
            Text(_weatherDate!.astro.sunset ?? ''),
          ],
        ),
      ],
    );
  }
}
