import 'package:flutter/material.dart';

import 'colors.dart';

class NavisTheming {
  static final _lightBase = ThemeData.from(
    colorScheme: const ColorScheme.light(
      primary: primary,
      primaryVariant: primaryVariant,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
    ),
  );

  static final _darkBase = ThemeData.from(
    colorScheme: const ColorScheme.dark(
      primary: primary,
      primaryVariant: primaryVariant,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
    ),
  );

  static final ThemeData light = _lightBase.copyWith(
    cardTheme: _cardTheme,
    appBarTheme: _appBarTheme,
  );

  static final ThemeData dark = _darkBase.copyWith(
    cardTheme: _cardTheme.copyWith(color: Colors.grey[900]),
    dialogTheme: const DialogTheme(backgroundColor: Color(0xff191919)),
    dialogBackgroundColor: const Color(0xff191919),
    canvasColor: const Color(0xff191919),
    appBarTheme: _appBarTheme,
  );

  static const _appBarTheme = AppBarTheme(color: primary);

  static final _cardTheme = CardTheme(
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    clipBehavior: Clip.hardEdge,
  );
}
