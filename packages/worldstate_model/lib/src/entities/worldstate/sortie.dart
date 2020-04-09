import 'package:equatable/equatable.dart';
import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class Sortie extends WorldstateObject {
  const Sortie({
    String id,
    DateTime activation,
    DateTime expiry,
    this.boss,
    this.faction,
    this.variants,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String boss, faction;
  final List<Variant> variants;

  @override
  List<Object> get props => super.props..addAll([boss, faction, variants]);
}

class Variant extends Equatable {
  const Variant({
    this.missionType,
    this.modifier,
    this.modifierDescription,
    this.node,
  });

  final String missionType, modifier, modifierDescription, node;

  @override
  List<Object> get props => [missionType, modifier, modifierDescription, node];
}
