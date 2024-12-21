import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';

part 'user_settings_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit(UserSettings settings)
      : _settings = settings,
        super(
          UserSettingsSuccess(
            username: settings.username,
            language: settings.language,
            themeMode: settings.theme,
            isOptOut: settings.isOptOut,
            isFirstTime: settings.isFirstTime,
            toggles: <String, bool>{
              for (final topic in Topics.topics) ...{
                topic.name: settings.getToggle(topic.name),
              },
            },
          ),
        );

  final UserSettings _settings;

  void updateUsername(String? username) {
    _settings.username = username;
    emit((state as UserSettingsSuccess).copyWith(username: _settings.username));
  }

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
}
