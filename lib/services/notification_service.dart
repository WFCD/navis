import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';

class NotificationService {
  NotificationService._(this.messaging);

  factory NotificationService.initialize() {
    final FirebaseMessaging messaging = FirebaseMessaging();

    messaging.configure();

    return NotificationService._(messaging);
  }

  final FirebaseMessaging messaging;

  void get configure => messaging.configure();

  bool subscribeToPlatform(
      {Platforms previousPlatform, Platforms currentPlatform}) {
    if (previousPlatform == null) {
      messaging.subscribeToTopic(currentPlatform.toString().split('.').last);
      return true;
    }

    if (previousPlatform == currentPlatform) return false;

    messaging.unsubscribeFromTopic(previousPlatform.toString().split('.').last);
    messaging.subscribeToTopic(currentPlatform.toString().split('.').last);

    return true;
  }

  bool subscribeToNotification(String notificationKey, bool condition) {
    try {
      if (condition) {
        messaging.subscribeToTopic(notificationKey);
        return true;
      } else {
        messaging.unsubscribeFromTopic(notificationKey);

        return false;
      }
    } catch (error, stackTrace) {
      Crashlytics.instance.recordError(error, stackTrace);
      return false;
    }
  }
}
