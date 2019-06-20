import 'package:codable/codable.dart';

import '../abstract_classes.dart';

class Vallis extends WorldstateObject with CycleModel {
  bool isWarm;

  @override
  bool get stateBool => isWarm;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    isWarm = object.decode('isWarm');

    if (expiry.difference(DateTime.now().toUtc()) <=
        const Duration(seconds: 1)) {
      isWarm = !isWarm;
      if (isWarm)
        expiry = expiry.add(const Duration(minutes: 6, seconds: 40));
      else
        expiry = expiry.add(const Duration(minutes: 20));
    }
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('isWarm', isWarm);
  }
}
