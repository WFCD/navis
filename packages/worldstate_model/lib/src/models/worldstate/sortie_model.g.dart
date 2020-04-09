// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sortie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortieModel _$SortieModelFromJson(Map<String, dynamic> json) {
  return SortieModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    boss: json['boss'] as String,
    faction: json['faction'] as String,
    variantModels: (json['variants'] as List)
        ?.map((e) =>
            e == null ? null : VariantModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SortieModelToJson(SortieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'boss': instance.boss,
      'faction': instance.faction,
      'variants': instance.variantModels,
    };

VariantModel _$VariantModelFromJson(Map<String, dynamic> json) {
  return VariantModel(
    missionType: json['missionType'] as String,
    modifier: json['modifier'] as String,
    modifierDescription: json['modifierDescription'] as String,
    node: json['node'] as String,
  );
}

Map<String, dynamic> _$VariantModelToJson(VariantModel instance) =>
    <String, dynamic>{
      'missionType': instance.missionType,
      'modifier': instance.modifier,
      'modifierDescription': instance.modifierDescription,
      'node': instance.node,
    };
