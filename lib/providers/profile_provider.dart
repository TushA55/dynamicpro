import 'package:floyer/constants/app_constants.dart';
import 'package:floyer/helpers/distance_helper.dart';
import 'package:floyer/helpers/location_helper.dart';
import 'package:floyer/models/device_profile.dart';
import 'package:floyer/services/local_storage.dart';
import 'package:floyer/services/notification_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final List<DeviceProfile> _profiles = [];

  List<DeviceProfile> get profiles => _profiles;

  DeviceProfile _currentProfile = LocalStorage().getCurrentProfile;

  DeviceProfile get currentProfile => _currentProfile;

  Future<void> initialize() async {
    final profiles = await LocalStorage().getProfiles();
    _profiles.addAll(profiles);

    final position = await LocationHelper().getCurrentLocation();
    if (position != null && profiles.isNotEmpty) {
      final nearest = DistanceHelper.getNearestProfile(
        position.latitude,
        position.longitude,
        profiles,
      );
      if (nearest != null) {
        updateProfile(nearest);
      } else {
        updateProfile(AppConstants.fallbackProfile);
      }
    }
    notifyListeners();
  }

  Future<void> addProfile(DeviceProfile profile) async {
    _profiles.add(profile);
    await LocalStorage().addProfile(profile);
    notifyListeners();
  }

  void updateProfile(DeviceProfile profile) {
    if (_currentProfile.id == profile.id) return;
    _currentProfile = profile;
    LocalStorage().setCurrentProfile(profile);
    NotificationService().showProfileUpdateNotification(profile);
    notifyListeners();
  }
}
