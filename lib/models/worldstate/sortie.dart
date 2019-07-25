import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navis/models/abstract_classes.dart';

part 'sortie.g.dart';

@JsonSerializable()
class Sortie extends WorldstateObject {
  Sortie({
    String id,
    DateTime activation,
    DateTime expiry,
    this.boss,
    this.faction,
    this.variants,
  }) : super(id: id, activation: activation, expiry: expiry);

  factory Sortie.fromJson(Map<String, dynamic> json) => _$SortieFromJson(json);

  final String boss, faction;
  final List<Variants> variants;

  Map<String, dynamic> toJson() => _$SortieToJson(this);
}

@JsonSerializable()
class Variants extends Equatable {
  Variants({
    this.missionType,
    this.modifier,
    this.modifierDescription,
    this.node,
  }) : super([missionType, modifier, modifierDescription, node]);

  factory Variants.fromJson(Map<String, dynamic> json) =>
      _$VariantsFromJson(json);

  final String missionType, modifier, modifierDescription, node;

  Map<String, dynamic> toJson() => _$VariantsToJson(this);
}
