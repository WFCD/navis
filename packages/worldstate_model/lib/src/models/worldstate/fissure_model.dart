import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/fissure.dart';

part 'fissure_model.g.dart';

@JsonSerializable()
class VoidFissureModel extends VoidFissure {
  const VoidFissureModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String node,
    String missionType,
    String enemy,
    String tier,
    int tierNum,
    bool active,
    bool expired,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          node: node,
          missionType: missionType,
          enemy: enemy,
          tier: tier,
          tierNum: tierNum,
          active: active,
          expired: expired,
        );

  factory VoidFissureModel.fromJson(Map<String, dynamic> json) {
    return _$VoidFissureModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VoidFissureModelToJson(this);
}
