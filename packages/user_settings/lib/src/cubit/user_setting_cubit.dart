import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';

part 'user_setting_state.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  UserSettingsCubit(UserSettings settings)
      : _userSettings = settings,
        super(
          UserSettingsState(
            getToggle: (key, {defaultValue = false}) => defaultValue,
            setToggle: (key, value) {},
          ),
        ) {
    emit(
      state.copyWith(
        isFirstTime: _userSettings.isFirstTime,
        getToggle: _userSettings.getToggle,
        setToggle: _userSettings.setToggle,
      ),
    );
  }

  final UserSettings _userSettings;

  void setLanguage(Locale locale) {
    _userSettings.setLanguage(locale);
    emit(state.copyWith(language: _userSettings.language));
  }

  void setPlatform(GamePlatforms platform) {
    _userSettings.platform = platform;
    emit(state.copyWith(platform: _userSettings.platform));
  }

  void setTheme(ThemeMode themeMode) {
    _userSettings.theme = themeMode;
    emit(state.copyWith(theme: _userSettings.theme));
  }

  void setOptOut(bool value) {
    _userSettings.isOptOut = value;
    emit(state.copyWith(isOptOut: _userSettings.isOptOut));
  }
}
