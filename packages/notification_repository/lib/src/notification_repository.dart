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

  Future<bool> toggleFilter(String topic, {required bool enable}) async {
    try {
      final status = await _permissionsClient.notificationsStatus();
      if (status.isPermanentlyDenied || status.isRestricted) {
        log('Permission is ${status.name} opening app settings');
        await _permissionsClient.openPermissionSettings();
        return false;
      }

      if (status.isDenied) {
        log('Requesting notification permissions');
        final updatedStatus = await _permissionsClient.requestNotifications();
        if (updatedStatus.isDenied) return false;
      }

      log('${enable ? 'subscribed' : 'unsubscribed'} to $topic');
      await storage.toggleNotification(topic);
      if (enable) {
        await _messaging.subscribeToTopic(topic);
      } else {
        await _messaging.unsubscribeFromTopic(topic);
      }

      return storage.fetchNotificationStatus(topic);
    } on Exception catch (error, stackTrace) {
      throw Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
