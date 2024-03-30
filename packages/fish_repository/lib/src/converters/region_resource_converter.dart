import 'package:fish_repository/src/models/region_resource.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template region_resources_converter}
/// Converts a resources key into the appropriate region resources.
/// {@endtemplate}
class RegionResourcesConverter<T extends RegionResources>
    extends JsonConverter<T, Map<String, dynamic>> {
  /// {@macro region_resources_converter}
  const RegionResourcesConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (json.containsKey('tumor')) {
      return DeimosRegionResources.fromJson(json) as T;
    }

    if (json.containsKey('scrap')) {
      return VallisRegionResources.fromJson(json) as T;
    }

    if (json.containsKey('meat')) return PoeRegionResources.fromJson(json) as T;

    throw Exception('Region resources are unknown');
  }

  @override
  Map<String, dynamic> toJson(RegionResources object) {
    return object.toJson();
  }
}
