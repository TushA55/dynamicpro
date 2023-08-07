import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:location/location.dart';

class PermissionHelper {
  /// Returns true if permission is granted, false otherwise.
  Future<bool> requestLocationPermission() async {
    final permissionStatus = await Location.instance.requestPermission();
    return permissionStatus == PermissionStatus.granted ||
        permissionStatus == PermissionStatus.grantedLimited;
  }

  /// Returns true if location service is enabled, false otherwise.
  Future<bool> requestLocationService() async {
    bool serviceStatus = await Location.instance.requestService();
    return serviceStatus;
  }

  /// Returns true if permission is granted, false otherwise.
  Future<bool> requestNotificationPermission() =>
      AwesomeNotifications().requestPermissionToSendNotifications();
}
