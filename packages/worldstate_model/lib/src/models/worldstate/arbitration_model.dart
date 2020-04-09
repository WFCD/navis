import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/arbitration.dart';

part 'arbitration_model.g.dart';

@JsonSerializable()
class ArbitrationModel extends Arbitration {
  const ArbitrationModel({
    DateTime activation,
    DateTime expiry,
    String node,
    String enemy,
    String type,
    this.archwing,
    this.sharkwing,
  }) : super(
          activation: activation,
          expiry: expiry,
          node: node,
          enemy: enemy,
          type: type,
          archwingRequired: (archwing ?? false) || (sharkwing ?? false),
        );

  factory ArbitrationModel.fromJson(Map<String, dynamic> json) {
    return _$ArbitrationModelFromJson(json);
  }

  final bool archwing, sharkwing;

  Map<String, dynamic> toJson() => _$ArbitrationModelToJson(this);
}
