import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

import 'weather_day_card.dart';

class TodayForecast extends StatelessWidget {
  const TodayForecast({super.key, required JwWeatherResponse? weatherDate})
    : _weatherDate = weatherDate;

  final JwWeatherResponse? _weatherDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Pronóstico del día",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        FlipInX(
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              itemCount: _weatherDate!.forecastDayList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext contex, int index) {
                final JwCurrentWeather currentWeatherForHour =
                    _weatherDate.forecastDayList[index];

                return WeatherDayCard(
                  day: formatToHour(currentWeatherForHour.dateTime!),
                  temp: "${currentWeatherForHour.tempC}°",
                  icon: currentWeatherForHour.condition.icon,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
