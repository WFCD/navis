// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FishSize<T> _$FishSizeFromJson<T extends RegionResources>(
        Map<String, dynamic> json) =>
    FishSize<T>(
      standing: json['standing'] as int?,
      resources: RegionResourcesConverter<T>()
          .fromJson(json['resources'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FishSizeToJson<T extends RegionResources>(
        FishSize<T> instance) =>
    <String, dynamic>{
      'standing': instance.standing,
      'resources': RegionResourcesConverter<T>().toJson(instance.resources),
    };
