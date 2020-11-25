import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../constants/storage_keys.dart';
import '../notification_handler/notification_builders/acolyte_builder.dart';
import '../notification_handler/notification_builders/alert_builder.dart';
import '../notification_handler/notification_builders/baro_builder.dart';
import '../notification_handler/notification_builders/base_builder.dart';
import '../notification_handler/notification_builders/cycle_builder.dart';
import '../notification_handler/notification_builders/darvo_builder.dart';
import '../notification_handler/notification_builders/fissure_builder.dart';
import '../utils/notification_filter.dart';

Future<void> handler(Map<String, dynamic> data) async {
  final id = data['data']['id'] as String;
  final object = json.decode(data['data']['worldstateobject'] as String)
      as Map<String, dynamic>;

  if (id == NotificationKeys.warmKey || id == NotificationKeys.coldKey) {
    await _showNotification(VallisNotificationBuilder(object));
  } else if (id == NotificationKeys.earthDayKey ||
      id == NotificationKeys.earthNightKey) {
    await _showNotification(EarthNotificationBuilder(object));
  } else if (id == NotificationKeys.dayKey || id == NotificationKeys.nightKey) {
    await _showNotification(CetusNotificationBuilder(object));
  } else if (AcolyteNotificationBuilder.enemyCodeTriggers.contains(id)) {
    await _showNotification(AcolyteNotificationBuilder(object));
  } else if (id == NotificationKeys.alertsKey) {
    await _showNotification(AlertNotificationBuilder(object));
  } else if (id == NotificationKeys.baroKey) {
    await _showNotification(BaroNotificationBuilder(object));
  } else if (id == NotificationKeys.darvoKey) {
    await _showNotification(DarvoNotificationBuilder(object));
  } else if (LocalizedFilter.tiers.contains(id)) {
    await _showNotification(FissureNotificationBuilder(object));
  }
}

Future<void> _showNotification(NotificationBuilder builder) async {
  final localNotificationplugin = FlutterLocalNotificationsPlugin();
  final notification = builder.buildNotification();

  if (notification == null) return;

  await localNotificationplugin.show(notification.id, notification.title,
      notification.body, notification.notificationDetails);
}

class WorldstateNotification {
  const WorldstateNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.androidNotificationDetails,
    this.iosNotificationDetails = const IOSNotificationDetails(),
  })  : assert(id != null || id < 0),
        assert(title != null),
        assert(body != null),
        assert(androidNotificationDetails != null);

  final int id;
  final String title, body;
  final AndroidNotificationDetails androidNotificationDetails;
  final IOSNotificationDetails iosNotificationDetails;

  NotificationDetails get notificationDetails {
    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }
}
