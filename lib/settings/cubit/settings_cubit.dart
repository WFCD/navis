import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:settings_repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settings)
    : super(
        SettingsSuccess(
          language: Locale(_settings.locale),
          themeMode: ThemeMode.values[_settings.theme],
          isFirstTime: _settings.firstRun,
        ),
      );

  final SettingsRepository _settings;

  void updateLocale(Locale locale) {
    if (_settings.locale == locale.languageCode) return;

    _settings.locale = locale.languageCode;
    emit((state as SettingsSuccess).copyWith(language: Locale(_settings.locale)));
  }

  void updateThemeMode(ThemeMode themeMode) {
    _settings.theme = themeMode.index;
    emit((state as SettingsSuccess).copyWith(themeMode: ThemeMode.values[_settings.theme]));
  }

  // ignore: avoid_positional_boolean_parameters Not needed
  void updateRunStatus(bool value) {
    _settings.firstRun = value;
    emit((state as SettingsSuccess).copyWith(isFirstTime: _settings.firstRun));
  }

  // ignore: avoid_positional_boolean_parameters Not needed
  void updateAnalyticsOpt(bool value) {
    MatomoTracker.instance.setOptOut(optOut: value);
    emit((state as SettingsSuccess).copyWith(isFirstTime: MatomoTracker.instance.optOut));
  }

  @override
  String toString() => 'UserSettingsCubit()';
}
