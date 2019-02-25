import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/themes.dart';

import 'theme_events.dart';
import 'theme_states.dart';

final themes = AppTheme();

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>
    with EquatableMixinBase, EquatableMixin {
  ThemeState persistentTheme;

  @override
  ThemeState get initialState => ThemeState(theme: themes.defaultTheme());

  @override
  Stream<ThemeState> mapEventToState(
      ThemeState currentState, ThemeEvent event) async* {
    if (event is ThemeStart) {
      final saved = await themes.savedTheme();

      yield ThemeState(theme: saved);
    }

    if (event is ThemeChange) {
      switch (event.brightness) {
        case Brightness.dark:
          themes.save(0);
          yield ThemeState(theme: await themes.darkTheme());
          break;
        case Brightness.light:
          themes.save(1);
          yield ThemeState(theme: await themes.lightTheme());
      }
    }

    if (event is ThemeCustom) {
      final base = await themes.savedTheme();

      if (base.brightness == Brightness.light) {
        themes.save(1,
            primaryColor: event.primaryColor, accentColor: event.accentColor);
        yield ThemeState(theme: await themes.lightTheme());
      } else {
        themes.save(0,
            primaryColor: event.primaryColor, accentColor: event.accentColor);
        yield ThemeState(theme: await themes.darkTheme());
      }
    }
  }
}
