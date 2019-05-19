import 'package:flutter/material.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/service_locator.dart';

class AppTheme {
  final _preference = locator<LocalStorageService>();

  ThemeData savedTheme() {
    if (_preference.darkMode) {
      return dark();
    } else {
      return light();
    }
  }

  void save(bool brightness, {Color primaryColor, Color accentColor}) {
    _preference.darkMode = brightness;

    if (primaryColor != null) _preference.primaryColor = primaryColor;
    if (accentColor != null) _preference.accentColor = accentColor;
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

  ThemeData dark() {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: _preference.primaryColor,
        accentColor: _preference.accentColor,
        cardColor: const Color(0xFF2C2C2C),
        scaffoldBackgroundColor: const Color(0xFF212121),
        canvasColor: const Color(0xFF212121),
        splashColor: _preference.accentColor);
  }

  ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: _preference.primaryColor,
        accentColor: _preference.accentColor,
        splashColor: _preference.accentColor);
  }
}
