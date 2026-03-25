import 'package:just_weather_app/just_weather.dart';

class JwLocationMapper extends Mapper<JwLocation> {
  @override
  JwLocation fromMap(Map<String, dynamic> json) {
    return JwLocation(
      city: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      elevation: json['altitude'] ?? json['elevation'],
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
      isFallback: false,
    );
  }

  @override
  Map<String, dynamic>? toMap(JwLocation data) {
    return {
      'name': data.city,
      'region': data.region,
      'country': data.country,
      'lat': data.lat,
      'lon': data.lon,
      'elevation': data.elevation,
      'tz_id': data.tzId,
      'localtime_epoch': data.localtimeEpoch,
      'localtime': data.localtime,
    };
  }
}
