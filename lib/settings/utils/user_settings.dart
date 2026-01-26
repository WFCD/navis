import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/settings/settings.dart';

/// {@template user_settings}
/// A Hive box for saving user simple user settings
/// {@endtemplate}
class UserSettings {
  /// {@macro user_settings}
  const UserSettings._(this._userSettingsBox);

  final Box<dynamic> _userSettingsBox;

  static UserSettings? _instance;

  static final _logger = Logger('UserSettings');

  /// Initializes an instance of [UserSettings] within Application Documents Directory.
  static Future<UserSettings> initSettings() async {
    _logger.info('initializing user settings');
    await Hive.initFlutter();
    final box = await Hive.openBox<dynamic>('user_settings');

    return _instance ??= UserSettings._(box);
  }

  String? get accountId => _userSettingsBox.get(SettingsKeys.accountId) as String?;

  set accountId(String id) => _userSettingsBox.put(SettingsKeys.accountId, id);

  /// Returns the stored language as a locale.
  Locale get language {
    final value = _userSettingsBox.get(SettingsKeys.userLanguage) as String?;

    if (value != null) {
      return Locale(value);
    }

    return const Locale('en');
  }

  /// Updates the stored [UserSettings.language].
  set language(Locale? value) {
    if (value != null) {
      _userSettingsBox.put(SettingsKeys.userLanguage, value.languageCode);
    }
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

  /// Returns true if the user has opted to allow anaylics via Matomo.
  bool get isOptOut => MatomoTracker.instance.optOut;

  /// Allows the user to opt in or out of anaylic tracking via Matomo
  set isOptOut(bool value) => MatomoTracker.instance.setOptOut(optOut: value);

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
  Future<void> close() async {
    _logger.warning('closing hive box');
    await _userSettingsBox.close();
  }
}
