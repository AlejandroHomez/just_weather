class JwLocation {
  final double? lat;
  final double? lon;
  final double? elevation;
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
    this.elevation,
    this.region,
    this.country,
    this.city,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  JwLocation copyWith({
    double? lat,
    double? lon,
    double? elevation,
    String? region,
    String? country,
    String? tzId,
    int? localtimeEpoch,
    String? localtime,
    String? city,
    bool? isFallback,
  }) {
    return JwLocation(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      elevation: elevation ?? this.elevation,
      region: region ?? this.region,
      country: country ?? this.country,
      tzId: tzId ?? this.tzId,
      localtimeEpoch: localtimeEpoch ?? this.localtimeEpoch,
      localtime: localtime ?? this.localtime,
      city: city ?? this.city,
      isFallback: isFallback ?? this.isFallback,
    );
  }
}
