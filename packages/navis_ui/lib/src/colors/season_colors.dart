import 'dart:ui';

abstract class SeasonColors {
  static const spring = Color(0xFF98FB98);
  static const summer = Color(0xFF90835c);
  static const autumn = Color(0xFFCC5500);
  static const winter = Color(0xFFADD8E6);

  static Color? color(String? season) {
    return switch (season) {
      'spring' => spring,
      'summer' => summer,
      'autumn' => autumn,
      'winter' => winter,
      _ => null,
    };
  }
}
