import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:settings_repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settings, this._notifications)
    : super(
        SettingsState(
          language: Locale(_settings.locale),
          themeMode: ThemeMode.values[_settings.theme],
          isFirstTime: _settings.firstRun,
          isOptOut: MatomoTracker.instance.optOut,
          notifications: _notifications.storage.fetchAllNotifications(),
        ),
      );

  final SettingsRepository _settings;
  final NotificationRepository _notifications;

  void updateLocale(Locale locale) {
    if (_settings.locale == locale.languageCode) return;

    _settings.locale = locale.languageCode;
    emit(state.copyWith(language: Locale(_settings.locale)));
  }

  void updateThemeMode(ThemeMode themeMode) {
    _settings.theme = themeMode.index;
    emit(state.copyWith(themeMode: ThemeMode.values[_settings.theme]));
  }

  // ignore: avoid_positional_boolean_parameters Not needed
  void updateRunStatus(bool value) {
    _settings.firstRun = value;
    emit(state.copyWith(isFirstTime: _settings.firstRun));
  }

  // ignore: avoid_positional_boolean_parameters Not needed
  void updateAnalyticsOpt(bool value) {
    MatomoTracker.instance.setOptOut(optOut: value);
    emit(state.copyWith(isOptOut: MatomoTracker.instance.optOut));
  }

  Future<void> toggleFilter(String key, {required bool enable}) async {
    final newValue = await _notifications.toggleFilter(key, enable: enable);
    emit(state.copyWith(notifications: {key: newValue}));
  }

  @override
  String toString() => 'UserSettingsCubit()';
}
