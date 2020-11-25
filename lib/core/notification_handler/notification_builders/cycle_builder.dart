import 'package:navis/constants/notification_channels.dart';
import 'package:navis/core/notification_handler/handler.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';

import 'base_builder.dart';

abstract class CycleNotificationBuilder
    extends NotificationBuilder<CycleObject> {
  const CycleNotificationBuilder(this.cycle) : assert(cycle != null);

  final Map<String, dynamic> cycle;

  WorldstateNotification get firstPhase;
  WorldstateNotification get secondPhase;

  @override
  WorldstateNotification buildNotification() {
    final cycleObject = toWorldstateObject();

    return cycleObject.getStateBool ? firstPhase : secondPhase;
  }
}

class EarthNotificationBuilder extends CycleNotificationBuilder {
  EarthNotificationBuilder(Map<String, dynamic> cycleObject)
      : super(cycleObject);

  @override
  WorldstateNotification get firstPhase {
    return const WorldstateNotification(
      id: 31,
      title: 'Earth Morning Cycle',
      body: 'It\'s morning on Earth',
      androidNotificationDetails:
          NotificationChannelDetails.cycleAndroidNotificationDetails,
    );
  }

  @override
  WorldstateNotification get secondPhase {
    return const WorldstateNotification(
      id: 32,
      title: 'Earth Night Cycle',
      body: 'It\'s night on Earth',
      androidNotificationDetails:
          NotificationChannelDetails.cycleAndroidNotificationDetails,
    );
  }

  @override
  CycleObject toWorldstateObject() {
    return EarthModel.fromJson(cycle);
  }
}

class CetusNotificationBuilder extends CycleNotificationBuilder {
  CetusNotificationBuilder(Map<String, dynamic> cycleObject)
      : super(cycleObject);

  @override
  WorldstateNotification get firstPhase {
    return const WorldstateNotification(
      id: 312,
      title: 'Cetus Night Cycle',
      body: 'It\'s night on cetus',
      androidNotificationDetails:
          NotificationChannelDetails.cycleAndroidNotificationDetails,
    );
  }

  @override
  WorldstateNotification get secondPhase {
    return const WorldstateNotification(
      id: 322,
      title: 'Cetus Day Cycle',
      body: 'It\'s day on cetus',
      androidNotificationDetails:
          NotificationChannelDetails.cycleAndroidNotificationDetails,
    );
  }

  @override
  CycleObject toWorldstateObject() {
    return EarthModel.fromJson(cycle);
  }
}

class VallisNotificationBuilder extends CycleNotificationBuilder {
  const VallisNotificationBuilder(Map<String, dynamic> vallis) : super(vallis);

  @override
  WorldstateNotification get firstPhase {
    return const WorldstateNotification(
      id: 21,
      title: 'Vallis Warm',
      body: 'It\'s warm-ish in Orb Vallis',
      androidNotificationDetails:
          NotificationChannelDetails.cycleAndroidNotificationDetails,
    );
  }

  @override
  WorldstateNotification get secondPhase {
    return const WorldstateNotification(
      id: 22,
      title: 'Vallis Cold',
      body: 'It\'s colder in Orb Vallis',
      androidNotificationDetails:
          NotificationChannelDetails.cycleAndroidNotificationDetails,
    );
  }

  @override
  CycleObject toWorldstateObject() {
    return VallisModel.fromJson(cycle);
  }
}
