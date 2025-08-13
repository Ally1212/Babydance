import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationService {
  static final PushNotificationService _instance =
      PushNotificationService._internal();

  factory PushNotificationService() {
    return _instance;
  }

  PushNotificationService._internal();

  Future<void> initialize() async {
    // Enable verbose logging for debugging (remove in production)
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    // Initialize with your OneSignal App ID
    OneSignal.initialize("xxxxxxxxxxxxxxxxxxxxxx");

    // Use this method to prompt for push notifications.
    // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
    OneSignal.Notifications.requestPermission(true);

    // Add a listener for notification opened events
    OneSignal.Notifications.addClickListener((event) {
      // Handle notification click event
      print('Notification clicked: ${event.notification.title}');
    });

    // Add a listener for notification foreground lifecycle events
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      // Handle notification received while app is in foreground
      print('Notification received in foreground: ${event.notification.title}');
      // Display the notification
      event.preventDefault();
      event.notification.display();
    });
  }

  // Get the user's push subscription ID
  String? getPushSubscriptionId() {
    return OneSignal.User.pushSubscription.id;
  }

  // Add a tag to the user
  // void addTag(String key, String value) {
  //   OneSignal.User.addTag(key: key, value: value);
  // }

  // Remove a tag from the user
  // void removeTag(String key) {
  //   OneSignal.User.removeTag(key);
  // }

  // Set an external user ID
  void setExternalUserId(String externalId) {
    OneSignal.login(externalId);
  }

  // Remove the external user ID
  void logout() {
    OneSignal.logout();
  }
}
