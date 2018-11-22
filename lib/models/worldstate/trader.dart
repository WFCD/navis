import 'package:codable/codable.dart';

class VoidTrader extends Coding {
  String activation, expiry, character, location;
  bool active;

  List<Inventory> inventory;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    activation = object.decode('activation');
    expiry = object.decode('expiry');
    character = object.decode('character');
    location = object.decode('location');
    active = object.decode('active');
    inventory = object.decodeObjects('inventory', () => Inventory());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('activation', activation);
    object.encode('expiry', expiry);
    object.encode('character', character);
    object.encode('location', location);
    object.encode('active', active);
    object.encodeObjects('inventory', inventory);
  }
}

class Inventory extends Coding {
  String item;
  int ducats, credits;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    item = object.decode('item');
    ducats = object.decode('ducats');
    credits = object.decode('credits');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('item', item);
    object.encode('ducats', ducats);
    object.encode('credits', credits);
  }
}
