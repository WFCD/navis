import 'package:flutter/material.dart';
import 'package:user_settings/src/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';

/// {@template user_settings_notifier}
/// A [ChangeNotifier] for [UserSettings]
/// {@endtemplate}
class UserSettingsNotifier extends ChangeNotifier {
  /// {@macro user_settings_notifier}
  UserSettingsNotifier(UserSettings usersettings)
      : _usersettings = usersettings;

  final UserSettings _usersettings;

  /// Get the user prefered stored language
  Locale? get language => _usersettings.language;

  /// Get the stored [GamePlatforms]
  GamePlatforms get platform => _usersettings.platform;

  /// Get the stored [ThemeMode]
  ThemeMode get theme => _usersettings.theme;

  /// Whether the user has opted out of anaylitcs.
  ///
  /// The default value is true.
  bool get isOptOut => _usersettings.isOptOut;

  /// Whether it's the first time the app has been open or not.
  ///
  /// This function will automaticlly set itself to false on first init, after
  /// which will return false.
  bool get isFirstTime => _usersettings.isFirstTime;

  /// Whether the user has opted into beta features or not.
  bool get enableBeta => _usersettings.enableBeta;

  /// A helper function to get arbitary toggles.
  bool getToggle(String key) => _usersettings.getToggle(key);

  /// {@template stores}
  /// Stores the chosen value in the [UserSettings] hive storage.
  /// {@endtemplate}
  void setLanguage(Locale? locale, {bool notify = true}) {
    _usersettings.setLanguage(locale);
    if (notify) notifyListeners();
  }

  /// {@macro stores}
  void setPlatform(GamePlatforms value) {
    _usersettings.platform = value;
    notifyListeners();
  }

  /// {@macro stores}
  void setTheme(ThemeMode themeMode) {
    _usersettings.theme = themeMode;
    notifyListeners();
  }

  /// {@macro stores}
  void setOptOut({required bool value}) {
    _usersettings.isOptOut = value;
    notifyListeners();
  }

  void setBeta({required bool value}) {
    _usersettings.enableBeta = value;
    notifyListeners();
  }

  /// {@macro stores}
  void setToggle(String key, {required bool value}) {
    _usersettings.setToggle(key, value: value);
    notifyListeners();
  }
}
