import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:just_weather_app/just_weather.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jw_location_state.g.dart';

final fallbackCities = ["Madrid", "Buenos Aires", "Lima", "CDMX", "Bogotá"];

@riverpod
class JwLocationController extends _$JwLocationController {
  @override
  Future<JwLocation> build() async {
    return await _getPositionOrFallback();
  }

  Future<JwLocation> _getPositionOrFallback() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return _fallback();

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever) {
      return _fallback();
    }

    try {
      final pos = await Geolocator.getCurrentPosition();
      return JwLocation(
        lat: pos.latitude,
        lon: pos.longitude,
        city: null,
        isFallback: false,
      );
    } catch (_) {
      return _fallback();
    }
  }

  JwLocation _fallback() {
    final randomCity = fallbackCities[Random().nextInt(fallbackCities.length)];
    return JwLocation(city: randomCity, lat: null, lon: null, isFallback: true);
  }
}
