import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:navis/models/export.dart';
import 'package:shared_preferences/shared_preferences.dart';

final service = NotificationService();

Future<void> callNotifications(WorldState state) async {
  await service.cetusNotification(state.cetus);
  await service.vallisNotification(state.vallis);
  await service.sortieNotification(state.sortie);
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

    final cetusIds = pref.getStringList('cetusIds') ?? <String>[];

    final id = DateTime.now().millisecond;

    if (!cetusIds.contains(cetus.id)) {
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

      await _idHandler('cetusIds', cetus.id, cetusIds);
    }
  }

  Future<void> vallisNotification(Vallis vallis) async {
    final pref = await SharedPreferences.getInstance();

    const channel = ChannelDetails('vallis', 'Orb Vallis Cycle',
        'Notifications for both cold and warm cycles');

    final vallisIds = pref.getStringList('vallisIds') ?? <String>[];

    final id = DateTime.now().millisecond;

    if (!vallisIds.contains(vallis.id)) {
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

      await _idHandler('vallisIds', vallis.id, vallisIds);
    }
  }

  Future<void> sortieNotification(Sortie sortie) async {
    final pref = await SharedPreferences.getInstance();

    const channel = ChannelDetails('sortie', 'Sorties', '');

    final sortieIds = pref.getStringList('sortieIds') ?? <String>[];
    final id = DateTime.now().millisecond;

    if (!sortieIds.contains(sortie.id)) {
      if (pref.getBool('sorties') ?? false) {
        final sortie = Details(id, 'Sortie', 'A new Sortie is available');

        await _buildNotification(channel, sortie);
      }

      await _idHandler('sortieIds', sortie.id, sortieIds);
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

  Future<void> _idHandler(String key, String id, List<String> idList) async {
    final pref = await SharedPreferences.getInstance();

    if (idList.length > 10) idList.removeRange(0, 8);

    idList.add(id);
    await pref.setStringList(key, idList);
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
