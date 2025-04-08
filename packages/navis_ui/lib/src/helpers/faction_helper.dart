import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';

enum Factions { grineer, corpus, corrupted, infestation, infested, narmer, unknown }

extension FactionsX on Factions {
  IconData get factionIcon {
    switch (this) {
      case Factions.grineer:
        return WarframeIcons.factionsGrineer;
      case Factions.corpus:
        return WarframeIcons.factionsCorpus;
      case Factions.corrupted:
        return WarframeIcons.factionsCorrupted;
      case Factions.infestation:
        return WarframeIcons.factionsInfested;
      case Factions.infested:
        return WarframeIcons.factionsInfested;
      case Factions.narmer:
        return WarframeIcons.factionsNarmer;
      case Factions.unknown:
        return WarframeIcons.factionsSentient;
    }
  }

  /// Faction's icon color.
  Color get iconColor {
    switch (this) {
      case Factions.grineer:
        return FactionIconColors.grineer;
      case Factions.corpus:
        return FactionIconColors.corpus;
      case Factions.corrupted:
        return FactionIconColors.corrupted;
      case Factions.infestation:
        return FactionIconColors.infested;
      case Factions.infested:
        return FactionIconColors.infested;
      case Factions.narmer:
        return FactionIconColors.corrupted;
      case Factions.unknown:
        return Colors.blue;
    }
  }

  /// Faction's primary color.
  Color get primaryColor {
    switch (this) {
      case Factions.corpus:
        return Colors.blue;
      case Factions.grineer:
        return Colors.red[700]!;
      case Factions.corrupted:
        return Colors.yellow[300]!;
      case Factions.infestation:
        return Colors.green;
      case Factions.infested:
        return Colors.green;
      case Factions.narmer:
        return Colors.yellow[300]!;
      case Factions.unknown:
        return Colors.blue;
    }
  }
}
