import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';

const earthCycle = Duration(hours: 4);
const cetusDay = Duration(minutes: 100);
const cetusNight = Duration(minutes: 50);

class Earth extends WorldstateObject with CycleModel {
  bool isDay, isCetus;

  @override
  bool get stateBool => isDay;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    isDay = object.decode('isDay');
    isCetus = object.decode('isCetus') ?? false;

    if (expiry.difference(DateTime.now().toUtc()) <=
        const Duration(seconds: 1)) {
      isDay = !isDay;
      if (isDay)
        expiry = isCetus ? expiry.add(cetusDay) : expiry.add(earthCycle);
      else
        expiry = isCetus ? expiry.add(cetusNight) : expiry.add(earthCycle);
    }
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('isDay', isDay);
    object.encode('isCetus', isCetus);
  }
}
