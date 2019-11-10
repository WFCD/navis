import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wfcd_api_wrapper/worldstate_client.dart';

class NotificationService {
  NotificationService._(this.messaging);

  factory NotificationService.initialize() {
    final FirebaseMessaging messaging = FirebaseMessaging();

    return NotificationService._(messaging);
  }

  final FirebaseMessaging messaging;

  Future<bool> subscribeToPlatform(
      {Platforms previousPlatform, Platforms currentPlatform}) async {
    if (previousPlatform == null) {
      await messaging
          .subscribeToTopic(currentPlatform.toString().split('.').last);
      return true;
    }

    if (previousPlatform == currentPlatform) return false;

    await messaging
        .unsubscribeFromTopic(previousPlatform.toString().split('.').last);
    await messaging
        .subscribeToTopic(currentPlatform.toString().split('.').last);

    return true;
  }

  Future<bool> subscribeToNotification(
      String notificationKey, bool condition) async {
    try {
      if (condition) {
        await messaging.subscribeToTopic(notificationKey);
        return true;
      } else {
        await messaging.unsubscribeFromTopic(notificationKey);

        return false;
      }
    } catch (error, stackTrace) {
      Crashlytics.instance.recordError(error, stackTrace);
      return false;
    }
  }
}
