import 'package:codable/codable.dart';

class Earth extends Coding {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final fullCycle = Duration(minutes: 240);

  DateTime expiry;
  bool isDay;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    expiry = DateTime.parse(object.decode('expiry'));
    isDay = object.decode('isDay');

    if (currentTime > expiry.millisecondsSinceEpoch) {
      isDay = !isDay;
      if (isDay) {
        expiry = expiry.add(fullCycle);
      } else {
        expiry = expiry.add(fullCycle);
      }
    }
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encode('isDay', isDay);
  }
}
