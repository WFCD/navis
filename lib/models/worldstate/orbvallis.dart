import 'package:codable/codable.dart';

class Vallis extends Coding {
  final currentTime = DateTime.now().millisecondsSinceEpoch;

  DateTime expiry;
  bool isWarm;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    isWarm = object.decode('isWarm');
    expiry = object.decode('expiry');

    if (currentTime > expiry.millisecondsSinceEpoch) {
      isWarm = !isWarm;
      if (isWarm) {
        expiry = expiry.add(Duration(seconds: 400));
      } else {
        expiry = expiry.add(Duration(seconds: 1200));
      }
    }
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encode('isWarm', isWarm);
  }
}
