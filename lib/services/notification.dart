import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/rendering.dart';
import 'package:navis/utils/enums.dart';

class NotificationService {
  NotificationService._(this.messaging);

  factory NotificationService.initialize() {
    final FirebaseMessaging messaging = FirebaseMessaging();

    messaging.configure(onMessage: (Map<String, dynamic> message) {
      // TODO(SlayerOrnstein): add in app notification
      //debugPrint(message.toString());
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

  void subscribeToNotification(String notificationKey, bool condition) {
    if (condition)
      messaging.subscribeToTopic(notificationKey);
    else
      messaging.unsubscribeFromTopic(notificationKey);
  }
}
