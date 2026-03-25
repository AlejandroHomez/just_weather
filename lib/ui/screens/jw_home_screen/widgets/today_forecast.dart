import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:just_weather_app/just_weather.dart';

import 'weather_day_card.dart';

class TodayForecast extends StatefulWidget {
  const TodayForecast({super.key, required JwWeatherResponse? weatherDate})
    : _weatherDate = weatherDate;

  final JwWeatherResponse? _weatherDate;

  @override
  State<TodayForecast> createState() => _TodayForecastState();
}

class _TodayForecastState extends State<TodayForecast> {
  final ScrollController _scrollController = ScrollController();
  final int currentHour = DateTime.now().hour;
  final double cardWidth = 100;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double offset = currentHour * cardWidth;
      
      _scrollController.jumpTo(offset);
    });
    super.initState();
  }

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
              controller: _scrollController,
              itemCount: widget._weatherDate!.forecastDayList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext contex, int index) {
                final JwCurrentWeather currentWeatherForHour =
                    widget._weatherDate!.forecastDayList[index];

                return WeatherDayCard(
                  borderColor: index == currentHour ? JwColors.JW_SECONDARY_ORANGE : JwColors.JW_TRANSPARENT,
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
