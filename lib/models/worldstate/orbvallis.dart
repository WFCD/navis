import 'package:codable/codable.dart';

class Vallis extends Coding {
  String expiry;
  bool isWarm;

  Duration get timer => DateTime.parse(expiry).difference(DateTime.now());

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    expiry = object.decode('expiry');
    isWarm = object.decode('isWarm');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encode('isWarm', isWarm);
  }
}
