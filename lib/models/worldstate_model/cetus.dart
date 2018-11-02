import 'package:codable/codable.dart';

class Cetus extends Coding {
  bool isDay;
  String timeLeft;
  String expiry;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    isDay = object.decode('isDay');
    timeLeft = object.decode('timeLeft');
    expiry = object.decode('expiry');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('isDay', isDay);
    object.encode('timeLeft', timeLeft);
    object.encode('expiry', expiry);
  }
}
