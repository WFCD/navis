import 'package:codable/codable.dart';

class Earth extends Coding {
  String expiry, timeLeft;
  bool isDay;

  Duration get timer => DateTime.parse(expiry).difference(DateTime.now());

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    expiry = object.decode('expiry');
    isDay = object.decode('isDay');
    timeLeft = object.decode('timeLeft');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encode('isDay', isDay);
    object.encode('timeLeft', timeLeft);
  }
}
