import 'package:equatable/equatable.dart';
import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class VoidTrader extends WorldstateObject {
  const VoidTrader({
    String id,
    DateTime activation,
    DateTime expiry,
    this.character,
    this.location,
    this.active,
    this.inventory,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String character, location;
  final bool active;
  final List<InventoryItem> inventory;

  @override
  List<Object> get props {
    return super.props..addAll([character, location, active, inventory]);
  }
}

class InventoryItem extends Equatable {
  const InventoryItem({this.item, this.ducats, this.credits});

  final String item;
  final int ducats, credits;

  @override
  List<Object> get props => [item, ducats, credits];
}
