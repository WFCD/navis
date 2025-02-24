import 'dart:convert';

import 'package:fish_repository/fish_repository.dart';
import 'package:flutter/services.dart';

/// An enum for the different fishing regions.
enum FishingRegion {
  /// Deimos
  deimos,

  /// Plains of Eidolon
  poe,

  /// Orb Vallis
  vallis
}

/// Loads the correct fishing data depending on [FishingRegion]
Future<List<Fish<T, S, R, U>>>
    loadFishResources<T extends RegionTime, S extends SpearRequirements, R extends RegionResources, U>(
  FishingRegion region,
) async {
  final resourcesJson = switch (region) {
    FishingRegion.deimos => await rootBundle.loadString(Assets.fish.deimos),
    FishingRegion.poe => await rootBundle.loadString(Assets.fish.poe),
    FishingRegion.vallis => await rootBundle.loadString(Assets.fish.vallis),
  };

  final resources = List<Map<String, dynamic>>.from(
    json.decode(resourcesJson) as List<dynamic>,
  );

  return switch (region) {
    FishingRegion.deimos => resources.map(DeimosFish.fromJson).toList(),
    FishingRegion.poe => resources.map(PoeFish.fromJson).toList(),
    FishingRegion.vallis => resources.map(VallisFish.fromJson).toList(),
  } as List<Fish<T, S, R, U>>;
}
