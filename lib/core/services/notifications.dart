import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:wfcd_client/wfcd_client.dart';

abstract class NotificationService {
  void configure();

  Future<void> subscribeToPlatform(GamePlatforms platform);

  Future<void> unsubscribeFromPlatform(GamePlatforms platform);

  Future<void> subscribeToNotification(String topic);

  Future<void> unsubscribeFromNotification(String topic);
}

class NotificationServiceRelease implements NotificationService {
  NotificationServiceRelease();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void configure() {
    _messaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
  }

  @override
  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    _log('subscribing to ${platform.asString} topic');
    await _messaging.subscribeToTopic(platform.asString);
  }

  @override
  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    _log('unsubscribing from ${platform.asString} topic');
    await _messaging.unsubscribeFromTopic(platform.asString);
  }

  @override
  Future<void> subscribeToNotification(String topic) async {
    _log('subscribing to $topic');
    await _messaging.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromNotification(String topic) async {
    _log('unsubscribing from $topic');
    await _messaging.unsubscribeFromTopic(topic);
  }

  void _log(String message) {
    log(message, name: 'NotificationService', level: Level.INFO.value);
  }
}

class NotificationServiceDebug implements NotificationService {
  @override
  void configure() {}

  @override
  Future<void> subscribeToNotification(String topic) async {
    return;
  }

  @override
  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    return;
  }

  @override
  Future<void> unsubscribeFromNotification(String topic) async {
    return;
  }

  @override
  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    return;
  }
}
