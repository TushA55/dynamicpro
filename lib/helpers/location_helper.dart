import 'package:floyer/helpers/permission_helper.dart';
import 'package:location/location.dart';

class LocationHelper {
  /// Returns a stream of [Position] objects.
  Future<Stream<LocationData>?> locationStream() async {
    final permission = await PermissionHelper().requestLocationPermission();
    if (permission) {
      final serviceStatus = await PermissionHelper().requestLocationService();
      if (serviceStatus) {
        return Location.instance.onLocationChanged;
      }
    }
    return null;
  }

  /// Returns a [Position] object.
  Future<LocationData?> getCurrentLocation() async {
    final permission = await PermissionHelper().requestLocationPermission();
    if (permission) {
      final serviceStatus = await PermissionHelper().requestLocationService();
      if (serviceStatus) {
        return await Location.instance.getLocation();
      }
    }
    return null;
  }
}
