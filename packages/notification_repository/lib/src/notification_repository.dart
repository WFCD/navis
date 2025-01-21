import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_repository/src/topics.dart';

/// {@template notification_repository}
/// Main entry to start push notifications via firebase.
///
/// Notifications are just simple topics and nothing to complex about them.
/// {@endtemplate}
class NotificationRepository {
  /// {@macro notification_repository}
  NotificationRepository();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Prompts the user for notification permissions
  ///
  /// Has a platform check inside the lib itself.
  Future<void> requestPermission() {
    return _messaging.requestPermission(provisional: Platform.isIOS);
  }

  Future<bool> hasPermission() async {
    final settings = await _messaging.getNotificationSettings();
    final authorization = settings.authorizationStatus;

    if (authorization == AuthorizationStatus.authorized ||
        authorization == AuthorizationStatus.provisional) {
      return true;
    }

    return false;
  }

  // IOS requires and APNS check, if the first time fails we can wait the
  // 5 seconds. But if it's not availble the second time we can assume that
  // they've been configured incorrectly or just taking awhile, an app refresh
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

  /// Subscribes or unsubscribes from the given topic
  Future<void> updateTopic(Topic topic, {required bool value}) async {
    if (!(await hasPermission())) return;

    await _iosAPNSCheck();

    value
        ? await _messaging.subscribeToTopic(topic.name)
        : await _messaging.unsubscribeFromTopic(topic.name);

    log('${value ? 'subscribed' : 'unsubscribed'} to ${topic.name}');
  }
}
