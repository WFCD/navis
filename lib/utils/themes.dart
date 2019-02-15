import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  Future<ThemeData> savedTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final savedTheme = preferences.getInt('Theme') ?? 0;

    if (savedTheme == 0) {
      return darkTheme();
    } else {
      return lightTheme();
    }
  }

  Future<void> save(int brightness,
      {Color primaryColor, Color accentColor}) async {
    final preferences = await SharedPreferences.getInstance();

    preferences.setInt('Theme', brightness);

    if (accentColor != null)
      preferences.setInt('accentColor', accentColor.value);

    if (primaryColor != null)
      preferences.setInt('primaryColor', primaryColor.value);
  }

  ThemeData defaultTheme({bool light = false}) {
    return ThemeData(
        brightness: light ? Brightness.light : Brightness.dark,
        primaryColor: const Color.fromRGBO(26, 80, 144, .9),
        accentColor: Colors.blueAccent[700],
        cardColor: light ? null : const Color(0xFF2C2C2C),
        scaffoldBackgroundColor: const Color(0xFF212121),
        splashColor: Colors.blueAccent[400]);
  }

  Future<ThemeData> darkTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final primaryColor = preferences.getInt('primaryColor');
    final accentColor = preferences.getInt('accentColor');

    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor != null
            ? Color(primaryColor)
            : const Color.fromRGBO(26, 80, 144, .9),
        accentColor:
            accentColor != null ? Color(accentColor) : Colors.blueAccent[400],
        cardColor: const Color(0xFF2C2C2C),
        scaffoldBackgroundColor: const Color(0xFF212121),
        splashColor:
            accentColor != null ? Color(accentColor) : Colors.blueAccent[400]);
  }

  Future<ThemeData> lightTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final primaryColor = preferences.getInt('primaryColor');
    final accentColor = preferences.getInt('accentColor');

    return ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor != null
            ? Color(primaryColor)
            : const Color.fromRGBO(26, 80, 144, .9),
        accentColor: accentColor != null
            ? Color(accentColor)
            : const Color.fromRGBO(26, 80, 144, .9),
        splashColor: accentColor != null
            ? Color(accentColor)
            : const Color.fromRGBO(26, 80, 144, .9));
  }
}
