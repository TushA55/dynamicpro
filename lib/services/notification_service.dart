import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:floyer/models/device_profile.dart';

class NotificationService {
  /// The channel key for the notification channel.
  static const channelKey = "floyer";

  /// Initializes the notification service.
  Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: channelKey,
        channelName: 'Floyer',
        channelDescription: 'Floyer notifications',
        playSound: true,
        enableVibration: true,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ]);
  }

  /// Shows a notification when a new device profile is created.
  Future<void> showProfileUpdateNotification(DeviceProfile profile) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().hashCode,
        channelKey: channelKey,
        title: "Profile Updated",
        body: "Your profile has been updated to ${profile.name}.",
        autoDismissible: true,
        criticalAlert: true,
      ),
    );
  }
}
