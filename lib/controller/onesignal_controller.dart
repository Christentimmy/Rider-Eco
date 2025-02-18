import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalController extends GetxController {
  RxString userId = "".obs; // Store OneSignal User ID

  void initOneSignal() async {
    // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
    OneSignal.Notifications.requestPermission(true);
  }
}


// import 'package:get/get.dart';
// import 'dart:async';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

// class OneSignalController extends GetxController {
//   String _debugLabelString = "";
//   String? _emailAddress;
//   String? _smsNumber;
//   String? _externalUserId;
//   String? _language;
//   String? _liveActivityId;
//   bool _enableConsentButton = false;

//   // CHANGE THIS parameter to true if you want to test GDPR privacy consent
//   bool _requireConsent = false;

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initOneSignal() async {
//     OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//     OneSignal.Debug.setAlertLevel(OSLogLevel.none);
//     OneSignal.consentRequired(_requireConsent);
//     OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
//     OneSignal.LiveActivities.setupDefault();
//     OneSignal.Notifications.clearAll();
//     OneSignal.User.pushSubscription.addObserver((state) {
//       print(OneSignal.User.pushSubscription.optedIn);
//       print(OneSignal.User.pushSubscription.id);
//       print(OneSignal.User.pushSubscription.token);
//       print(state.current.jsonRepresentation());
//     });

//     OneSignal.User.addObserver((state) {
//       var userState = state.jsonRepresentation();
//       print('OneSignal user changed: $userState');
//     });

//     OneSignal.Notifications.addPermissionObserver((state) {
//       print("Has permission $state");
//     });

//     OneSignal.Notifications.addForegroundWillDisplayListener((event) {
//       print(
//         'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}',
//       );
//       event.notification.display();
//     });

    
//     OneSignal.InAppMessages.addWillDisplayListener((event) {
//       print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
//     });
//     OneSignal.InAppMessages.addDidDisplayListener((event) {
//       print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
//     });
//     OneSignal.InAppMessages.addWillDismissListener((event) {
//       print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
//     });
//     OneSignal.InAppMessages.addDidDismissListener((event) {
//       print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
//     });

//     OneSignal.InAppMessages.paused(true);
//   }

// }
