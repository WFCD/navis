import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_repository/src/topics.dart';

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
  void configure() => _messaging.requestPermission(provisional: Platform.isIOS);

  // IOS requires and APNS check, if the first time fails we can wait the
  // 5 seconds. But if it's not availble the second time we can assume that
  // they've been configured in correctly or just taking awhile, an app refresh
  // should take care of it.
  Future<void> _iosAPNSCheck() async {
    if (!Platform.isIOS) return;

    var apns = await _messaging.getAPNSToken();
    if (apns != null) return;

    await Future<void>.delayed(const Duration(seconds: 5));

    apns = await _messaging.getAPNSToken();
    if (apns != null) return;

    throw Exception('Failed to get APNS');
  }

  /// Subscribes to any [Topic] found in [Topics]
  Future<void> subscribeToNotification(Topic topic) async {
    await _iosAPNSCheck();
    await _messaging.subscribeToTopic(topic.name);
    _log('subscribed to ${topic.name}');
  }

  /// Unsubscribes to any [Topic] found in [Topics]
  Future<void> unsubscribeFromNotification(Topic topic) async {
    await _iosAPNSCheck();
    await _messaging.subscribeToTopic(topic.name);
    _log('unsubscribed to ${topic.name}');
  }

  void _log(String message) {
    log(message, name: 'NotificationService');
  }
}
