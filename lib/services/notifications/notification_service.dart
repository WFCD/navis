import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wfcd_api_wrapper/wfcd_wrapper.dart';

class NotificationService {
  factory NotificationService() {
    final FirebaseMessaging messaging = FirebaseMessaging();

    return NotificationService._(messaging);
  }

  NotificationService._(this.messaging);

  final FirebaseMessaging messaging;

  static final notifications = NotificationService();

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
