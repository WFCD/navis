import 'package:codable/codable.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/models/abstract_classes.dart';

class Sortie extends WorldstateObject {
  String boss, faction;
  List<Variants> variants;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    variants = object.decodeObjects('variants', () => Variants());
    boss = object.decode('boss');
    faction = object.decode('faction');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encodeObjects('variants', variants);
    object.encode('boss', boss);
    object.encode('faction', faction);
  }

  @override
  List get props => super.props..addAll([boss, faction, variants]);
}

class Variants extends Coding with EquatableMixinBase, EquatableMixin {
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

  @override
  List get props => [missionType, modifier, modifierDescription, node];
}
