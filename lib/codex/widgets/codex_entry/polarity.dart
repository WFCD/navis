import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/utils/mod_polarity.dart';

enum Rarity { common, uncommon, rare, legendary }

class Polarity extends StatelessWidget {
  const Polarity({super.key, required this.polarity, this.rarity});

  final String polarity;
  final Rarity? rarity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    var _color = isDark ? Colors.white : null;

    if (rarity != null) {
      _color = () {
        switch (rarity!) {
          case Rarity.common:
            return const Color(0xFFCA9A87);
          case Rarity.rare:
            return const Color(0xFFFEEBC1);
          case Rarity.legendary:
            return Colors.white;
          case Rarity.uncommon:
            return Colors.white;
        }
      }();
    }

    return SizedBox(
      width: 20,
      child: getPolarity(polarity, color: _color),
    );
  }
}

class PreinstalledPolarties extends StatelessWidget {
  const PreinstalledPolarties({super.key, required this.polarities});

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
