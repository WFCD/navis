import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spear_requirements.g.dart';

/// Spear requirements for regions.
sealed class SpearRequirements extends Equatable {
  const SpearRequirements();

  /// Returns a json map.
  Map<String, dynamic> toJson();
}

/// {@template deimos_requirements}
/// Spear requirements on Deimos for any fish caught in this specific region.
/// {@endtemplate}
@JsonSerializable()
class DeimosRequirements extends SpearRequirements {
  /// {@macro deimos_requirements}
  const DeimosRequirements({
    this.requiresSpari = false,
    this.requiresEbisu = false,
  });

  /// {@macro deimos_requirements}
  factory DeimosRequirements.fromJson(Map<String, dynamic> json) {
    return _$DeimosRequirementsFromJson(json);
  }

  /// whether a player can use the spari spear or not for a particular fish.
  @JsonKey(name: 'spari')
  final bool requiresSpari;

  /// whether a player can use the ebisu spear or not for a particular fish.
  @JsonKey(name: 'ebisu')
  final bool requiresEbisu;

  @override
  Map<String, dynamic> toJson() => _$DeimosRequirementsToJson(this);

  @override
  List<Object> get props => [requiresSpari, requiresEbisu];
}

/// {@template poe_requirements}
/// Spear requirements on Plains of Eidolon for any fish caught in this
/// specific region.
/// {@endtemplate}
@JsonSerializable()
class PoeRequirements extends SpearRequirements {
  /// {@macro poe_requirements}
  const PoeRequirements({
    required this.requiresLanzo,
    required this.requiresTulok,
    required this.requiresPeram,
  });

  /// {@macro poe_requirements}
  factory PoeRequirements.fromJson(Map<String, dynamic> json) {
    return _$PoeRequirementsFromJson(json);
  }

  /// whether a player can use the lanzo spear or not for a particular fish.
  @JsonKey(name: 'lanzo')
  final bool requiresLanzo;

  /// whether a player can use the tulok spear or not for a particular fish.
  @JsonKey(name: 'tulok')
  final bool requiresTulok;

  /// whether a player can use the peram spear or not for a particular fish.
  @JsonKey(name: 'peram')
  final bool requiresPeram;

  @override
  Map<String, dynamic> toJson() => _$PoeRequirementsToJson(this);

  @override
  List<Object> get props => [requiresLanzo, requiresTulok, requiresPeram];
}

/// {@template vallis_requirements}
/// Spear requirements on Orb Vallis for any fish caught in this specific
/// region.
///
/// Note: All servofish requires either Shockprod or Stunna Fishing Spear
/// for effective capture.
///
/// This class was only added for completion.
/// {@endtemplate}
class VallisRequirements extends SpearRequirements {
  /// {@macro vallis_requirements}
  const VallisRequirements();

  /// Just a dummy factory that returns a constant instance
  /// of [VallisRequirements]
  // ignore: avoid_unused_constructor_parameters
  factory VallisRequirements.fromJson(Map<String, dynamic>? json) =>
      const VallisRequirements();

  /// See [VallisRequirements]
  bool get requiresShockprod => true;

  /// See [VallisRequirements]
  bool get requiresStunna => true;

  @override
  Map<String, dynamic> toJson() {
    return {'shockprod': requiresShockprod, 'stunna': requiresStunna};
  }

  @override
  List<Object> get props => [requiresShockprod, requiresStunna];
}
