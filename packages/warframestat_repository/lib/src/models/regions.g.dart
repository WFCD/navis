// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores, unused_import

part of 'regions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CraigJunction _$CraigJunctionFromJson(Map<String, dynamic> json) =>
    CraigJunction(
      uniqueName: json['uniqueName'] as String,
      name: json['name'] as String,
      systemIndex: (json['systemIndex'] as num).toInt(),
      minEnemyLevel: (json['minEnemyLevel'] as num).toInt(),
      maxEnemyLevel: (json['maxEnemyLevel'] as num).toInt(),
      mastery: (json['mastery'] as num).toInt(),
      targetSystemIndex: (json['targetSystemIndex'] as num).toInt(),
    );

Map<String, dynamic> _$CraigJunctionToJson(CraigJunction instance) =>
    <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'systemIndex': instance.systemIndex,
      'minEnemyLevel': instance.minEnemyLevel,
      'maxEnemyLevel': instance.maxEnemyLevel,
      'mastery': instance.mastery,
      'targetSystemIndex': instance.targetSystemIndex,
    };

CraigNode _$CraigNodeFromJson(Map<String, dynamic> json) => CraigNode(
      uniqueName: json['uniqueName'] as String,
      name: json['name'] as String,
      systemIndex: (json['systemIndex'] as num).toInt(),
      minEnemyLevel: (json['minEnemyLevel'] as num).toInt(),
      maxEnemyLevel: (json['maxEnemyLevel'] as num).toInt(),
      mastery: (json['mastery'] as num).toInt(),
      nodeType: (json['nodeType'] as num).toInt(),
      masteryReq: (json['masteryReq'] as num).toInt(),
      missionIndex: (json['missionIndex'] as num).toInt(),
      factionIndex: (json['factionIndex'] as num).toInt(),
    );

Map<String, dynamic> _$CraigNodeToJson(CraigNode instance) => <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'systemIndex': instance.systemIndex,
      'minEnemyLevel': instance.minEnemyLevel,
      'maxEnemyLevel': instance.maxEnemyLevel,
      'mastery': instance.mastery,
      'nodeType': instance.nodeType,
      'masteryReq': instance.masteryReq,
      'missionIndex': instance.missionIndex,
      'factionIndex': instance.factionIndex,
    };
