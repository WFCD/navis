import 'package:warframestat_client/warframestat_client.dart' show Rarity;

extension RarityX on Rarity {
  String toUniqueName() {
    return switch (this) {
      Rarity.common => 'Bronze',
      Rarity.uncommon => 'Silver',
      Rarity.rare => 'Gold',
      Rarity.legendary => 'Legendary',
    };
  }

  int toColor() {
    return switch (this) {
      Rarity.common => 0xFFbd9177,
      Rarity.uncommon => 0xFFd1d0d1,
      Rarity.rare => 0xFFece175,
      Rarity.legendary => 0xFFb996db,
    };
  }
}
