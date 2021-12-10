import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:matomo/matomo.dart';
import 'package:user_settings/src/settings_keys.dart';
import 'package:wfcd_client/wfcd_client.dart';

/// {@template user_settings}
/// A Hive box for saving user simple user settings
/// {@endtemplate}
class UserSettings {
  /// {@macro user_settings}
  const UserSettings._(this._userSettingsBox);

  final Box<dynamic> _userSettingsBox;

  static UserSettings? _instance;

  /// Initializes an instance of [UserSettings] within [path].
  ///
  /// You must call [Hive.init(path)] before calling this function
  static Future<UserSettings> initSettings(String path) async {
    log('Initializing Usersettings Hive');
    final box = await Hive.openBox<dynamic>('user_settings', path: path);

    return _instance ??= UserSettings._(box);
  }

  /// Returns the stored language as a locale.
  Locale? get language {
    final value = _userSettingsBox.get(SettingsKeys.userLanguage) as String?;

    if (value != null) {
      return Locale(value);
    }

    return null;
  }

  /// Updates the stored [UserSettings.language].
  void setLanguage(Locale? value) {
    if (value != null) {
      log('setting new lang ${value.languageCode}');
      _userSettingsBox.put(SettingsKeys.userLanguage, value.languageCode);
    }
  }

  /// Returns the stored [GamePlatforms].
  GamePlatforms get platform {
    final value = _userSettingsBox.get(SettingsKeys.platformKey) as String?;

    if (value != null) {
      return GamePlatformsX.fromString(value);
    }

    return GamePlatforms.pc;
  }

  /// Updates the stored [UserSettings.platform].
  set platform(GamePlatforms value) {
    log('setting new platform ${value.asString}');
    _userSettingsBox.put(SettingsKeys.platformKey, value.asString);
  }

  /// Returns [ThemeMode] value from the stored string value.
  ThemeMode get theme {
    final value = _userSettingsBox.get(SettingsKeys.theme) as String?;

    if (value != null) {
      return ThemeMode.values.firstWhere((e) => e.toString().contains(value));
    }

    return ThemeMode.system;
  }

  /// Updates the stored [UserSettings.theme].
  set theme(ThemeMode mode) {
    _userSettingsBox.put(SettingsKeys.theme, mode.toString().split('.').last);
  }

  /// Whether the user has selected to use the back button.
  ///
  /// Typically you'll want to get this to open the drawer in app when the user
  /// presses the back butten.
  bool get backkey => getToggle(SettingsKeys.backKey);

  /// Updates the stored toggle for [UserSettings.backkey].
  set backkey(bool value) => setToggle(SettingsKeys.backKey, value: value);

  /// Returns true if the user has opted to allow anaylics via Matomo.
  bool get isOptOut => getToggle(MatomoTracker.kOptOut);

  /// Allows the user to opt in or out of anaylic tracking via Matomo
  set isOptOut(bool value) => setToggle(MatomoTracker.kOptOut, value: value);

  /// Whether it's the first time the user has opened the app.
  bool get isFirstTime {
    if (_userSettingsBox.containsKey(SettingsKeys.isFirstTime)) {
      return getToggle(SettingsKeys.isFirstTime);
    }

    setToggle(SettingsKeys.isFirstTime, value: false);
    return true;
  }

  /// Get a custom key value in [UserSettings].
  ///
  /// User [UserSettings.setToggle] to set your key-value before getting it's
  /// value, otherwise the default will always be false.
  bool getToggle(String key, {bool defaultValue = false}) {
    return _userSettingsBox.get(key, defaultValue: defaultValue) as bool;
  }

  /// Save a custom key-value in [UserSettings]
  ///
  /// Use [UserSettings.getToggle] to get your value later
  void setToggle(String key, {required bool value}) {
    _userSettingsBox.put(key, value);
  }

  /// Closes the Hive box used for settings.
  ///
  /// Use only for test and must not be accessed anywhere in Navis as we want to
  /// always keep the box open.
  @visibleForTesting
  Future<void> close() => _userSettingsBox.close();
}
