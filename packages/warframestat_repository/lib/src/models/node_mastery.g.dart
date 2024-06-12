// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_mastery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeMastery _$NodeMasteryFromJson(Map<String, dynamic> json) => NodeMastery(
      name: json['name'] as String,
      uniqueName: json['uniqueName'] as String,
      systemIndex: (json['systemIndex'] as num).toInt(),
      nodeType: (json['nodeType'] as num).toInt(),
      masteryReq: (json['masteryReq'] as num).toInt(),
      missionIndex: (json['missionIndex'] as num).toInt(),
      factionIndex: (json['factionIndex'] as num).toInt(),
      minEnemyLevel: (json['minEnemyLevel'] as num).toInt(),
      maxEnemyLevel: (json['maxEnemyLevel'] as num).toInt(),
      mastery: (json['mastery'] as num).toInt(),
    );

Map<String, dynamic> _$NodeMasteryToJson(NodeMastery instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uniqueName': instance.uniqueName,
      'systemIndex': instance.systemIndex,
      'nodeType': instance.nodeType,
      'masteryReq': instance.masteryReq,
      'missionIndex': instance.missionIndex,
      'factionIndex': instance.factionIndex,
      'minEnemyLevel': instance.minEnemyLevel,
      'maxEnemyLevel': instance.maxEnemyLevel,
      'mastery': instance.mastery,
    };
