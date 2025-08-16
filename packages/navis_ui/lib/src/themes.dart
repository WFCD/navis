import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class NavisThemes {
  static ColorScheme _defaultScheme(Brightness brightness) => ColorScheme.fromSeed(
    seedColor: const Color(0xFF3F51B5),
    brightness: brightness,
  );

  static ThemeData theme(Brightness brightness, ColorScheme? colorScheme) {
    const radius = Radius.circular(8);
    final scheme = colorScheme ?? _defaultScheme(brightness);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      appBarTheme:
          // It's supposed to change when the theme changes but guess it's bugged or something? This line is a work around
          AppBarTheme(systemOverlayStyle: brightness.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
      // Need this set to false to use 2024 version
      // ignore: deprecated_member_use
      progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.resolveWith((state) {
          final isSelected = state.contains(WidgetState.selected);

          return IconThemeData(color: isSelected ? scheme.secondary : null);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((state) {
          final isSelected = state.contains(WidgetState.selected);

          return TextStyle(color: isSelected ? scheme.secondary : null);
        }),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        ),
      ),
    );
  }
}
