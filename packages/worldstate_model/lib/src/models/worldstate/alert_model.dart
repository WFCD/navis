import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/alert.dart';

import 'mission_model.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel extends Alert {
  const AlertModel({
    String id,
    DateTime activation,
    DateTime expiry,
    bool active,
    this.missionModel,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          active: active,
          mission: missionModel,
        );

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return _$AlertModelFromJson(json);
  }

  @JsonKey(name: 'mission')
  final MissionModel missionModel;

  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}
