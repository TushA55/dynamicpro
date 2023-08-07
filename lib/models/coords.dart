import 'dart:convert';

/// A class that represents the coordinates of a location.
/// - [latitude] is the latitude of the location.
/// - [longitude] is the longitude of the location.
class Coords {
  const Coords({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    return Coords(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coords.fromJson(String source) =>
      Coords.fromMap(json.decode(source) as Map<String, dynamic>);
}
