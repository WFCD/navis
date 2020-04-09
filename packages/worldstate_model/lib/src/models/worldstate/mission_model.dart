import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/mission.dart';

import 'reward_model.dart';

part 'mission_model.g.dart';

@JsonSerializable()
class MissionModel extends Mission {
  const MissionModel({
    String node,
    String type,
    String faction,
    int minEnemyLevel,
    int maxEnemyLevel,
    int maxWaveNum,
    bool nightmare,
    bool archwingRequired,
    this.rewardModel,
  }) : super(
          node: node,
          type: type,
          faction: faction,
          minEnemyLevel: minEnemyLevel,
          maxEnemyLevel: maxEnemyLevel,
          maxWaveNum: maxWaveNum,
          nightmare: nightmare,
          archwingRequired: archwingRequired,
          reward: rewardModel,
        );

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return _$MissionModelFromJson(json);
  }

  @JsonKey(name: 'reward')
  final RewardModel rewardModel;

  Map<String, dynamic> toJson() => _$MissionModelToJson(this);
}
