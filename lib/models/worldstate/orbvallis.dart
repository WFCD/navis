import 'package:codable/codable.dart';

import '../abstract_classes.dart';

class Vallis extends WorldstateObject with CycleModel {
  bool isWarm;

  @override
  bool get stateBool => isWarm;

  @override
  DateTime get expiry {
    if (super.expiry.isBefore(DateTime.now().toUtc())) {
      isWarm = !isWarm;
      if (isWarm)
        return super.expiry.add(const Duration(minutes: 6, seconds: 40));
      else
        super.expiry.add(const Duration(minutes: 20));
    }

    return super.expiry;
  }

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    isWarm = object.decode('isWarm');
    state = object.decode('state');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('isWarm', isWarm);
    object.encode('state', state);
  }
}
