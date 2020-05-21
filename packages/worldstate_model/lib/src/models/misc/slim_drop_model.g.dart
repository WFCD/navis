// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slim_drop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlimDropModel _$SlimDropModelFromJson(Map<String, dynamic> json) {
  return SlimDropModel(
    place: json['place'] as String,
    item: json['item'] as String,
    rarity: json['rarity'] as String,
    dropchance: json['chance'],
  );
}

Map<String, dynamic> _$SlimDropModelToJson(SlimDropModel instance) =>
    <String, dynamic>{
      'place': instance.place,
      'item': instance.item,
      'rarity': instance.rarity,
      'chance': instance.dropchance,
    };
