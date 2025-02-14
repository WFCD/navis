import 'package:flutter/material.dart';

abstract class NavisThemes {
  static ThemeData theme(Brightness brightness, ColorScheme? colorScheme) {
    const radius = Radius.circular(8);
    final defaultScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      brightness: brightness,
    );

    final scheme = colorScheme ?? defaultScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      cardTheme: const CardTheme(elevation: 4),
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
