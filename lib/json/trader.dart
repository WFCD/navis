import 'package:codable/codable.dart';

class VoidTrader extends Coding {
  String activation, expiry, character, location;
  bool active;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    activation = object.decode('activation');
    expiry = object.decode('expiry');
    character = object.decode('character');
    location = object.decode('location');
    active = object.decode('active');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('activation', activation);
    object.encode('expiry', expiry);
    object.encode('character', character);
    object.encode('location', location);
    object.encode('active', active);
  }
}
