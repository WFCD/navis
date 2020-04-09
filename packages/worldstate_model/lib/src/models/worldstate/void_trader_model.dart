import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/void_trader.dart';

part 'void_trader_model.g.dart';

@JsonSerializable()
class VoidTraderModel extends VoidTrader {
  const VoidTraderModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String character,
    String location,
    bool active,
    this.inventoryModels,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          character: character,
          location: location,
          active: active,
          inventory: inventoryModels,
        );

  factory VoidTraderModel.fromJson(Map<String, dynamic> json) {
    return _$VoidTraderModelFromJson(json);
  }

  @JsonKey(name: 'inventory')
  final List<InventoryItemModel> inventoryModels;

  Map<String, dynamic> toJson() => _$VoidTraderModelToJson(this);
}

@JsonSerializable()
class InventoryItemModel extends InventoryItem {
  const InventoryItemModel({String item, int ducats, int credits})
      : super(item: item, ducats: ducats, credits: credits);

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) {
    return _$InventoryItemModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InventoryItemModelToJson(this);
}
