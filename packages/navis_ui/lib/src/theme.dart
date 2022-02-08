import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

// Yeah yeah I know, "why didn't use copyWith", well when I did during the
// initial refactoring ColorScheme refused to change it's brightness, so now
// we're using them directly.
class NavisTheme {
  static ThemeData get standard {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: generateMaterialColor(NavisColors.blue),
        secondary: NavisColors.secondary,
      ),
      // appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      dialogTheme: _dialogTheme,
      navigationBarTheme: _navigationBarThemeData,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: generateMaterialColor(NavisColors.blue),
        secondary: NavisColors.secondary,
        brightness: Brightness.dark,
      ),
      cardTheme: _cardTheme.copyWith(color: Colors.grey[900]),
      dialogTheme: const DialogTheme(backgroundColor: NavisColors.canvasColor),
      dialogBackgroundColor: NavisColors.canvasColor,
      canvasColor: NavisColors.canvasColor,
      navigationBarTheme: _navigationBarThemeData,
    );
  }

  static CardTheme get _cardTheme {
    return CardTheme(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
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
      indicatorColor: Colors.transparent,
      height: 60,
      iconTheme: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const IconThemeData(color: NavisColors.secondary);
        }
        return null;
      }),
    );
  }
}
