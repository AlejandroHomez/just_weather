import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

import 'extra_info.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key, required JwWeatherResponse? weatherDate})
    : _weatherDate = weatherDate;

  final JwWeatherResponse? _weatherDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Detalles del clima",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        ZoomIn(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExtraInfo(
                      icon: Icons.water_drop,
                      label: "Humedad",
                      value: "${_weatherDate!.current.humidity}%",
                    ),
                    ExtraInfo(
                      icon: Icons.air,
                      label: "Viento",
                      value: "${_weatherDate!.current.windKph} km/h",
                    ),
                    ExtraInfo(
                      icon: Icons.thermostat,
                      label: "Sensación",
                      value: "${_weatherDate!.current.feelsLikeC}°",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExtraInfo(
                      icon: Icons.wb_sunny,
                      label: "Uv",
                      value: "${_weatherDate!.current.uv}",
                    ),
                    ExtraInfo(
                      icon: Icons.wb_sunny,
                      label: "Visibilidad",
                      value: "${_weatherDate!.current.visKm.toInt()} Km",
                    ),
                    ExtraInfo(
                      icon: Icons.wb_iridescent,
                      label: "Presión",
                      value: "${_weatherDate!.current.pressureMb.toInt()} hPa",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
