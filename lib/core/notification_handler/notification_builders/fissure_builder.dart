import 'package:navis/constants/notification_channels.dart';
import 'package:navis/core/notification_handler/handler.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:warframestat_api_models/models.dart';
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
