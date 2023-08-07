import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:geolocator/geolocator.dart';

class PermissionHelper {
  /// Returns true if permission is granted, false otherwise.
  Future<bool> requestLocationPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    return permissionStatus == LocationPermission.always ||
        permissionStatus == LocationPermission.whileInUse;
  }

  /// Returns true if location service is enabled, false otherwise.
  Future<bool> requestLocationService() async {
    bool serviceStatus = await Geolocator.isLocationServiceEnabled();
    return serviceStatus;
  }

  /// Returns true if permission is granted, false otherwise.
  Future<bool> requestNotificationPermission() =>
      AwesomeNotifications().requestPermissionToSendNotifications();
}
