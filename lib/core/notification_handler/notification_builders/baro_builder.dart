import 'package:navis/constants/notification_channels.dart';
import 'package:navis/core/notification_handler/handler.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:warframestat_api_models/models.dart';
import 'package:warframestat_api_models/src/objects/worldstate_object.dart';

import 'base_builder.dart';

class BaroNotificationBuilder extends NotificationBuilder<VoidTrader> {
  const BaroNotificationBuilder(this.voidTrader);

  final Map<String, dynamic> voidTrader;

  @override
  WorldstateNotification buildNotification() {
    final trader = toWorldstateObject();

    return WorldstateNotification(
      id: 333,
      title: 'Baro has arrived',
      body:
          'Baro Ki\'Teer is ${trader.active ? 'arrived' : 'leaving soon'} tenno',
      androidNotificationDetails:
          NotificationChannelDetails.singleAndroidDetails,
    );
  }

  @override
  VoidTrader toWorldstateObject() {
    return VoidTraderModel.fromJson(voidTrader);
  }
}
