import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../constants/notification_channels.dart';
import '../handler.dart';
import 'base_builder.dart';

class AlertNotificationBuilder extends NotificationBuilder<Alert> {
  const AlertNotificationBuilder(this.alert);

  final Map<String, dynamic> alert;

  @override
  // ignore: missing_return
  WorldstateNotification buildNotification() {
    final _alert = toWorldstateObject();

    return WorldstateNotification(
      id: 406,
      title: _alert.mission.node,
      body: '${_alert.mission.type}(${_alert.mission.faction})'
          ' | ${_alert.mission.minEnemyLevel} - ${_alert.mission.maxEnemyLevel} |'
          ' | ${_alert.mission.reward.itemString}',
      androidNotificationDetails:
          NotificationChannelDetails.singleAndroidDetails,
    );
  }

  @override
  Alert toWorldstateObject() {
    return AlertModel.fromJson(alert);
  }
}
