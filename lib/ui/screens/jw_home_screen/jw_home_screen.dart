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
  bool isLoadingElevation = true;
  bool _showSearchBar = false;
  bool _showAlert = false;
  double _elevation = 0.0;
  String _locationCity = '';
  String _searchCity = '';

  @override
  void initState() {
    super.initState();
    _config = ref.read(servicesConfigProvider);
    _presenter = JwHomeScreenPresenter(this, _config);

    Future.microtask(() => loadCity.call());
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > JwConstants.TABLET_SIZE;
    final defaultHorizontalPadding = const EdgeInsets.symmetric(horizontal: 20);

    _searchCity = _weatherDate?.location.city ?? _searchCity;

    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: JwStyles.backgroundGradient(isDark),
        ),

        child: _showAlert
            ? Padding(
                padding: defaultHorizontalPadding,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Algo salio mal, intenta mas tarde',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: JwColors.JW_SECONDARY_ORANGE,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () => loadCity.call(),
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Intentar nuevamente',
                              style: TextStyle(
                                color: JwColors.JW_PRIMARY_WHITE,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  _weatherDate != null && isLoading == false
                      ? SafeArea(
                          bottom: false,
                          child: RefreshIndicator(
                            backgroundColor: isDark
                                ? JwColors.JW_PRIMARY_WHITE
                                : JwColors.JW_PRIMARY_BLACK,
                            color: isDark
                                ? JwColors.JW_PRIMARY_BLACK
                                : JwColors.JW_PRIMARY_WHITE,
                            onRefresh: () =>
                                reloadInformation(_weatherDate!.location),
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
                                            'Homez Weather',
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
                                          _weatherDate!.location.city ??
                                              _weatherDate?.location.country ??
                                              '',
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            isLoadingElevation
                                                ? SizedBox.shrink()
                                                : Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        formatToDecimals(
                                                          _elevation,
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: JwColors
                                                              .JW_SECONDARY_ORANGE,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' msnm',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: JwColors
                                                              .JW_SECONDARY_ORANGE,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            Text(
                                              formatDate(
                                                _weatherDate!
                                                        .location
                                                        .localtime ??
                                                    '',
                                              ),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: defaultHorizontalPadding,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
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
                                            AstroWidgets(
                                              weatherDate: _weatherDate,
                                            ),
                                            const SizedBox(height: 30),
                                          ],
                                        ),

                                        if (isTablet)
                                          WeatherDetails(
                                            weatherDate: _weatherDate,
                                          ),
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
                                          isTablet
                                              ? SizedBox.shrink()
                                              : WeatherDetails(
                                                  weatherDate: _weatherDate,
                                                ),
                                          const SizedBox(height: 25),
                                          TodayForecast(
                                            weatherDate: _weatherDate,
                                          ),
                                          SizedBox(height: 100),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: !_showSearchBar
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: updateTheme,
                  child: Icon(Icons.color_lens),
                ),
                if (_locationCity != _searchCity)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      FloatingActionButton(
                        onPressed: () => loadCity.call(),
                        child: Icon(Icons.my_location),
                      ),
                    ],
                  ),
              ],
            )
          : SizedBox.shrink(),
    );
  }

  Future<void> loadCity() async {
    final location = await ref.read(jwLocationControllerProvider.future);
    String selectedLoaction = '';
    if (location.city != null) {
      _locationCity = location.city!;
    }

    if (location.lat != null && location.lon != null) {
      selectedLoaction = "${location.lat},${location.lon}";
    } else if (location.city != null) {
      selectedLoaction = location.city!;
    }

    _presenter.getCurrentWeather(selectedLoaction);
  }

  Future<void> reloadInformation(JwLocation location) async {
    String selectedLoaction = '';
    selectedLoaction = "${location.lat},${location.lon}";

    _presenter.getCurrentWeather(selectedLoaction);
  }

  void updateTheme() {
    final notifier = ref.read(themeNotifierProvider);
    final current = notifier.getThemeMode() ?? ThemeMode.system;
    notifier.setThemeMode(
      current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void _updateCurrentCityWeather(String city) async {
    setState(() {
      _showSearchBar = false;
    });
    _presenter.getCurrentWeather(city);
  }

  @override
  Future<void> getCurrentWeather(JwWeatherResponse currentWeather) async {
    isLoadingElevation = true;
    _presenter.getElevation(currentWeather.location);

    if (!mounted) return;
    ref.read(jwWeatherStateProvider.notifier).setCity(currentWeather);
    setState(() {
      if (_locationCity.isEmpty) {
        _locationCity = currentWeather.location.city ?? '';
      }
      _weatherDate = currentWeather;
      _searchCity = currentWeather.location.city ?? '';
      isLoading = false;
      _showSearchBar = false;
    });
  }

  @override
  void showSkeleton() {
    if (!mounted) return;
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

  @override
  Future<void> getElevation(double elevation) async {
    if (!mounted) return;
    setState(() {
      _elevation = elevation;
      isLoadingElevation = false;
    });
  }
}
