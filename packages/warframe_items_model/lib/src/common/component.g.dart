// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Component _$ComponentFromJson(Map<String, dynamic> json) {
  return Component(
    uniqueName: json['uniqueName'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    itemCount: json['itemCount'] as num,
    imageName: json['imageName'] as String,
    tradable: json['tradable'] as bool,
    drops: (json['drops'] as List)
        ?.map((e) => e == null
            ? null
            : ComponentDrop.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'uniqueName': instance.uniqueName,
      'name': instance.name,
      'description': instance.description,
      'imageName': instance.imageName,
      'tradable': instance.tradable,
      'itemCount': instance.itemCount,
      'drops': instance.drops?.map((e) => e?.toJson())?.toList(),
    };
