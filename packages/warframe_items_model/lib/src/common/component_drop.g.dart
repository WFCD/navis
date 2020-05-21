// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_drop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentDrop _$ComponentDropFromJson(Map<String, dynamic> json) {
  return ComponentDrop(
    location: json['location'] as String,
    type: json['type'] as String,
    rarity: json['rarity'] as String,
    rotation: json['rotation'] as String,
    chance: (json['chance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ComponentDropToJson(ComponentDrop instance) =>
    <String, dynamic>{
      'location': instance.location,
      'type': instance.type,
      'rarity': instance.rarity,
      'rotation': instance.rotation,
      'chance': instance.chance,
    };
