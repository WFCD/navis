import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_repository/src/notification_storage.dart';
import 'package:permissions_client/permissions_client.dart';

/// {@template notification_repository}
/// Main entry to start push notifications via firebase.
///
/// Notifications are just simple topics and nothing to complex about them.
/// {@endtemplate}
class NotificationRepository {
  /// {@macro notification_repository}
  NotificationRepository(this._permissionsClient, this.storage);

  final PermissionsClient _permissionsClient;
  final NotificationStorage storage;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> toggleFilter(String topic, {required bool enable}) async {
    try {
      log('${enable ? 'subscribed' : 'unsubscribed'} to $topic');
      final status = await _permissionsClient.notificationsStatus();
      if (status.isPermanentlyDenied || status.isRestricted) {
        await _permissionsClient.openPermissionSettings();
        return;
      }

      if (status.isDenied) {
        final updatedStatus = await _permissionsClient.requestNotifications();
        if (updatedStatus.isDenied) return;
      }

      await storage.toggleNotification(topic);

      if (enable) {
        await _messaging.subscribeToTopic(topic);
      } else {
        await _messaging.unsubscribeFromTopic(topic);
      }
    } on Exception catch (error, stackTrace) {
      throw Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
