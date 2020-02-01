import 'package:flutter/material.dart';

import 'colors.dart';

class NavisTheming {
  static ThemeData get light {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      accentColor: accentColor,
      splashColor: accentColor,
    );
  }

  // ThemeData get dark => ThemeData(
  //       brightness: Brightness.dark,
  //       primaryColor: _primaryColor,
  //       accentColor: _accentColor,
  //       cardColor: const Color(0xFF2C2C2C),
  //       dialogBackgroundColor: const Color(0xFF212121),
  //       scaffoldBackgroundColor: const Color(0xFF212121),
  //       canvasColor: const Color(0xFF212121),
  //     );

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColorBrightness: Brightness.dark,
      accentColor: accentColor,
      primaryColor: primaryColor,
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
}
