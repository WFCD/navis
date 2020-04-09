import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/kuva.dart';

part 'kuva_model.g.dart';

@JsonSerializable()
class KuvaModel extends Kuva {
  const KuvaModel({
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

  factory KuvaModel.fromJson(Map<String, dynamic> json) {
    return _$KuvaModelFromJson(json);
  }

  final bool archwing, sharkwing;

  Map<String, dynamic> toJson() => _$KuvaModelToJson(this);
}
