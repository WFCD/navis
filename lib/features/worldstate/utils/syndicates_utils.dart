import 'package:flutter/material.dart';

enum SyndicateFactions { ostrons, solaris_united, nightwave }

const _ostronsBackgroundColor = Color(0xFFB74624);
const _solarisBackgroundColor = Color(0xFF5F3C0D);
const _nightwaveBackgroundColor = Color(0xFF6C1822);

const _ostronsIconColor = Color(0xFFE8DDAF);
const _solarisIconColor = Color(0xFFD8C38F);
const _nightwaveIconColor = Color(0xFFFFAEAA);

// TODO: remove into their seperate features
// const _simaris = Color(0xFF5F3C0D);
// const _simarisIconColor = Color(0xFFEBD18F);

SyndicateFactions syndicateStringToEnum(String faction) {
  return SyndicateFactions.values.firstWhere((element) {
    final syn = faction.toLowerCase().replaceAll(' ', '_');

    return element.toString().contains(syn);
  }, orElse: () => null);
}

extension SyndicateFactionX on SyndicateFactions {
  Color syndicateIconColor() {
    switch (this) {
      case SyndicateFactions.ostrons:
        return _ostronsIconColor;
      case SyndicateFactions.solaris_united:
        return _solarisIconColor;
      case SyndicateFactions.nightwave:
        return _nightwaveIconColor;
      default:
        return Colors.white;
    }
  }

  Color syndicateBackgroundColor() {
    switch (this) {
      case SyndicateFactions.ostrons:
        return _ostronsBackgroundColor;
      case SyndicateFactions.solaris_united:
        return _solarisBackgroundColor;
      default:
        return _nightwaveBackgroundColor;
    }
  }

  String syndicateEnumToString() {
    switch (this) {
      case SyndicateFactions.ostrons:
        return 'Ostrons';
      case SyndicateFactions.solaris_united:
        return 'Solaris United';
      default:
        return 'Nightwave';
    }
  }
}
