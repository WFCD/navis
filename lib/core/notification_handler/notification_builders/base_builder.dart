import 'package:wfcd_client/objects.dart';

import '../handler.dart';

abstract class NotificationBuilder<T extends WorldstateObject> {
  const NotificationBuilder();

  T toWorldstateObject();

  WorldstateNotification buildNotification();
}
