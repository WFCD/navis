import 'package:equatable/equatable.dart';
import 'package:fish_repository/src/models/region_time_preference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'region_time.g.dart';

/// {@template fish_time}
/// Base class for Region times
/// {@endtemplate}
sealed class RegionTime extends Equatable {
  /// {@macro fish_time}
  const RegionTime({required this.string});

  /// String representation for prefered cycle time.
  final String string;

  /// Returns a json map.
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [string];
}

/// {template deimos_region_time}
/// Deimos specific region times.
/// {endtemplate}
@JsonSerializable()
class DeimosRegionTime extends RegionTime {
  /// (@macro deimos_region_time)
  const DeimosRegionTime({
    required super.string,
    required this.fass,
    required this.vome,
  });

  /// (@macro deimos_region_time)
  factory DeimosRegionTime.fromJson(Map<String, dynamic> json) {
    return _$DeimosRegionTimeFromJson(json);
  }

  /// Preferences for Fass.
  final RegionTimePreference fass;

  /// Preferences for Vome.
  final RegionTimePreference vome;

  /// Returns a json map.
  @override
  Map<String, dynamic> toJson() => _$DeimosRegionTimeToJson(this);

  @override
  List<Object?> get props => super.props..addAll([fass, vome]);
}

/// {template poe_region_time}
/// Plains of eidolon specific region times.
/// {endtemplate}
@JsonSerializable()
class PoeRegionTime extends RegionTime {
  /// (@macro poe_region_time)
  const PoeRegionTime({
    required super.string,
    required this.day,
    required this.night,
  });

  /// (@macro poe_region_time)
  factory PoeRegionTime.fromJson(Map<String, dynamic> json) {
    return _$PoeRegionTimeFromJson(json);
  }

  /// Preferences for day time.
  final RegionTimePreference day;

  /// Preferences for night time.
  final RegionTimePreference night;

  /// Returns a json map.
  @override
  Map<String, dynamic> toJson() => _$PoeRegionTimeToJson(this);

  @override
  List<Object?> get props => super.props..addAll([day, night]);
}

/// {template vallis_region_time}
/// Vallis specific region times.
/// {endtemplate}
@JsonSerializable()
class VallisRegionTime extends RegionTime {
  /// (@macro vallis_region_time)
  const VallisRegionTime({
    required super.string,
    required this.warm,
    required this.cold,
  });

  /// (@macro vallis_region_time)
  factory VallisRegionTime.fromJson(Map<String, dynamic> json) {
    return _$VallisRegionTimeFromJson(json);
  }

  /// Preferences for warm weather.
  final RegionTimePreference warm;

  /// Preferences for warm weather.
  final RegionTimePreference cold;

  /// Returns a json map.
  @override
  Map<String, dynamic> toJson() => _$VallisRegionTimeToJson(this);

  @override
  List<Object?> get props => super.props..addAll([warm, cold]);
}
