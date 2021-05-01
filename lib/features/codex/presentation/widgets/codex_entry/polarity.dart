import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../utils/mod_polarity.dart';

enum Rarity { common, uncommon, rare, legendary }

class Polarity extends StatelessWidget {
  const Polarity({Key? key, required this.polarity, this.rarity})
      : super(key: key);

  final String polarity;
  final Rarity? rarity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).isDark;

    var _color = isDark ? Colors.white : null;

    if (rarity != null) {
      _color = () {
        switch (rarity) {
          case Rarity.common:
            return const Color(0xFFCA9A87);
          case Rarity.rare:
            return const Color(0xFFFEEBC1);
          case Rarity.legendary:
            return Colors.white;
          default:
            return Colors.white;
        }
      }();
    }

    return Container(
      width: 20,
      child: getPolarity(polarity, color: _color),
    );
  }
}

class PreinstalledPolarties extends StatelessWidget {
  const PreinstalledPolarties({Key? key, required this.polarities})
      : super(key: key);

  final List<String> polarities;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final p in polarities)
          Polarity(polarity: toBeginningOfSentenceCase(p) ?? ''),
      ],
    );
  }
}

extension StringX on String {
  Rarity fromString() {
    return Rarity.values
        .firstWhere((e) => e.toString().contains(toLowerCase()));
  }
}
