import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

// Yeah yeah I know, "why didn't use copyWith", well when I did during the
// initial refactoring ColorScheme refused to change it's brightness, so now
// we're using them directly.
class NavisTheme {
  static ThemeData get standard {
    return ThemeData(
      colorScheme: _colorScheme(),
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      navigationBarTheme: _navigationBarThemeData,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: _appBarTheme,
      colorScheme: _colorScheme(Brightness.dark),
      cardTheme: _cardTheme.copyWith(color: Colors.grey[900]),
      dialogTheme: const DialogTheme(backgroundColor: NavisColors.canvasColor),
      dialogBackgroundColor: NavisColors.canvasColor,
      canvasColor: NavisColors.canvasColor,
      navigationBarTheme: _navigationBarThemeData,
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

  static NavigationBarThemeData get _navigationBarThemeData {
    return NavigationBarThemeData(
      backgroundColor: NavisColors.canvasColor,
      indicatorColor: Colors.transparent,
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: NavisColors.secondary);
        }
        return null;
      }),
    );
  }
}
