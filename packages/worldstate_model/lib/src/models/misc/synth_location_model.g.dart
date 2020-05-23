// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synth_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SynthLocationModel _$SynthLocationModelFromJson(Map<String, dynamic> json) {
  return SynthLocationModel(
    faction: json['faction'] as String,
    mission: json['mission'] as String,
    planet: json['planet'] as String,
    level: json['level'] as String,
    type: json['type'] as String,
    lastVerified: json['last_verified'] as String,
    spawnRate: json['spawn_rate'] as String,
  );
}

Map<String, dynamic> _$SynthLocationModelToJson(SynthLocationModel instance) =>
    <String, dynamic>{
      'level': instance.level,
      'faction': instance.faction,
      'mission': instance.mission,
      'planet': instance.planet,
      'type': instance.type,
      'last_verified': instance.lastVerified,
      'spawn_rate': instance.spawnRate,
    };
