import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

// Yeah yeah I know, "why didn't use copyWith", well when I did during the
// initial refactoring ColorScheme refused to change it's brightness, so now
// we're using them directly.
class NavisTheme {
  static ThemeData get standard {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(NavisColors.blue),
        accentColor: NavisColors.secondary,
      ),
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: _appBarTheme,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(NavisColors.blue),
        accentColor: NavisColors.secondary,
        brightness: Brightness.dark,
      ),
      cardTheme: _cardTheme.copyWith(color: Colors.grey[900]),
      dialogTheme: const DialogTheme(backgroundColor: Color(0xff191919)),
      dialogBackgroundColor: const Color(0xff191919),
      canvasColor: const Color(0xff191919),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(color: NavisColors.blue);
  }

  static CardTheme get _cardTheme {
    return CardTheme(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      clipBehavior: Clip.hardEdge,
    );
  }

  static DialogTheme get _dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
