import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../constants/notification_channels.dart';
import '../handler.dart';
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
