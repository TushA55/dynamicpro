class ValidationHelper {
  /// Validates the latitude value.
  static String? validateLatitude(String? value) {
    if (value == null || value.isEmpty) {
      return "Latitude cannot be empty.";
    }
    final double? latitude = double.tryParse(value);
    if (latitude == null) {
      return "Latitude must be a number.";
    }
    if (latitude < -90 || latitude > 90) {
      return "Latitude must be between -90 and 90.";
    }
    return null;
  }

  /// Validates the longitude value.
  static String? validateLongitude(String? value) {
    if (value == null || value.isEmpty) {
      return "Longitude cannot be empty.";
    }
    final double? longitude = double.tryParse(value);
    if (longitude == null) {
      return "Longitude must be a number.";
    }
    if (longitude < -180 || longitude > 180) {
      return "Longitude must be between -180 and 180.";
    }
    return null;
  }
}
