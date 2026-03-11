// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warframe_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarframeItem _$WarframeItemFromJson(Map<String, dynamic> json) => WarframeItem(
  uniqueName: json['uniqueName'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  imageName: json['imageName'] as String?,
  category: json['category'] as String,
  type: const ItemTypeConverter().fromJson(json['type'] as String),
  vaulted: json['vaulted'] as bool? ?? false,
  masterable: json['masterable'] as bool? ?? false,
  maxLevelCap: (json['maxLevelCap'] as num?)?.toInt(),
  wikiaUrl: json['wikiaUrl'] as String?,
  wikiaThumbnail: json['wikiaThumbnail'] as String?,
);

Map<String, dynamic> _$WarframeItemToJson(WarframeItem instance) =>
    <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'description': instance.description,
      'imageName': instance.imageName,
      'category': instance.category,
      'vaulted': instance.vaulted,
      'masterable': instance.masterable,
      'maxLevelCap': instance.maxLevelCap,
      'wikiaUrl': instance.wikiaUrl,
      'wikiaThumbnail': instance.wikiaThumbnail,
      'type': const ItemTypeConverter().toJson(instance.type),
    };
