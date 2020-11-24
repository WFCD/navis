import 'package:flutter/cupertino.dart';
import 'package:warframestat_api_models/objects.dart';

import '../handler.dart';

abstract class NotificationBuilder<T extends WorldstateObject> {
  const NotificationBuilder();

  T toWorldstateObject();

  WorldstateNotification buildNotification();
}
