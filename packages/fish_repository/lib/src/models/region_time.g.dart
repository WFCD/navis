// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores

part of 'region_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeimosRegionTime _$DeimosRegionTimeFromJson(Map<String, dynamic> json) => DeimosRegionTime(
      string: json['string'] as String,
      fass: RegionTimePreference.fromJson(json['fass'] as Map<String, dynamic>),
      vome: RegionTimePreference.fromJson(json['vome'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeimosRegionTimeToJson(DeimosRegionTime instance) => <String, dynamic>{
      'string': instance.string,
      'fass': instance.fass,
      'vome': instance.vome,
    };

PoeRegionTime _$PoeRegionTimeFromJson(Map<String, dynamic> json) => PoeRegionTime(
      string: json['string'] as String,
      day: RegionTimePreference.fromJson(json['day'] as Map<String, dynamic>),
      night: RegionTimePreference.fromJson(json['night'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PoeRegionTimeToJson(PoeRegionTime instance) => <String, dynamic>{
      'string': instance.string,
      'day': instance.day,
      'night': instance.night,
    };

VallisRegionTime _$VallisRegionTimeFromJson(Map<String, dynamic> json) => VallisRegionTime(
      string: json['string'] as String,
      warm: RegionTimePreference.fromJson(json['warm'] as Map<String, dynamic>),
      cold: RegionTimePreference.fromJson(json['cold'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VallisRegionTimeToJson(VallisRegionTime instance) => <String, dynamic>{
      'string': instance.string,
      'warm': instance.warm,
      'cold': instance.cold,
    };
