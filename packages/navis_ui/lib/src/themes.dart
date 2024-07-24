import 'package:flutter/material.dart';
import 'package:navis_ui/src/colors/colors.dart';

abstract class NavisThemes {
  static ThemeData get light =>
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

  static ThemeData get dark =>
      ThemeData(useMaterial3: true, colorScheme: darkColorScheme);
}
