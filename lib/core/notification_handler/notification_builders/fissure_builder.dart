import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../constants/notification_channels.dart';
import '../handler.dart';
import 'base_builder.dart';

class FissureNotificationBuilder extends NotificationBuilder<VoidFissure> {
  const FissureNotificationBuilder(this.fissure);

  final Map<String, dynamic> fissure;

  @override
  WorldstateNotification buildNotification() {
    final fissure = toWorldstateObject();

    return WorldstateNotification(
      id: 501,
      title: '${fissure.tier} Fissures',
      body: '${fissure.node} - ${fissure.missionType} - ${fissure.enemy}',
      androidNotificationDetails:
          NotificationChannelDetails.fissuresAndroidNotificationDetails,
    );
  }

  @override
  VoidFissure toWorldstateObject() {
    return VoidFissureModel.fromJson(fissure);
  }
}
