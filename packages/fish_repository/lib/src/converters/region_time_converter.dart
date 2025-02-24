import 'package:fish_repository/src/models/region_time.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template region_time_converter}
/// Converts a json into the appropriate region time.
/// {@endtemplate}
class RegionTimeConverter<T extends RegionTime> extends JsonConverter<T, Map<String, dynamic>> {
  /// {@macro region_time_converter}
  const RegionTimeConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (json.containsKey('fass')) return DeimosRegionTime.fromJson(json) as T;
    if (json.containsKey('day')) return PoeRegionTime.fromJson(json) as T;
    if (json.containsKey('warm')) return VallisRegionTime.fromJson(json) as T;

    throw Exception('Region time unknown');
  }

  @override
  Map<String, dynamic> toJson(T object) {
    return object.toJson();
  }
}
