import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xE51A5090);
  static const _accentColor = Color(0xFF00BC8C);

  static Color get primaryColor => _primaryColor;

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        splashColor: _accentColor,
      );

  // ThemeData get dark => ThemeData(
  //       brightness: Brightness.dark,
  //       primaryColor: _primaryColor,
  //       accentColor: _accentColor,
  //       cardColor: const Color(0xFF2C2C2C),
  //       dialogBackgroundColor: const Color(0xFF212121),
  //       scaffoldBackgroundColor: const Color(0xFF212121),
  //       canvasColor: const Color(0xFF212121),
  //     );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        accentColor: _accentColor,
        primaryColor: _primaryColor,
        primarySwatch: Colors.grey,
        disabledColor: Colors.grey,
        cardTheme: CardTheme(
          color: Colors.grey[900],
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
        ),
        dialogTheme: const DialogTheme(backgroundColor: Color(0xff191919)),
        canvasColor: const Color(0xff191919),
        backgroundColor: Colors.grey[900],
        scaffoldBackgroundColor: const Color(0xFF121212),
      );
}
