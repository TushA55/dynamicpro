import 'package:floyer/helpers/color_conveter.dart';
import 'package:floyer/models/coords.dart';
import 'package:floyer/models/device_profile.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static final fallbackProfile = DeviceProfile(
    id: "default",
    name: "Default",
    colorSchemeSeed: ColorConverter().colorToHex(Colors.blue),
    appBarTitleSize: 18,
    coordinates: const Coords(latitude: 0, longitude: 0),
  );
}
