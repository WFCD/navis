import 'package:warframestat_api_models/entities.dart';
import 'package:warframestat_api_models/models.dart';

import '../../../constants/notification_channels.dart';
import '../../../constants/storage_keys.dart';
import '../handler.dart';
import 'base_builder.dart';

class AcolyteNotificationBuilder extends NotificationBuilder<PersistentEnemy> {
  const AcolyteNotificationBuilder(this.persistentEnemy);

  final Map<String, dynamic> persistentEnemy;

  static const enemyCodeTriggers = <String>[
    NotificationKeys.angstkey,
    NotificationKeys.maliceKey,
    NotificationKeys.maniaKey,
    NotificationKeys.miseryKey,
    NotificationKeys.tormentKey,
    NotificationKeys.violenceKey
  ];

  @override
  // ignore: missing_return
  WorldstateNotification buildNotification() {
    final enemy = toWorldstateObject();

    return WorldstateNotification(
      id: enemy.agentType.codeUnits
          .fold(0, (previousValue, element) => previousValue + element),
      title: 'Acolyte Found',
      body: '${enemy.agentType} was found on ${enemy.lastDiscoveredAt}',
      androidNotificationDetails:
          NotificationChannelDetails.acolyteAndroidNotificationDetails,
    );
  }

  @override
  PersistentEnemy toWorldstateObject() {
    return PersistentEnemyModel.fromJson(persistentEnemy);
  }
}
