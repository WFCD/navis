import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const theme = AppTheme._();

  static const _primaryColor = Color(0xE51A5090);
  static final _accentColor = Colors.blueAccent[400];

  ThemeData get light => ThemeData(
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

  // TODO(Orn): add amoled theme don't really like it but I must
  ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        primaryColorBrightness: Brightness.dark,
        accentColor: _accentColor,
        primaryColor: const Color(0xFF1f1f1f),
        disabledColor: Colors.grey,
        cardColor: const Color(0xFF1d1d1d),
        dialogBackgroundColor: const Color(0xff191919),
        canvasColor: const Color(0xff191919),
        backgroundColor: const Color(0xff191919),
        scaffoldBackgroundColor: const Color(0xFF121212),
      );
}
