import 'package:flutter/material.dart';

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
