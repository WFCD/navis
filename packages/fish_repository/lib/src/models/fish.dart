import 'package:equatable/equatable.dart';
import 'package:fish_repository/fish_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fish.g.dart';

/// {@template fish}
/// Holds data and region information of a fish.
/// {@endtemplate}
sealed class Fish<T extends RegionTime, S extends SpearRequirements,
    R extends RegionResources, U> extends Equatable {
  /// {@macro fish}
  const Fish({
    required this.name,
    required this.thumbnail,
    required this.wikiUrl,
    required this.uniqueResources,
    required this.location,
    required this.time,
    required this.rarity,
    required this.bait,
    required this.spearRequirments,
    required this.maximumMass,
    required this.small,
    required this.medium,
    required this.large,
  });

  /// Fish name.
  final String name;

  /// Fish thumbnail image.
  @JsonKey(name: 'thumb')
  final String thumbnail;

  /// Fish wiki url.
  @JsonKey(name: 'wiki')
  final Uri wikiUrl;

  /// Unique resources.obtained from this fish.
  @JsonKey(name: 'unique')
  final U uniqueResources;

  /// Fish location.
  final String location;

  /// Region specfic time that this fish can appear in.
  @RegionTimeConverter()
  final T time;

  /// Rarity
  final String rarity;

  /// Required or useful baits you can use on this fish.
  final Bait bait;

  /// Spear requirements for this type of fish.
  @JsonKey(name: 'spear')
  @SpearRequirementConverter()
  final S spearRequirments;

  /// Max weight.
  final String maximumMass;

  /// Resources for a small fish.
  final FishSize<R> small;

  /// Resources for a medium fish.
  final FishSize<R> medium;

  /// Resources for a large fish.
  final FishSize<R> large;

  /// Returns a json map
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [
        name,
        thumbnail,
        wikiUrl,
        uniqueResources,
        location,
        time,
        bait,
        spearRequirments,
        maximumMass,
        small,
        medium,
        large,
      ];
}

/// {@template deimos_fish}
/// Creates and instance of a Deimos region fish.
/// {@endtemplate}
@JsonSerializable()
class DeimosFish extends Fish<DeimosRegionTime, DeimosRequirements,
    DeimosRegionResources, List<UniqueResource>> {
  /// {@macro deimos_fish}
  const DeimosFish({
    required super.name,
    required super.thumbnail,
    required super.wikiUrl,
    required super.uniqueResources,
    required super.location,
    required super.time,
    required super.rarity,
    required super.bait,
    required super.spearRequirments,
    required super.maximumMass,
    required super.small,
    required super.medium,
    required super.large,
  });

  /// {@macro fish}
  factory DeimosFish.fromJson(Map<String, dynamic> json) {
    return _$DeimosFishFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$DeimosFishToJson(this);
}

/// {@template poe_fish}
/// Creates a fish instance for fish in PLains of Eidolon.
/// {@endtemplate}
@JsonSerializable()
class PoeFish extends Fish<PoeRegionTime, PoeRequirements, PoeRegionResources,
    UniqueResource> {
  /// {@macro poe_fish}
  const PoeFish({
    required super.name,
    required super.thumbnail,
    required super.wikiUrl,
    required super.uniqueResources,
    required super.location,
    required super.time,
    required super.rarity,
    required super.bait,
    required super.spearRequirments,
    required super.maximumMass,
    required super.small,
    required super.medium,
    required super.large,
  });

  /// {@macro fish}
  factory PoeFish.fromJson(Map<String, dynamic> json) {
    return _$PoeFishFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$PoeFishToJson(this);
}

/// {@template vallis_fish}
/// Creates a fish instance for fish in Vallis.
/// {@endtemplate}
@JsonSerializable()
class VallisFish extends Fish<VallisRegionTime, VallisRequirements,
    VallisRegionResources, UniqueResource> {
  /// {@macro vallis_fish}
  const VallisFish({
    required super.name,
    required super.thumbnail,
    required super.wikiUrl,
    required super.uniqueResources,
    required super.location,
    required super.time,
    required super.rarity,
    required super.bait,
    required this.maximumPoint,
    required super.small,
    required super.medium,
    required super.large,
  }) : super(
          spearRequirments: const VallisRequirements(),
          maximumMass: maximumPoint,
        );

  /// {@macro fish}
  factory VallisFish.fromJson(Map<String, dynamic> json) {
    return _$VallisFishFromJson(json);
  }

  /// Maximum points this fish can have.
  final String maximumPoint;

  @override
  Map<String, dynamic> toJson() => _$VallisFishToJson(this);
}
