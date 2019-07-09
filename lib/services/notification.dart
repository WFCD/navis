import 'package:catcher/core/catcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:navis/utils/utils.dart';

class NotificationService {
  NotificationService._(this.messaging);

  factory NotificationService.initialize() {
    final FirebaseMessaging messaging = FirebaseMessaging();

    messaging.configure(onMessage: (Map<String, dynamic> message) {
      // TODO(SlayerOrnstein): add in app notification
      return null;
    });

    return NotificationService._(messaging);
  }

  final FirebaseMessaging messaging;

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
      Catcher.reportCheckedError(error, stackTrace);
      return false;
    }
  }
}
