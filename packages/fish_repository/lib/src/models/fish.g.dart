// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores

part of 'fish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeimosFish _$DeimosFishFromJson(Map<String, dynamic> json) => DeimosFish(
      name: json['name'] as String,
      thumbnail: json['thumb'] as String,
      wikiUrl: Uri.parse(json['wiki'] as String),
      uniqueResources: (json['unique'] as List<dynamic>)
          .map((e) => UniqueResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] as String,
      time: DeimosRegionTime.fromJson(json['time'] as Map<String, dynamic>),
      rarity: json['rarity'] as String,
      bait: Bait.fromJson(json['bait'] as Map<String, dynamic>),
      spearRequirments:
          DeimosRequirements.fromJson(json['spear'] as Map<String, dynamic>),
      maximumMass: json['maximumMass'] as String,
      small: FishSize<DeimosRegionResources>.fromJson(
          json['small'] as Map<String, dynamic>),
      medium: FishSize<DeimosRegionResources>.fromJson(
          json['medium'] as Map<String, dynamic>),
      large: FishSize<DeimosRegionResources>.fromJson(
          json['large'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeimosFishToJson(DeimosFish instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumb': instance.thumbnail,
      'wiki': instance.wikiUrl.toString(),
      'unique': instance.uniqueResources,
      'location': instance.location,
      'time': instance.time,
      'rarity': instance.rarity,
      'bait': instance.bait,
      'spear': instance.spearRequirments,
      'maximumMass': instance.maximumMass,
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

PoeFish _$PoeFishFromJson(Map<String, dynamic> json) => PoeFish(
      name: json['name'] as String,
      thumbnail: json['thumb'] as String,
      wikiUrl: Uri.parse(json['wiki'] as String),
      uniqueResources:
          UniqueResource.fromJson(json['unique'] as Map<String, dynamic>),
      location: json['location'] as String,
      time: PoeRegionTime.fromJson(json['time'] as Map<String, dynamic>),
      rarity: json['rarity'] as String,
      bait: Bait.fromJson(json['bait'] as Map<String, dynamic>),
      spearRequirments:
          PoeRequirements.fromJson(json['spear'] as Map<String, dynamic>),
      maximumMass: json['maximumMass'] as String,
      small: FishSize<PoeRegionResources>.fromJson(
          json['small'] as Map<String, dynamic>),
      medium: FishSize<PoeRegionResources>.fromJson(
          json['medium'] as Map<String, dynamic>),
      large: FishSize<PoeRegionResources>.fromJson(
          json['large'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PoeFishToJson(PoeFish instance) => <String, dynamic>{
      'name': instance.name,
      'thumb': instance.thumbnail,
      'wiki': instance.wikiUrl.toString(),
      'unique': instance.uniqueResources,
      'location': instance.location,
      'time': instance.time,
      'rarity': instance.rarity,
      'bait': instance.bait,
      'spear': instance.spearRequirments,
      'maximumMass': instance.maximumMass,
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

VallisFish _$VallisFishFromJson(Map<String, dynamic> json) => VallisFish(
      name: json['name'] as String,
      thumbnail: json['thumb'] as String,
      wikiUrl: Uri.parse(json['wiki'] as String),
      uniqueResources:
          UniqueResource.fromJson(json['unique'] as Map<String, dynamic>),
      location: json['location'] as String,
      time: VallisRegionTime.fromJson(json['time'] as Map<String, dynamic>),
      rarity: json['rarity'] as String,
      bait: Bait.fromJson(json['bait'] as Map<String, dynamic>),
      maximumPoint: json['maximumPoint'] as String,
      small: FishSize<VallisRegionResources>.fromJson(
          json['small'] as Map<String, dynamic>),
      medium: FishSize<VallisRegionResources>.fromJson(
          json['medium'] as Map<String, dynamic>),
      large: FishSize<VallisRegionResources>.fromJson(
          json['large'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VallisFishToJson(VallisFish instance) =>
    <String, dynamic>{
      'name': instance.name,
      'thumb': instance.thumbnail,
      'wiki': instance.wikiUrl.toString(),
      'unique': instance.uniqueResources,
      'location': instance.location,
      'time': instance.time,
      'rarity': instance.rarity,
      'bait': instance.bait,
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
      'maximumPoint': instance.maximumPoint,
    };
