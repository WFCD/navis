import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:wfcd_client/wfcd_client.dart';

class NotificationService {
  NotificationService();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void configure() {
    _messaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
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
    log(message, name: 'NotificationService', level: Level.INFO.value);
  }
}
