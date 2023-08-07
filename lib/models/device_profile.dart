import 'dart:convert';

import 'package:floyer/models/coords.dart';

/// A class that represents a device profile.
///  * [id] - The unique identifier of the device profile.
/// * [name] - The name of the device profile.
/// * [colorSchemeSeed] - The seed used to generate the color scheme of the device profile.
/// * [appBarTitleSize] - The size of the app bar title of the device profile.
/// * [coordinates] - The coordinates of the device profile.
/// * [activationRadius] - The activation radius of the device profile.
class DeviceProfile {
  final String id;
  final String name;
  final String colorSchemeSeed;
  final double appBarTitleSize;
  final Coords coordinates;

  // In Meters
  final int activationRadius;

  DeviceProfile({
    required this.id,
    required this.name,
    required this.colorSchemeSeed,
    required this.appBarTitleSize,
    required this.coordinates,
    this.activationRadius = 1000,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'colorSchemeSeed': colorSchemeSeed,
      'appBarTitleSize': appBarTitleSize,
      'coordinates': coordinates.toMap(),
      'activationRadius': activationRadius,
    };
  }

  factory DeviceProfile.fromMap(Map<String, dynamic> map) {
    return DeviceProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      colorSchemeSeed: map['colorSchemeSeed'] as String,
      appBarTitleSize: map['appBarTitleSize'] as double,
      coordinates: Coords.fromMap(map['coordinates'] as Map<String, dynamic>),
      activationRadius: map['activationRadius'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceProfile.fromJson(String source) =>
      DeviceProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
