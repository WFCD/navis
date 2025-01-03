// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores

part of 'fish_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FishSize<T> _$FishSizeFromJson<T extends RegionResources>(
        Map<String, dynamic> json) =>
    FishSize<T>(
      standing: (json['standing'] as num?)?.toInt(),
      resources: RegionResourcesConverter<T>()
          .fromJson(json['resources'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FishSizeToJson<T extends RegionResources>(
        FishSize<T> instance) =>
    <String, dynamic>{
      'standing': instance.standing,
      'resources': RegionResourcesConverter<T>().toJson(instance.resources),
    };
