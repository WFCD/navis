import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemes {
  Future<ThemeData> savedTheme() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt('Theme') != 1 ? darkTheme() : lightTheme();
  }

  Future<bool> save(int brightness) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.setInt('Theme', brightness);
  }

  ThemeData darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(26, 80, 144, .9),
        accentColor: const Color.fromRGBO(26, 80, 144, .9),
        cardColor: const Color(0xFF2C2C2C),
        scaffoldBackgroundColor: const Color(0xFF212121),
        splashColor: const Color.fromRGBO(26, 80, 144, .9));
  }

  ThemeData lightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromRGBO(26, 80, 144, .9),
        accentColor: const Color.fromRGBO(26, 80, 144, .9),
        textTheme: const TextTheme(
            body1: TextStyle(color: Colors.black),
            body2:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
        splashColor: const Color.fromRGBO(26, 80, 144, .9));
  }
}
