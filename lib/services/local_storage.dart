import 'package:floyer/constants/app_constants.dart';
import 'package:floyer/models/device_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late Box _profileBox;
  static late Box _global;

  /// Initialize Hive
  Future<void> initialize() async {
    await Hive.initFlutter();
    _profileBox = await Hive.openBox("profiles");
    _global = await Hive.openBox("global");
  }

  /// Add a new profile to the database
  Future<void> addProfile(DeviceProfile profile) async {
    await _profileBox.put(profile.id, profile.toJson());
  }

  /// Get all profiles from the database
  Future<List<DeviceProfile>> getProfiles() async {
    final profiles = <DeviceProfile>[];
    for (final key in _profileBox.keys) {
      final profile = DeviceProfile.fromJson(_profileBox.get(key));
      profiles.add(profile);
    }
    return profiles;
  }

  /// Get a profile from the database
  Future<void> setCurrentProfile(DeviceProfile profile) async {
    await _global.put("currentProfile", profile.toJson());
  }

  /// Get the current profile from the database
  DeviceProfile get getCurrentProfile {
    final current = _global.get("currentProfile");
    if (current != null) {
      return DeviceProfile.fromJson(current);
    }
    return AppConstants.fallbackProfile;
  }
}
