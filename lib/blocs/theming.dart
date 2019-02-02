import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:navis/utils/themes.dart';

import 'provider.dart';

class ThemeBloc implements Base {
  factory ThemeBloc() {
    final selectedTheme = BehaviorSubject<ThemeData>(); // ignore: close_sinks
    final themeDataStream = selectedTheme.distinct();

    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  ThemeBloc._(this.themeDataStream, this.selectedTheme);

  final Stream<ThemeData> themeDataStream;
  final Sink<ThemeData> selectedTheme;

  static final theme = AppThemes();
  static ThemeData initialTheme;

  Future<void> setTheme(Brightness save) async {
    if (save == Brightness.dark) {
      selectedTheme.add(theme.darkTheme());
      theme.save(0);
    } else if (save == Brightness.light) {
      selectedTheme.add(theme.lightTheme());
      theme.save(1);
    }
  }

  @override
  void dispose() => selectedTheme.close();

  @override
  void initState() {
    // TODO: implement initState
  }
}
