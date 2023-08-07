import 'dart:math';

import 'package:floyer/models/device_profile.dart';

class DistanceHelper {
  /// Returns the nearest [DeviceProfile] from the given [profiles] list.
  static DeviceProfile? getNearestProfile(
    double latitude,
    double longitude,
    List<DeviceProfile> profiles,
  ) {
    DeviceProfile? nearestProfile;

    /// Iterate through all the [profiles] and calculate the distance between
    /// the given [latitude] and [longitude] and the [profile]'s coordinates.
    for (var profile in profiles) {
      final distance = distanceBetween(
        latitude,
        longitude,
        profile.coordinates.latitude,
        profile.coordinates.longitude,
      );

      /// If the distance is less than or equal to the [profile]'s
      /// [activationRadius], then set the [nearestProfile] to the [profile].
      if (distance <= profile.activationRadius) {
        nearestProfile = profile;
      }
    }
    return nearestProfile;
  }

  static double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    var earthRadius = 6378137.0;
    var dLat = _toRadians(endLatitude - startLatitude);
    var dLon = _toRadians(endLongitude - startLongitude);

    var a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude));
    var c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  static _toRadians(double degree) {
    return degree * pi / 180;
  }
}
