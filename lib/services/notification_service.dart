import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:navis/models/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

final service = NotificationService();

Future<void> callNotifications(WorldState state) async {
  await service.cetusNotification(state.cetus);
  await service.vallisNotification(state.vallis);
}

class NotificationService {
  NotificationService() {
    plugin.initialize(_initializationSettings);
  }

  final plugin = FlutterLocalNotificationsPlugin();

  static const _initializationSettingsAndroid =
      AndroidInitializationSettings('ic_nightmare');
  static const _initializationSettingsIOS = IOSInitializationSettings();
  static const _initializationSettings = InitializationSettings(
      _initializationSettingsAndroid, _initializationSettingsIOS);

  Future<void> cetusNotification(Earth cetus) async {
    final pref = await SharedPreferences.getInstance();

    const channel = ChannelDetails(
        'cetus', 'Cetus cycle', 'Notifications for both Day and night');

    final cetusId = pref.getStringList('cetusIds') ?? <String>[];

    final id = DateTime.now().millisecond;

    if (!cetusId.contains(cetus.id)) {
      if (cetus.isDay) {
        if (pref.getBool('day') ?? false) {
          final day =
              Details(id, 'Cetus Day Cycle', 'It is currently day in Cetus');

          await _buildNotification(channel, day);
        }
      } else {
        if (pref.getBool('night') ?? false) {
          final night = Details(
              id, 'Cetus Night Cycle', 'It is currently night in cetus');

          await _buildNotification(channel, night);
        }
      }

      cetusId.add(cetus.id);
      await pref.setStringList('cetusIds', cetusId);
    }
  }

  Future<void> vallisNotification(Vallis vallis) async {
    final pref = await SharedPreferences.getInstance();

    const channel = ChannelDetails('vallis', 'Orb Vallis Cycle',
        'Notifications for both cold and warm cycles');

    final vallisId = pref.getStringList('vallisIds') ?? <String>[];

    final id = DateTime.now().millisecond;

    if (!vallisId.contains(vallis.id)) {
      if (vallis.isWarm) {
        if (pref.getBool('warm') ?? false) {
          final warm =
              Details(id, 'Orb Vallis Warm Cycle', 'It\'s warm in Orb Vallis');

          await _buildNotification(channel, warm);
        }
      } else {
        if (pref.getBool('cold') ?? false) {
          final cold =
              Details(id, 'Orb Vallis Cold Cycle', 'It\'s cold in Orb Vallis');

          await _buildNotification(channel, cold);
        }
      }

      if (vallisId.length > 10) vallisId.removeRange(0, 8);

      vallisId.add(vallis.id);
      await pref.setStringList('vallisIds', vallisId);
    }
  }

  Future<void> _buildNotification(
      ChannelDetails channel, Details details) async {
    final androidSpecifics = AndroidNotificationDetails(
        channel.id, channel.name, channel.description,
        importance: Importance.Max, priority: Priority.High);

    final iOSSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics =
        NotificationDetails(androidSpecifics, iOSSpecifics);

    await plugin.show(
        details.id, details.title, details.body, platformChannelSpecifics);
  }
}

class ChannelDetails {
  const ChannelDetails(this.id, this.name, this.description);

  final String id;
  final String name;
  final String description;
}

class Details {
  Details(this.id, this.title, this.body);

  final int id;
  final String title;
  final String body;
}
