import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../constants/notification_channels.dart';
import '../handler.dart';
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
      body: 'Baro Ki\'Teer is '
          '${trader.active ? 'arrived' : 'leaving soon'} tenno',
      androidNotificationDetails:
          NotificationChannelDetails.singleAndroidDetails,
    );
  }

  @override
  VoidTrader toWorldstateObject() {
    return VoidTraderModel.fromJson(voidTrader);
  }
}
