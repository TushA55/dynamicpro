import 'package:floyer/helpers/permission_helper.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  /// Returns a stream of [Position] objects.
  Future<Stream<Position>?> locationStream() async {
    final permission = await PermissionHelper().requestLocationPermission();
    if (permission) {
      final serviceStatus = await PermissionHelper().requestLocationService();
      if (serviceStatus) {
        return Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation,
          ),
        );
      }
    }
    return null;
  }

  /// Returns a [Position] object.
  Future<Position?> getCurrentLocation() async {
    final permission = await PermissionHelper().requestLocationPermission();
    if (permission) {
      final serviceStatus = await PermissionHelper().requestLocationService();
      if (serviceStatus) {
        return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation,
        );
      }
    }
    return null;
  }
}
