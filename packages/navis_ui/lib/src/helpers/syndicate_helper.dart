import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/colors.dart';
import 'package:navis_ui/src/icons/icons.dart';

enum Syndicates { cetus, solaris, entrati, nightwave, simaris, unknown }

Syndicates syndicateStringToEnum(String faction) {
  return Syndicates.values.firstWhere(
    (e) {
      final syn = faction.toLowerCase();
      return syn.contains(e.toString().split('.').last);
    },
    orElse: () => Syndicates.unknown,
  );
}

extension SyndicatesX on Syndicates {
  IconData get syndicateIcon {
    switch (this) {
      case Syndicates.cetus:
        return GenesisAssets.ostron;
      case Syndicates.solaris:
        return GenesisAssets.solaris;
      case Syndicates.entrati:
        return GenesisAssets.entrati;
      case Syndicates.nightwave:
        return GenesisAssets.nightwave;
      case Syndicates.simaris:
        return GenesisAssets.simaris;
      case Syndicates.unknown:
        return GenesisAssets.hexis;
    }
  }

  /// Syndicate's primary Color
  Color get primaryColor {
    switch (this) {
      case Syndicates.cetus:
        return SyndicateColors.ostronsIconColor;
      case Syndicates.solaris:
        return SyndicateColors.solarisIconColor;
      case Syndicates.entrati:
        return SyndicateColors.entratiIconColor;
      case Syndicates.nightwave:
        return SyndicateColors.nightwaveIconColor;
      case Syndicates.simaris:
        return SyndicateColors.simarisIconColor;
      case Syndicates.unknown:
        return NavisColors.blue;
    }
  }

  /// Syndicate's secondary color.
  ///
  /// Usually the secondary color is used on background.
  Color get secondryColor {
    switch (this) {
      case Syndicates.cetus:
        return SyndicateColors.ostronsBackgroundColor;
      case Syndicates.solaris:
        return SyndicateColors.solarisBackgroundColor;
      case Syndicates.entrati:
        return SyndicateColors.entratiBackgroundColor;
      case Syndicates.simaris:
        return SyndicateColors.simarisBackgroundColor;
      case Syndicates.nightwave:
        return SyndicateColors.nightwaveBackgroundColor;
      case Syndicates.unknown:
        return Colors.white;
    }
  }
}
