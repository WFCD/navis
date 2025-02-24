import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';

part 'user_settings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit(UserSettings settings) : _settings = settings, super(UserSettingsInitial()) {
    _initSettings();
  }

  final UserSettings _settings;

  void updateLanguage(Locale language) {
    _settings.language = language;
    emit((state as UserSettingsSuccess).copyWith(language: _settings.language));
  }

  void updateThemeMode(ThemeMode themeMode) {
    _settings.theme = themeMode;
    emit((state as UserSettingsSuccess).copyWith(themeMode: _settings.theme));
  }

  void updateAnalyticsOpt({required bool isOptOut}) {
    _settings.isOptOut = isOptOut;
    emit((state as UserSettingsSuccess).copyWith(isOptOut: _settings.isOptOut));
  }

  void updateToggle(String key, {required bool value}) {
    final settings = state as UserSettingsSuccess;
    final toggles = Map<String, bool>.from(settings.toggles);

    _settings.setToggle(key, value: value);
    toggles[key] = _settings.getToggle(key);

    emit(settings.copyWith(toggles: toggles));
  }

  void _initSettings() {
    final settings = UserSettingsSuccess(
      language: _settings.language,
      themeMode: _settings.theme,
      isOptOut: _settings.isOptOut,
      isFirstTime: _settings.isFirstTime,
      toggles: <String, bool>{
        for (final topic in Topics.topics) ...{topic.name: _settings.getToggle(topic.name)},
      },
    );

    emit(settings);
  }
}
