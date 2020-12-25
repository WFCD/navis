import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/themes/colors.dart';

class NotificationChannelDetails {
  static const String single = 'single';
  static const String warframeNews = 'warframeNews';
  static const String cycles = 'cycles';
  static const String resources = 'resources';
  static const String fissures = 'fissures';
  static const String acolytes = 'acolytes';

  static const singleAndroidDetails = AndroidNotificationDetails(
    single,
    'Basic Notifications',
    'One off, unfiltered notifications',
    groupKey: single,
    color: primary,
  );

  static const warframeNewsAndroidNotificationDetails =
      AndroidNotificationDetails(
    warframeNews,
    'Warframe News',
    'Notifications for warframe updates, streams, and prime access',
    groupKey: warframeNews,
    color: primary,
  );

  static const cycleAndroidNotificationDetails = AndroidNotificationDetails(
    cycles,
    'Open world cycles',
    'The start or end of an open world cycle',
    groupKey: cycles,
    color: primary,
  );

  static const resourcesAndroidNotificationDetails = AndroidNotificationDetails(
    resources,
    'Resources',
    'Notifications for invasion resources',
    groupKey: resources,
    color: primary,
  );

  static const fissuresAndroidNotificationDetails = AndroidNotificationDetails(
    fissures,
    'Fissures',
    'Notifications for new fissures',
    groupKey: fissures,
    color: primary,
  );

  static const acolyteAndroidNotificationDetails = AndroidNotificationDetails(
    acolytes,
    'Acolytes activity alerts',
    'Will notifiy tenno of active acolytes',
    groupKey: acolytes,
    color: primary,
  );
}
