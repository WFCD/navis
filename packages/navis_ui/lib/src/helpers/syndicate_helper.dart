import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/colors.dart';
import 'package:navis_ui/src/icons/icons.dart';

enum Syndicates {
  cetus('Ostrons'),
  solaris('Solaris United'),
  entrati('Entrati'),
  nightwave('Nightwave'),
  simaris('Cephalon Simaris'),
  hex('The Hex'),
  unknown('');

  const Syndicates(this.fullName);

  final String fullName;

  static Syndicates syndicateStringToEnum(String name) {
    return Syndicates.values.firstWhere(
      (e) => name.toLowerCase() == e.fullName.toLowerCase(),
      orElse: () => Syndicates.unknown,
    );
  }
}

extension SyndicatesX on Syndicates {
  IconData get syndicateIcon {
    switch (this) {
      case Syndicates.cetus:
        return WarframeSymbols.ostron;
      case Syndicates.solaris:
        return WarframeSymbols.solaris;
      case Syndicates.entrati:
        return WarframeSymbols.entrati;
      case Syndicates.nightwave:
        return WarframeSymbols.nightwave;
      case Syndicates.simaris:
        return WarframeSymbols.simaris;
      case Syndicates.hex:
        return WarframeSymbols.the_hex;
      case Syndicates.unknown:
        return WarframeSymbols.menu_LotusEmblem;
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
      case Syndicates.hex:
        return SyndicateColors.theHexIconColor;
      case Syndicates.unknown:
        return Colors.blue;
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
      case Syndicates.hex:
        return SyndicateColors.theHexBackgroundColor;
      case Syndicates.unknown:
        return Colors.black;
    }
  }
}
