import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalController {

  final String oneSignalAppId;

  OneSignalController({
    @required
     this.oneSignalAppId,
  });

  void initOneSignal() async {

    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init(
        oneSignalAppId,
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: false
        }
    );

    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setNotificationReceivedHandler(_handleNotificationReceived);


  }

  void _handleNotificationReceived(OSNotification notification) {
    print("Notification Received!");
  }

}