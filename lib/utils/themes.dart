import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes {
  Future<ThemeData> savedTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final savedTheme = preferences.getInt('Theme') ?? 0;
    final savedAccent = preferences.getInt('accentColor');

    if (savedTheme == 0) {
      if (savedAccent != null)
        return darkTheme(accentColor: Color(savedAccent));
      else
        return darkTheme();
    } else {
      if (savedAccent != null)
        return lightTheme(accentColor: Color(savedAccent));
      else
        return lightTheme();
    }
  }

  Future<void> save(int brightness, {Color accentColor}) async {
    final preferences = await SharedPreferences.getInstance();

    preferences.setInt('Theme', brightness);

    if (accentColor != null)
      preferences.setInt('accentColor', accentColor.value);
  }

  ThemeData darkTheme({Color accentColor}) {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: accentColor ?? const Color.fromRGBO(26, 80, 144, .9),
        accentColor: accentColor ?? const Color.fromRGBO(26, 80, 144, .9),
        cardColor: const Color(0xFF2C2C2C),
        scaffoldBackgroundColor: const Color(0xFF212121),
        splashColor: accentColor ?? const Color.fromRGBO(26, 80, 144, .9));
  }

  ThemeData lightTheme({Color accentColor}) {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: accentColor ?? const Color.fromRGBO(26, 80, 144, .9),
        accentColor: accentColor ?? const Color.fromRGBO(26, 80, 144, .9),
        splashColor: accentColor ?? const Color.fromRGBO(26, 80, 144, .9));
  }
}
