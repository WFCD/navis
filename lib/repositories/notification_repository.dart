import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:navis/utils/enums.dart';

class NotificationRepository {
  final FirebaseMessaging _messaging = FirebaseMessaging();

  Future<bool> subscribeToPlatform(
      {Platforms previousPlatform, Platforms currentPlatform}) async {
    if (previousPlatform == null) {
      await _messaging
          .subscribeToTopic(currentPlatform.toString().split('.').last);
      return true;
    }

    if (previousPlatform == currentPlatform) return false;

    await _messaging
        .unsubscribeFromTopic(previousPlatform.toString().split('.').last);
    await _messaging
        .subscribeToTopic(currentPlatform.toString().split('.').last);

    return true;
  }

  Future<bool> subscribeToNotification(
      String notificationKey, bool condition) async {
    try {
      if (condition) {
        await _messaging.subscribeToTopic(notificationKey);
        return true;
      } else {
        await _messaging.unsubscribeFromTopic(notificationKey);

        return false;
      }
    } catch (error, stackTrace) {
      await Crashlytics.instance.recordError(error, stackTrace);
      return false;
    }
  }
}
