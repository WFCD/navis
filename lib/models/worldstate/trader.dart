import 'package:codable/codable.dart';

class VoidTrader extends Coding {
  String id, character, location;
  DateTime activation, expiry;
  bool active;

  List<Inventory> inventory;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    activation = DateTime.parse(object.decode('activation'));
    expiry = DateTime.parse(object.decode('expiry')).toLocal();
    character = object.decode('character');
    location = object.decode('location');
    active = object.decode('active');
    inventory = object.decodeObjects('inventory', () => Inventory());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('id', id);
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
