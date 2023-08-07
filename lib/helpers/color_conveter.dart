import 'package:flutter/material.dart';

class ColorConverter {
  /// Converts a [Color] to a hex string.
  String colorToHex(Color color) {
    return color.value.toRadixString(16).toUpperCase().substring(2);
  }

  /// Converts a hex string to a [Color].
  Color? hexToColor(String hex) {
    if (hex.length != 6) return null;
    return Color(int.parse("0xFF$hex"));
  }
}
