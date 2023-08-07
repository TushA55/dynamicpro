import 'package:floyer/models/device_profile.dart';
import 'package:geolocator/geolocator.dart';

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
      final distance = Geolocator.distanceBetween(
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
}
