// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, document_ignores

part of 'spear_requirements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeimosRequirements _$DeimosRequirementsFromJson(Map<String, dynamic> json) =>
    DeimosRequirements(
      requiresSpari: json['spari'] as bool? ?? false,
      requiresEbisu: json['ebisu'] as bool? ?? false,
    );

Map<String, dynamic> _$DeimosRequirementsToJson(DeimosRequirements instance) =>
    <String, dynamic>{
      'spari': instance.requiresSpari,
      'ebisu': instance.requiresEbisu,
    };

PoeRequirements _$PoeRequirementsFromJson(Map<String, dynamic> json) =>
    PoeRequirements(
      requiresLanzo: json['lanzo'] as bool,
      requiresTulok: json['tulok'] as bool,
      requiresPeram: json['peram'] as bool,
    );

Map<String, dynamic> _$PoeRequirementsToJson(PoeRequirements instance) =>
    <String, dynamic>{
      'lanzo': instance.requiresLanzo,
      'tulok': instance.requiresTulok,
      'peram': instance.requiresPeram,
    };
