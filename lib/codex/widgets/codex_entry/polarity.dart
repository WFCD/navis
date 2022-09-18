import 'package:flutter/material.dart';
import 'package:navis/codex/utils/mod_polarity.dart';

enum Rarity { common, uncommon, rare, legendary }

extension StringX on String {
  Rarity fromString() {
    return Rarity.values.byName(toLowerCase());
  }
}

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
        // Already being checked for null.
        // ignore: avoid-non-null-assertion
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
      // This is what just worked for the style.
      // ignore: no-magic-number
      width: 20,
      child: getPolarity(polarity, color: _color),
    );
  }
}
