// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unique_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniqueResource _$UniqueResourceFromJson(Map<String, dynamic> json) =>
    UniqueResource(
      name: json['name'] as String,
      thumbnail: json['thumb'] as String?,
      wikiUrl: json['wiki'] as String?,
    );

Map<String, dynamic> _$UniqueResourceToJson(UniqueResource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumb': instance.thumbnail,
      'wiki': instance.wikiUrl,
    };
