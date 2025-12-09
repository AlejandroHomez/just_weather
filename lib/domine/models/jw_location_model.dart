class JwLocation {
  final double? lat;
  final double? lon;
  final String? region;
  final String? country;
  final String? tzId;
  final int? localtimeEpoch;
  final String? localtime;
  final String? city;
  final bool isFallback;

  JwLocation({
    required this.isFallback,
    this.lat,
    this.lon,
    this.region,
    this.country,
    this.city,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });
}
