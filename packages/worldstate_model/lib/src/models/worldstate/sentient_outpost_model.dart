import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/sentient_outpost.dart';

import 'mission_model.dart';

part 'sentient_outpost_model.g.dart';

@JsonSerializable()
class SentientOutpostModel extends SentientOutpost {
  const SentientOutpostModel({
    String id,
    DateTime activation,
    DateTime expiry,
    bool active,
    this.missionModel,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          mission: missionModel,
          active: active,
        );

  factory SentientOutpostModel.fromJson(Map<String, dynamic> json) {
    return _$SentientOutpostModelFromJson(json);
  }

  @JsonKey(name: 'mission')
  final MissionModel missionModel;

  Map<String, dynamic> toJson() => _$SentientOutpostModelToJson(this);
}
