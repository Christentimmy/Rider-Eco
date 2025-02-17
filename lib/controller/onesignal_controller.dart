import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalController extends GetxController {
  void initOneSignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");


    bool permission = await OneSignal.Notifications.requestPermission(true);

    if (permission) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
    }

    // Optional: Set up notification handlers
    _setupNotificationHandlers();
  }

  void _setupNotificationHandlers() {
    // Handle notification opened
    OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
      print("Notification clicked: ${event.notification.body}");
    });

    OneSignal.Notifications.addForegroundWillDisplayListener(
      (OSNotificationWillDisplayEvent event) {
        print(
            "Notification received in foreground: ${event.notification.body}");
        event
            .preventDefault(); // Prevent auto-display if you want to customize it
      },
    );
  }
}
