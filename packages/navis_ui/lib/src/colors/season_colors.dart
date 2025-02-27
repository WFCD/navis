import 'dart:ui';

abstract class SeasonColors {
  static const winter = Color(0xFFADD8E6);
  static const summer = Color(0xFFFF7F50);
  static const spring = Color(0xFF98FB98);
  static const autumn = Color(0xFFCC5500);

  static Color? color(String? season) {
    return switch (season) {
      'winter' => winter,
      'summer' => summer,
      'spring' => spring,
      'autumn' => autumn,
      _ => null,
    };
  }
}
