import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_weather_app/config/theme/theme_norifier.dart';
import 'package:just_weather_app/just_weather.dart';
import 'package:just_weather_app/ui/states/global_config.dart';
import 'package:just_weather_app/ui/states/jw_location_state.dart';
import 'package:just_weather_app/ui/states/jw_weather_state.dart';

import 'widgets/astro_widgets.dart';
import 'widgets/condition_text.dart';
import 'widgets/current_temp_widget.dart';
import 'widgets/jw_search_content.dart';
import 'widgets/today_forecast.dart';
import 'widgets/weather_details.dart';

class JwHomeScreen extends ConsumerStatefulWidget {
  static const roteName = '/jw_home_screen';
  const JwHomeScreen({super.key});

  @override
  ConsumerState<JwHomeScreen> createState() => _JwHomeScreenState();
}

class _JwHomeScreenState extends ConsumerState<JwHomeScreen>
    implements JwHomeScreenInterface {
  late JwHomeScreenPresenter _presenter;
  late JwWeatherConfig _config;
  JwWeatherResponse? _weatherDate;
  bool isLoading = false;
  bool _showSearchBar = false;
  bool _showAlert = false;

  @override
  void initState() {
    super.initState();
    _config = ref.read(servicesConfigProvider);
    _presenter = JwHomeScreenPresenter(this, _config);

    Future.microtask(() async {
      final location = await ref.read(jwLocationControllerProvider.future);
      final selectedCity = "${location.lat},${location.lon}";
      _presenter.getCurrentWeather(selectedCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final defaultHorizontalPadding = const EdgeInsets.symmetric(horizontal: 20);

    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: JwStyles.backgroundGradient(isDark),
        ),

        child: _showAlert
            ? Center(child: Text('Algo salio mal, intenta mas tarde'))
            : Stack(
                children: [
                  _weatherDate != null && isLoading == false
                      ? SafeArea(
                          bottom: false,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(height: _showSearchBar ? 59 : 10),

                                if (!_showSearchBar)
                                  Padding(
                                    padding: defaultHorizontalPadding,
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        Image.asset(
                                          "assets/logo.png",
                                          height: 40,
                                        ),
                                        Text(
                                          'Just Weather',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll<Color>(
                                                  !isDark
                                                      ? JwColors
                                                            .JW_PRIMARY_BLACK
                                                      : JwColors
                                                            .JW_PRIMARY_WHITE,
                                                ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _showSearchBar = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.search,
                                            color: isDark
                                                ? JwColors.JW_PRIMARY_BLACK
                                                : JwColors.JW_PRIMARY_WHITE,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 10),

                                Padding(
                                  padding: defaultHorizontalPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _weatherDate!.location.city ?? '',
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formatDate(
                                          _weatherDate!.location.localtime ??
                                              '',
                                        ),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      CurrentTempWidget(
                                        isDark: isDark,
                                        weatherDate: _weatherDate,
                                      ),
                                      const SizedBox(height: 30),
                                      ConditionText(
                                        weatherDate: _weatherDate,
                                        isDark: isDark,
                                      ),
                                      const SizedBox(height: 30),
                                      AstroWidgets(weatherDate: _weatherDate),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                                ),

                                Container(
                                  decoration: JwStyles.boxDetailDecoration(
                                    isDark,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WeatherDetails(
                                          weatherDate: _weatherDate,
                                        ),
                                        const SizedBox(height: 25),
                                        TodayForecast(
                                          weatherDate: _weatherDate,
                                        ),
                                        const SizedBox(height: 25),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(child: JwHomeSkeleton()),

                  if (_showSearchBar)
                    BackdropFilter(
                      filter: ImageFilter.blur(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showSearchBar = !_showSearchBar;
                          });
                        },
                        child: Container(
                          color: JwColors.JW_PRIMARY_BLACK.withAlpha(200),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ZoomIn(
                                  duration: Duration(milliseconds: 200),
                                  from: 1,
                                  child: JwSearchContent(
                                    onItemTap: (value) {
                                      _updateCurrentCityWeather(value.city);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),

      floatingActionButton: !_showSearchBar
          ? FloatingActionButton(
              onPressed: updateTheme,
              child: Icon(Icons.color_lens),
            )
          : SizedBox.shrink(),
    );
  }

  void updateTheme() {
    final notifier = ref.read(themeNotifierProvider);
    final current = notifier.getThemeMode() ?? ThemeMode.system;
    notifier.setThemeMode(
      current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void _updateCurrentCityWeather(String city) {
    setState(() {
      _showSearchBar = false;
    });
    _presenter.getCurrentWeather(city);
  }

  @override
  Future<void> getCurrentWeather(JwWeatherResponse currentWeather) async {
    if (!mounted) return;
    ref.read(jwWeatherStateProvider.notifier).setCity(currentWeather);
    setState(() {
      _weatherDate = currentWeather;
      isLoading = false;
      _showSearchBar = false;
    });
  }

  @override
  void showSkeleton() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void showAlert(JwErrorItem error) {
    setState(() {
      _showAlert = true;
    });
  }
}
