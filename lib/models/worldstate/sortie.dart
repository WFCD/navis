import 'package:codable/codable.dart';

class Sortie extends Coding {
  DateTime expiry;
  List<Variants> variants;
  String boss, faction;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    expiry = DateTime.parse(object.decode('expiry'));
    variants = object.decodeObjects('variants', () => Variants());
    boss = object.decode('boss');
    faction = object.decode('faction');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encodeObjects('variants', variants);
    object.encode('boss', boss);
    object.encode('faction', faction);
  }
}

class Variants extends Coding {
  String missionType, modifier, modifierDescription, node;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    missionType = object.decode('missionType');
    modifier = object.decode('modifier');
    modifierDescription = object.decode('modifierDescription');
    node = object.decode('node');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('missionType', missionType);
    object.encode('modifier', modifier);
    object.encode('modifierDescription', modifierDescription);
    object.encode('node', node);
  }
}
