// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores, unused_import

part of 'search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchItem _$SearchItemFromJson(Map<String, dynamic> json) => SearchItem(
  uniqueName: json['uniqueName'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  imageName: json['imageName'] as String?,
  type: const ItemTypeConverter().fromJson(json['type'] as String),
  category: json['category'] as String,
  vaulted: json['vaulted'] as bool?,
  wikiaUrl: json['wikiaUrl'] as String?,
  wikiaThumbnail: json['wikiaThumbnail'] as String?,
);

Map<String, dynamic> _$SearchItemToJson(SearchItem instance) =>
    <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'description': instance.description,
      'imageName': instance.imageName,
      'category': instance.category,
      'type': const ItemTypeConverter().toJson(instance.type),
      'vaulted': instance.vaulted,
      'wikiaUrl': instance.wikiaUrl,
      'wikiaThumbnail': instance.wikiaThumbnail,
    };
