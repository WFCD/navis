import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider.dart';

class ThemeBloc implements Base {
  factory ThemeBloc() {
    final selectedTheme = BehaviorSubject<ThemeData>(); // ignore: close_sinks
    final themeDataStream = selectedTheme.distinct();

    _initialTheme(sink: selectedTheme);
    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  ThemeBloc._(this.themeDataStream, this.selectedTheme);

  final Stream<ThemeData> themeDataStream;
  final Sink<ThemeData> selectedTheme;

  ThemeData get current {
    ThemeData currentTheme;

    themeDataStream.last.then((t) => currentTheme = t);

    return currentTheme;
  }

  Future<void> setTheme(Brightness theme) async {
    final prefs = await SharedPreferences.getInstance();

    if (theme == Brightness.dark) {
      selectedTheme.add(_darkTheme());
      await prefs.setInt('Theme', 0);
    } else if (theme == Brightness.light) {
      selectedTheme.add(_lightTheme());
      await prefs.setInt('Theme', 1);
    }
  }

  ThemeData get defaultTheme => _darkTheme();

  static Future<void> _initialTheme({Sink sink}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (prefs.getInt('Theme')) {
      case 1:
        sink.add(_lightTheme());
        return _lightTheme();
        break;
      default:
        sink.add(_darkTheme());
        return _lightTheme();
    }
  }

  @override
  void dispose() => selectedTheme.close();

  static ThemeData _darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromRGBO(26, 80, 144, .9),
        accentColor: const Color.fromRGBO(26, 80, 144, .9),
        cardColor: const Color(0xFF2C2C2C),
        scaffoldBackgroundColor: const Color(0xFF212121),
        splashColor: const Color.fromRGBO(26, 80, 144, .9));
  }

  static ThemeData _lightTheme() {
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
