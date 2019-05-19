import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:navis/themes/themes.dart';

import 'theme_events.dart';
import 'theme_states.dart';

final themes = AppTheme();

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>
    with EquatableMixinBase, EquatableMixin {
  ThemeState persistentTheme;

  @override
  ThemeState get initialState => ThemeState(theme: themes.defaultTheme());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeStart) {
      final saved = themes.savedTheme();

      yield ThemeState(theme: saved);
    }

    if (event is ThemeChange) {
      switch (event.brightness) {
        case Brightness.dark:
          themes.save(true);
          yield ThemeState(theme: themes.dark());
          break;
        case Brightness.light:
          themes.save(false);
          yield ThemeState(theme: themes.light());
      }
    }

    if (event is ThemeCustom) {
      final base = themes.savedTheme();

      if (base.brightness != Brightness.light) {
        themes.save(true,
            primaryColor: event.primaryColor, accentColor: event.accentColor);
        yield ThemeState(theme: themes.dark());
      } else {
        themes.save(false,
            primaryColor: event.primaryColor, accentColor: event.accentColor);
        yield ThemeState(theme: themes.light());
      }
    }
  }
}
