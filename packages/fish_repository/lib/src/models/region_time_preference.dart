import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_time_preference.g.dart';

/// {@template region_time_preference}
/// Region weather preference for fish
/// {@endtemplate}
@JsonSerializable()
class RegionTimePreference extends Equatable {
  /// {@macro region_time_preference}
  const RegionTimePreference({required this.appear, required this.prefer});

  /// {@macro region_time_preference}
  factory RegionTimePreference.fromJson(Map<String, dynamic> json) {
    return _$RegionTimePreferenceFromJson(json);
  }

  /// Whether this fish appears during this time.
  final bool appear;

  /// Whether this fish appears more or less during this time.
  final bool prefer;

  /// Returns a json map.
  Map<String, dynamic> toJson() => _$RegionTimePreferenceToJson(this);

  @override
  List<Object?> get props => [appear, prefer];
}
