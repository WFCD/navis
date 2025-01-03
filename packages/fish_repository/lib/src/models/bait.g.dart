// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores

part of 'bait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bait _$BaitFromJson(Map<String, dynamic> json) => Bait(
      name: json['name'] as String,
      thumbnail: json['thumb'] as String?,
      recommended: json['recommended'] as bool? ?? false,
    );

Map<String, dynamic> _$BaitToJson(Bait instance) => <String, dynamic>{
      'name': instance.name,
      'thumb': instance.thumbnail,
      'recommended': instance.recommended,
    };
