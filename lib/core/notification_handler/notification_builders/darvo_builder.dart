import 'package:navis/constants/notification_channels.dart';
import 'package:navis/core/notification_handler/handler.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:warframestat_api_models/models.dart';

import 'base_builder.dart';

class DarvoNotificationBuilder extends NotificationBuilder<DarvoDeal> {
  const DarvoNotificationBuilder(this.darvoDeal);

  final Map<String, dynamic> darvoDeal;

  @override
  // ignore: missing_return
  WorldstateNotification buildNotification() {
    final deal = toWorldstateObject();

    return WorldstateNotification(
      id: 450,
      title: 'Darvo Deal',
      body: '${deal.item} is on sale for ${deal.discount}% off '
          'or ${deal.salePrice}p if you don\'t want to do the math',
      androidNotificationDetails:
          NotificationChannelDetails.singleAndroidDetails,
    );
  }

  @override
  DarvoDeal toWorldstateObject() {
    return DarvoDealModel.fromJson(darvoDeal);
  }
}
