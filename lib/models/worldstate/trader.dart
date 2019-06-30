import 'package:codable/codable.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/models/abstract_classes.dart';

class VoidTrader extends WorldstateObject {
  String character, location;
  bool active;
  List<Inventory> inventory;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    character = object.decode('character');
    location = object.decode('location');
    active = object.decode('active');
    inventory = object.decodeObjects('inventory', () => Inventory());
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('character', character);
    object.encode('location', location);
    object.encode('active', active);
    object.encodeObjects('inventory', inventory);
  }

  @override
  List get props =>
      super.props..addAll([character, location, active, inventory]);
}

class Inventory extends Coding with EquatableMixinBase, EquatableMixin {
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

  @override
  List get props => [item, ducats, credits];
}
