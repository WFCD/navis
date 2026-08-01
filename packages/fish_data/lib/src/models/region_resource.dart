import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_resource.g.dart';

/// {@template region_resource}
/// Base class for region specfic resources.
/// {@endtemplate}
sealed class RegionResources extends Equatable {
  /// {@macro region_resource}
  const RegionResources();

  /// Returns a json map.
  Map<String, dynamic> toJson();
}

/// {@template Deimos_region_resource}
/// Deimos specfic resources.
/// {@endtemplate}
@JsonSerializable()
class DeimosRegionResources extends RegionResources {
  /// {@macro Deimos_region_resource}
  const DeimosRegionResources({
    this.tumor = 0,
    this.bladder = 0,
    this.gills = 0,
  });

  /// {@macro Deimos_region_resource}
  factory DeimosRegionResources.fromJson(Map<String, dynamic> json) {
    return _$DeimosRegionResourcesFromJson(json);
  }

  /// Amount of tumors that one can get from this weight.
  final int tumor;

  /// Amount of bladders that one can get from this weight.
  final int bladder;

  /// Amount of gills that one can get from this weight.
  final int gills;

  /// Returns a json map.
  @override
  Map<String, dynamic> toJson() => _$DeimosRegionResourcesToJson(this);

  @override
  List<Object?> get props => [tumor, bladder, gills];
}

/// {@template poe_region_resource}
/// Plains of Eidolon specfic resources.
/// {@endtemplate}
@JsonSerializable()
class PoeRegionResources extends RegionResources {
  /// {@macro poe_region_resource}
  const PoeRegionResources({
    this.meat = 0,
    this.scales = 0,
    this.oil = 0,
  });

  /// {@macro poe_region_resource}
  factory PoeRegionResources.fromJson(Map<String, dynamic> json) {
    return _$PoeRegionResourcesFromJson(json);
  }

  /// Amount of meat that one can get from this weight.
  final int meat;

  /// Amount of scales that one can get from this weight.
  final int scales;

  /// Amount of oil that one can get from this weight.
  final int oil;

  /// Returns a json map.
  @override
  Map<String, dynamic> toJson() => _$PoeRegionResourcesToJson(this);

  @override
  List<Object?> get props => [meat, scales, oil];
}

/// {@template Vallis_region_resources}
/// Vallis Specfic resources.
/// {@endtemplate}
@JsonSerializable()
class VallisRegionResources extends RegionResources {
  /// {@macro Vallis_region_resources}
  const VallisRegionResources({required this.scrap});

  /// {@macro Vallis_region_resources}
  factory VallisRegionResources.fromJson(Map<String, dynamic> json) {
    return _$VallisRegionResourcesFromJson(json);
  }

  /// Amount of gills that one can get from this weight.
  final int scrap;

  /// Returns a json map.
  @override
  Map<String, dynamic> toJson() => _$VallisRegionResourcesToJson(this);

  @override
  List<Object?> get props => [scrap];
}
