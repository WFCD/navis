import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/core/themes/colors.dart';

enum EnemyFaction { grineer, corpus, corrupted, infested }

enum SyndicateFaction { cetus, solaris, nightwave, cephalon_simaris }

Color factionColor(String faction) {
  switch (faction) {
    case 'Corpus':
      return Colors.blue;
    case 'Grineer':
      return Colors.red[700];
    case 'Corrupted':
      return Colors.yellow[300];
    default:
      return Colors.green;
  }
}

const _ostronsBackgroundColor = Color(0xFFB74624);
const _solarisBackgroundColor = Color(0xFF5F3C0D);
const _nightwaveBackgroundColor = Color(0xFF6C1822);
const _simarisBackgroundColor = Color(0xFF5F3C0D);

const _ostronsIconColor = Color(0xFFE8DDAF);
const _solarisIconColor = Color(0xFFD8C38F);
const _nightwaveIconColor = Color(0xFFFFAEAA);
const _simarisIconColor = Color(0xFFEBD18F);

const _grineerIconColor = Color(0xFFb23232);
const _corpusIconColor = Color(0xFF8bdefe);
const _infestIconColor = Color(0xFF2a3c2e);
const _corruptedIconColor = Color(0xFFe9a835);

SyndicateFaction syndicateStringToEnum(String faction) {
  return SyndicateFaction.values.firstWhere((element) {
    final syn = faction.toLowerCase();

    return syn.contains(element.toString().split('.').last);
  }, orElse: () => null);
}

// Convert enum value to readable faction title
String _toTitle<T>(T value) {
  return toBeginningOfSentenceCase(value.toString().replaceAll('_', ' '));
}

extension SyndicateFactionX on SyndicateFaction {
  Color get iconColor {
    switch (this) {
      case SyndicateFaction.cetus:
        return _ostronsIconColor;
      case SyndicateFaction.solaris:
        return _solarisIconColor;
      case SyndicateFaction.nightwave:
        return _nightwaveIconColor;
      case SyndicateFaction.cephalon_simaris:
        return _simarisIconColor;
      default:
        return Colors.white;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case SyndicateFaction.cetus:
        return _ostronsBackgroundColor;
      case SyndicateFaction.solaris:
        return _solarisBackgroundColor;
      case SyndicateFaction.cephalon_simaris:
        return _simarisBackgroundColor;
      case SyndicateFaction.nightwave:
        return _nightwaveBackgroundColor;
      default:
        return primary;
    }
  }

  String get toSyndicateTitle => _toTitle(this);
}

extension EnemyFactionX on EnemyFaction {
  Color get iconColor {
    switch (this) {
      case EnemyFaction.grineer:
        return _grineerIconColor;
      case EnemyFaction.corpus:
        return _corpusIconColor;
      case EnemyFaction.corrupted:
        return _corruptedIconColor;
      default:
        return _infestIconColor;
    }
  }

  String get toEnemyTitle => _toTitle(this);
}
