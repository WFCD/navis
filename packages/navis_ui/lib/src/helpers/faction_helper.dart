import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/colors.dart';
import 'package:navis_ui/src/icons/icons.dart';

enum Factions { grineer, corpus, corrupted, infestation, infested, unknown }

extension FactionsX on Factions {
  IconData get factionIcon {
    switch (this) {
      case Factions.grineer:
        return FactionIcons.grineer;
      case Factions.corpus:
        return FactionIcons.corpus;
      case Factions.corrupted:
        return FactionIcons.corrupted;
      case Factions.infestation:
        return FactionIcons.infested;
      case Factions.infested:
        return FactionIcons.infested;
      case Factions.unknown:
        return FactionIcons.sentient;
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
      case Factions.unknown:
        return NavisColors.blue;
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
      case Factions.unknown:
        return NavisColors.blue;
    }
  }
}
