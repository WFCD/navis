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
    state = object.decode('state');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('isWarm', isWarm);
    object.encode('state', state);
  }
}
