import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/colors.dart';

abstract class NavisThemes {
  static ThemeData theme(Brightness brightness, ColorScheme? colorScheme) {
    const radius = Radius.circular(8);
    final scheme =
        colorScheme ?? (brightness.isDark ? darkColorScheme : lightColorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      cardTheme: const CardTheme(elevation: 4),
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
