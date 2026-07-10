import 'package:flutter/widgets.dart';
import 'package:warframe_common/warframe_common.dart';

extension RarityX on Rarity {
  String toUniqueName() {
    return switch (this) {
      Rarity.common => 'Bronze',
      Rarity.uncommon => 'Silver',
      Rarity.rare => 'Gold',
      Rarity.legendary => 'Legendary',
    };
  }

  Color toColor() {
    return switch (this) {
      Rarity.common => const Color(0xFFbd9177),
      Rarity.uncommon => const Color(0xFFd1d0d1),
      Rarity.rare => const Color(0xFFece175),
      Rarity.legendary => const Color(0xFFb996db),
    };
  }
}
