import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:navis/core/notification_handler/handler.dart';
import 'package:wfcd_client/wfcd_client.dart';

class NotificationService {
  NotificationService(FirebaseMessaging messaging) : _messaging = messaging;

  final FirebaseMessaging _messaging;

  static final _logger = Logger('NotificationService');

  void configure() {
    const iosSettings = IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
      provisional: true,
    );

    _messaging.requestNotificationPermissions(iosSettings);
    _messaging.configure(
      onMessage: handler,
      onBackgroundMessage: Platform.isIOS ? null : handler,
    );
  }

  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    _logger.info('subscribing to ${platform.asString} topic');
    await _messaging.subscribeToTopic(platform.asString);
  }

  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    _logger.info('unsubscribing from ${platform.asString} topic');
    await _messaging.unsubscribeFromTopic(platform.asString);
  }

  Future<void> subscribeToNotification(String topic) async {
    _logger.info('subscribing to $topic');
    await _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromNotification(String topic) async {
    _logger.info('unsubscribing from $topic');
    await _messaging.unsubscribeFromTopic(topic);
  }
}
