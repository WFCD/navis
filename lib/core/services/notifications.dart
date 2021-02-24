import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wfcd_client/wfcd_client.dart';

class NotificationService {
  NotificationService(FirebaseMessaging messaging) : _messaging = messaging;

  final FirebaseMessaging _messaging;

  void configure() {
    const iosSettings = IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
      provisional: true,
    );

    _messaging.requestNotificationPermissions(iosSettings);
  }

  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    _log('subscribing to ${platform.asString} topic');
    await _messaging.subscribeToTopic(platform.asString);
  }

  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    _log('unsubscribing from ${platform.asString} topic');
    await _messaging.unsubscribeFromTopic(platform.asString);
  }

  Future<void> subscribeToNotification(String topic) async {
    _log('subscribing to $topic');
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromNotification(String topic) async {
    _log('unsubscribing from $topic');
    await _messaging.unsubscribeFromTopic(topic);
  }

  void _log(String message) {
    log(message, name: 'NotificationService');
  }
}
