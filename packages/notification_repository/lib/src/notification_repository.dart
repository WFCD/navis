import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_repository/src/topics.dart';
import 'package:wfcd_client/wfcd_client.dart';

// TODO(SlayerOrnstein): We might need to use other services that also provide
//  ADM for amazon devices

/// {@template notification_repository}
/// Main entry to start push notifications via firebase.
///
/// Notifications are just simple topics and nothing to complex about them.
/// {@endtemplate}
class NotificationRepository {
  /// {@macro notification_repository}
  NotificationRepository();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Request persmission on iOS
  ///
  /// Has a platform check inside the lib itself.
  void configure() => _messaging.requestPermission();

  /// Subscribes to the [GamePlatforms]
  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    _log('subscribing to ${platform.name} topic');
    await _messaging.subscribeToTopic(platform.name);
  }

  /// Unsubscribes from the [GamePlatforms]
  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    _log('unsubscribing from ${platform.name} topic');
    await _messaging.unsubscribeFromTopic(platform.name);
  }

  /// Subscribes to any [Topic] found in [Topics]
  Future<void> subscribeToNotification(Topic topic) async {
    _log('subscribing to $topic');
    await _messaging.subscribeToTopic(topic.toString());
  }

  /// Unsubscribes to any [Topic] found in [Topics]
  Future<void> unsubscribeFromNotification(Topic topic) async {
    _log('unsubscribing from $topic');
    await _messaging.unsubscribeFromTopic(topic.toString());
  }

  void _log(String message) {
    log(message, name: 'NotificationService');
  }
}
