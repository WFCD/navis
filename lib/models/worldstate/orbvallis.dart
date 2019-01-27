import 'package:codable/codable.dart';

class Vallis extends Coding {
  DateTime expiry;
  bool isWarm;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    isWarm = object.decode('isWarm');
    expiry = DateTime.parse(object.decode('expiry'));

    if (expiry.difference(DateTime.now()) <= Duration(seconds: 1)) {
      isWarm = !isWarm;
      if (isWarm)
        expiry = expiry.add(Duration(minutes: 6, seconds: 40));
      else
        expiry = expiry.add(Duration(minutes: 20));
    }
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry.toIso8601String());
    object.encode('isWarm', isWarm);
  }
}
