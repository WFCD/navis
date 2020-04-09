// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bio_weapon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BioWeapon _$BioWeaponFromJson(Map<String, dynamic> json) {
  return BioWeapon(
    uniqueName: json['uniqueName'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    aura: json['aura'] as String,
    health: json['health'] as int,
    shield: json['shield'] as int,
    armor: json['armor'] as int,
    power: json['power'] as int,
    masteryReq: json['masteryReq'] as int,
    sprintSpeed: (json['sprintSpeed'] as num)?.toDouble(),
    passiveDescription: json['passiveDescription'] as String,
    abilities: (json['abilities'] as List)
        ?.map((e) =>
            e == null ? null : Ability.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    buildPrice: json['buildPrice'] as int,
    buildTime: json['buildTime'] as int,
    skipBuildTimePrice: json['skipBuildTimePrice'] as int,
    buildQuantity: json['buildQuantity'] as int,
    consumeOnBuild: json['consumeOnBuild'] as bool,
    components: (json['components'] as List)
        ?.map((e) =>
            e == null ? null : Component.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    type: json['type'] as String,
    imageName: json['imageName'] as String,
    category: json['category'] as String,
    tradable: json['tradable'] as bool,
    patchlogs: (json['patchlogs'] as List)
        ?.map((e) =>
            e == null ? null : Patchlog.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    wikiaThumbnail: json['wikiaThumbnail'] as String,
    wikiaUrl: json['wikiaUrl'] as String,
    sex: json['sex'] as String,
    introduced: json['introduced'] as String,
    polarities: (json['polarities'] as List)?.map((e) => e as String)?.toList(),
    color: json['color'] as int,
  );
}

Map<String, dynamic> _$BioWeaponToJson(BioWeapon instance) => <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'imageName': instance.imageName,
      'category': instance.category,
      'tradable': instance.tradable,
      'patchlogs': instance.patchlogs?.map((e) => e?.toJson())?.toList(),
      'aura': instance.aura,
      'health': instance.health,
      'shield': instance.shield,
      'armor': instance.armor,
      'power': instance.power,
      'masteryReq': instance.masteryReq,
      'sprintSpeed': instance.sprintSpeed,
      'buildPrice': instance.buildPrice,
      'buildTime': instance.buildTime,
      'skipBuildTimePrice': instance.skipBuildTimePrice,
      'buildQuantity': instance.buildQuantity,
      'consumeOnBuild': instance.consumeOnBuild,
      'components': instance.components?.map((e) => e?.toJson())?.toList(),
      'abilities': instance.abilities?.map((e) => e?.toJson())?.toList(),
      'polarities': instance.polarities,
      'passiveDescription': instance.passiveDescription,
      'introduced': instance.introduced,
      'sex': instance.sex,
      'wikiaThumbnail': instance.wikiaThumbnail,
      'wikiaUrl': instance.wikiaUrl,
      'color': instance.color,
    };
