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
      if (saved == 1)
        yield ThemeState(theme: themes.lightTheme());
      else
        yield ThemeState(theme: themes.darkTheme());
    }
    if (event is ThemeDark) {
      themes.save(0);
      yield ThemeState(theme: themes.darkTheme());
    }

    if (event is ThemeLight) {
      themes.save(1);
      yield ThemeState(theme: themes.lightTheme());
    }
  }
}

class ThemeState {
  ThemeState({this.theme});
  final ThemeData theme;
}

abstract class ThemeEvent {}

class ThemeStart extends ThemeEvent {}

class ThemeDark extends ThemeEvent {}

class ThemeLight extends ThemeEvent {}
