import 'package:just_weather_app/just_weather.dart';

class JwWeatherState {
  final bool loading;
  final JwWeatherResponse? data;
  final String? errorMessage;

  const JwWeatherState({required this.loading, this.data, this.errorMessage});

  factory JwWeatherState.initial() => const JwWeatherState(loading: false);

  JwWeatherState copyWith({
    bool? loading,
    JwWeatherResponse? data,
    String? errorMessage,
  }) {
    return JwWeatherState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }
}
