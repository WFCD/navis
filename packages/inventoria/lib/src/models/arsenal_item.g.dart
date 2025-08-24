// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arsenal_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArsenalItem _$ArsenalItemFromJson(Map<String, dynamic> json) => ArsenalItem(
  uniqueName: json['uniqueName'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  imageName: json['imageName'] as String,
  type: const ItemTypeConverter().fromJson(json['type'] as String),
  productCategory: json['productCategory'] as String,
  masterable: json['masterable'] as bool? ?? false,
);

Map<String, dynamic> _$ArsenalItemToJson(ArsenalItem instance) =>
    <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'description': instance.description,
      'imageName': instance.imageName,
      'type': const ItemTypeConverter().toJson(instance.type),
      'productCategory': instance.productCategory,
      'masterable': instance.masterable,
    };
