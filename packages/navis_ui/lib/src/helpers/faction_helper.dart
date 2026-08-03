import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

extension FactionX on Faction {
  IconData get factionIcon {
    return switch (this) {
      Faction.grineer => WarframeIcons.factionsGrineer,
      Faction.corpus => WarframeIcons.factionsCorpus,
      Faction.corrupted => WarframeIcons.factionsCorrupted,
      Faction.infested => WarframeIcons.factionsInfested,
      Faction.narmer => WarframeIcons.factionsNarmer2,
      Faction.sentient => WarframeIcons.factionsSentient,
      _ => WarframeIcons.simaris,
    };
  }

  /// Faction's icon color.
  Color get iconColor {
    return switch (this) {
      Faction.grineer => FactionIconColors.grineer,
      Faction.corpus => FactionIconColors.corpus,
      Faction.corrupted => FactionIconColors.corrupted,
      Faction.infested => FactionIconColors.infested,
      Faction.narmer => FactionIconColors.corrupted,
      _ => Colors.blue,
    };
  }

  /// Faction's primary color.
  Color get primaryColor {
    return switch (this) {
      Faction.corpus => Colors.blue,
      Faction.grineer => Colors.red[700]!,
      Faction.corrupted => Colors.yellow[300]!,
      Faction.infested => Colors.green,
      Faction.narmer => Colors.yellow[300]!,
      _ => Colors.blue,
    };
  }
}
