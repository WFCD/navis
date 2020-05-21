// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissionModel _$MissionModelFromJson(Map<String, dynamic> json) {
  return MissionModel(
    node: json['node'] as String,
    type: json['type'] as String,
    faction: json['faction'] as String,
    minEnemyLevel: json['minEnemyLevel'] as int,
    maxEnemyLevel: json['maxEnemyLevel'] as int,
    maxWaveNum: json['maxWaveNum'] as int,
    nightmare: json['nightmare'] as bool,
    archwingRequired: json['archwingRequired'] as bool,
    rewardModel: json['reward'] == null
        ? null
        : RewardModel.fromJson(json['reward'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MissionModelToJson(MissionModel instance) =>
    <String, dynamic>{
      'node': instance.node,
      'type': instance.type,
      'faction': instance.faction,
      'minEnemyLevel': instance.minEnemyLevel,
      'maxEnemyLevel': instance.maxEnemyLevel,
      'maxWaveNum': instance.maxWaveNum,
      'nightmare': instance.nightmare,
      'archwingRequired': instance.archwingRequired,
      'reward': instance.rewardModel?.toJson(),
    };
