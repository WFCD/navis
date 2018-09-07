import 'package:flutter/material.dart';

import '../model.dart';
import 'assets.dart';

class DynamicFaction {
  final NavisModel _model;

  DynamicFaction({@required NavisModel model}) : this._model = model;

  sortieColor(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 12))
      return Colors.green;
    else if (timeLeft < Duration(hours: 12) && timeLeft > Duration(hours: 6))
      return Colors.orange[700];
    else if (timeLeft <= Duration(hours: 6)) return Colors.red;
  }

  alertColor(Duration timeLeft) {
    if (timeLeft >= Duration(hours: 1))
      return Colors.green;
    else if (timeLeft < Duration(hours: 1) && timeLeft > Duration(minutes: 10))
      return Colors.orange[700];
    else if (timeLeft <= Duration(minutes: 10)) return Colors.red;
  }

  factionIcon() {
    switch (_model.sortie.faction) {
      case 'Grineer':
        return ImageAssets.grineer;
      case 'Corpus':
        return ImageAssets.corpus;
      case 'Corrupted':
        return ImageAssets.corrupted;
      default:
        return ImageAssets.infested;
    }
  }

  factionColor() {
    switch (_model.sortie.faction) {
      case 'Corpus':
        return Colors.blue[300];
      case 'Grineer':
        return Colors.red[900];
      case 'Corrupted':
        return Colors.yellow[300];
      default:
        return Colors.green;
    }
  }
}
