import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base.dart';

class ThemeBloc implements Base {
  final Stream<ThemeType> themeDataStream;
  final Sink<ThemeType> selectedTheme;

  factory ThemeBloc() {
    final selectedTheme = BehaviorSubject<ThemeType>(); // ignore: close_sinks
    final themeDataStream = selectedTheme.distinct();

    _initialTheme(sink: selectedTheme);
    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  ThemeBloc._(this.themeDataStream, this.selectedTheme);

  setTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();

    if (theme == 'Dark') {
      selectedTheme.add(_darkTheme());
      await prefs.setInt('Theme', 0);
    } else if (theme == 'Light') {
      selectedTheme.add(_lightTheme());
      await prefs.setInt('Theme', 1);
    }
  }

  ThemeType get defaultTheme => _darkTheme();

  static _initialTheme({Sink sink}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

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

  static ThemeType _darkTheme() {
    return ThemeType(
        'Dark',
        ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color.fromRGBO(26, 80, 144, .9),
            accentColor: Color.fromRGBO(26, 80, 144, .9),
            cardColor: Color.fromRGBO(187, 187, 197, 0.2),
            scaffoldBackgroundColor: Color.fromRGBO(34, 34, 34, .9),
            splashColor: Color.fromRGBO(26, 80, 144, .9)));
  }

  static ThemeType _lightTheme() {
    return ThemeType(
        'Light',
        ThemeData(
            brightness: Brightness.light,
            primaryColor: Color.fromRGBO(26, 80, 144, .9),
            accentColor: Color.fromRGBO(26, 80, 144, .9),
            textTheme: TextTheme(
                body1: TextStyle(color: Colors.black),
                body2: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal)),
            splashColor: Color.fromRGBO(26, 80, 144, .9)));
  }
}

class ThemeType {
  final String name;
  final ThemeData theme;

  ThemeType(this.name, this.theme);
}
