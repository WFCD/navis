import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navis/models/abstract_classes.dart';

part 'trader.g.dart';

@JsonSerializable()
class VoidTrader extends WorldstateObject {
  VoidTrader({
    String id,
    DateTime activation,
    DateTime expiry,
    this.character,
    this.location,
    this.active,
    this.inventory,
  }) : super(id: id, activation: activation, expiry: expiry);

  factory VoidTrader.fromJson(Map<String, dynamic> json) =>
      _$VoidTraderFromJson(json);

  final String character, location;
  final bool active;
  final List<Inventory> inventory;

  Map<String, dynamic> toJson() => _$VoidTraderToJson(this);
}

@JsonSerializable()
class Inventory extends Equatable {
  Inventory({this.item, this.ducats, this.credits})
      : super([item, ducats, credits]);

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);

  final String item;
  final int ducats, credits;

  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}
