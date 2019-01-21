import 'package:codable/codable.dart';

class Cetus extends Coding {
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  bool isDay;
  String timeLeft;
  DateTime expiry;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    isDay = object.decode('isDay');
    timeLeft = object.decode('timeLeft');
    expiry = DateTime.parse(object.decode('expiry'));

    if (currentTime > expiry.millisecondsSinceEpoch) {
      isDay = !isDay;
      if (isDay) {
        expiry = expiry.add(Duration(minutes: 000));
      } else {
        expiry = expiry.add(Duration(minutes: 50));
      }
    }
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('isDay', isDay);
    object.encode('timeLeft', timeLeft);
    object.encode('expiry', expiry);
  }
}
