// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeimosRegionResources _$DeimosRegionResourcesFromJson(
        Map<String, dynamic> json) =>
    DeimosRegionResources(
      tumor: json['tumor'] as int? ?? 0,
      bladder: json['bladder'] as int? ?? 0,
      gills: json['gills'] as int? ?? 0,
    );

Map<String, dynamic> _$DeimosRegionResourcesToJson(
        DeimosRegionResources instance) =>
    <String, dynamic>{
      'tumor': instance.tumor,
      'bladder': instance.bladder,
      'gills': instance.gills,
    };

PoeRegionResources _$PoeRegionResourcesFromJson(Map<String, dynamic> json) =>
    PoeRegionResources(
      meat: json['meat'] as int? ?? 0,
      scales: json['scales'] as int? ?? 0,
      oil: json['oil'] as int? ?? 0,
    );

Map<String, dynamic> _$PoeRegionResourcesToJson(PoeRegionResources instance) =>
    <String, dynamic>{
      'meat': instance.meat,
      'scales': instance.scales,
      'oil': instance.oil,
    };

VallisRegionResources _$VallisRegionResourcesFromJson(
        Map<String, dynamic> json) =>
    VallisRegionResources(
      scrap: json['scrap'] as int,
    );

Map<String, dynamic> _$VallisRegionResourcesToJson(
        VallisRegionResources instance) =>
    <String, dynamic>{
      'scrap': instance.scrap,
    };
