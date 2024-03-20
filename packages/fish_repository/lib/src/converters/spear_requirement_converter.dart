import 'package:fish_repository/src/models/spear_requirements.dart';
import 'package:json_annotation/json_annotation.dart';

/// {@template region_time_converter}
/// Converts a json into the appropriate region time.
/// {@endtemplate}
class SpearRequirementConverter<T extends SpearRequirements>
    extends JsonConverter<T, Map<String, dynamic>> {
  /// {@macro region_time_converter}
  const SpearRequirementConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (json.containsKey('lanzo')) return PoeRequirements.fromJson(json) as T;

    if (json.containsKey('ebisu')) {
      return DeimosRequirements.fromJson(json) as T;
    }

    throw Exception('Requirement unknown');
  }

  @override
  Map<String, dynamic> toJson(T object) {
    return object.toJson();
  }
}
