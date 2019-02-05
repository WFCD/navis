import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:navis/utils/themes.dart';

final themes = AppThemes();

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeState persistentTheme;

  @override
  ThemeState get initialState => ThemeState(theme: themes.darkTheme());

  @override
  Stream<ThemeEvent> transform(Stream<ThemeEvent> events) {
    // ignore: avoid_as
    return (events as Observable<ThemeEvent>).distinct();
  }

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
          yield ThemeState(theme: themes.darkTheme());
          break;
        case Brightness.light:
          themes.save(1);
          yield ThemeState(theme: themes.lightTheme());
      }
    }

    if (event is ThemeCustom) {
      final base = await themes.savedTheme();
      if (base.brightness == Brightness.light) {
        themes.save(1, accentColor: event.accentColor);
        yield ThemeState(
            theme: themes.lightTheme(accentColor: event.accentColor));
      } else {
        themes.save(0, accentColor: event.accentColor);
        yield ThemeState(
            theme: themes.darkTheme(accentColor: event.accentColor));
      }
    }
  }
}

// Theme States
class ThemeState {
  ThemeState({this.theme});
  final ThemeData theme;
}

// Theme events
abstract class ThemeEvent {}

class ThemeStart extends ThemeEvent {}

class ThemeChange extends ThemeEvent {
  ThemeChange({@required this.brightness});

  final Brightness brightness;
}

class ThemeCustom extends ThemeEvent {
  ThemeCustom({@required this.accentColor});

  final Color accentColor;
}
