import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_repository/src/topics.dart';
import 'package:wfcd_client/wfcd_client.dart';

/// {@template notification_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class NotificationRepository {
  /// {@macro notification_repository}
  NotificationRepository();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void configure() {
    _messaging.requestPermission();
  }

  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    _log('subscribing to ${platform.asString} topic');
    await _messaging.subscribeToTopic(platform.asString);
  }

  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    _log('unsubscribing from ${platform.asString} topic');
    await _messaging.unsubscribeFromTopic(platform.asString);
  }

  Future<void> subscribeToNotification(Topic topic) async {
    _log('subscribing to $topic');
    await _messaging.subscribeToTopic(topic.toString());
  }

  Future<void> unsubscribeFromNotification(Topic topic) async {
    _log('unsubscribing from $topic');
    await _messaging.unsubscribeFromTopic(topic.toString());
  }

  void _log(String message) {
    log(message, name: 'NotificationService');
  }
}
