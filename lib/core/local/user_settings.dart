import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:matomo/matomo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../constants/storage_keys.dart';

class Usersettings with ChangeNotifier {
  Usersettings(this._box);

  final Box<dynamic> _box;

  static Usersettings? _instance;

  static Future<Usersettings> initUsersettings() async {
    log('Initializing Usersettings Hive', level: Level.INFO.value);
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    final box = await Hive.openBox<dynamic>('user_settings')
        .catchError((Object error, StackTrace stack) {
      log('Unable to open Usersettings Hive box',
          error: error, stackTrace: stack, level: Level.SEVERE.value);
    });

    return _instance ??= Usersettings(box);
  }

  Locale? get language {
    final value = _box.get(SettingsKeys.userLanguage) as String?;

    if (value != null) {
      return Locale(value);
    }

    return null;
  }

  void setLanguage(Locale? value, {bool rebuild = true}) {
    if (value != null) {
      log('setting new lang ${value.languageCode}', level: Level.INFO.value);
      _box.put(SettingsKeys.userLanguage, value.languageCode);
      if (rebuild) notifyListeners();
    }
  }

  GamePlatforms get platform {
    final value = _box.get(SettingsKeys.platformKey) as String?;

    if (value != null) {
      return GamePlatformsX.fromString(value);
    }

    return GamePlatforms.pc;
  }

  set platform(GamePlatforms value) {
    log('setting new platform ${value.asString}', level: Level.INFO.value);
    _box.put(SettingsKeys.platformKey, value.asString);
    notifyListeners();
  }

  ThemeMode get theme {
    final value = _box.get(SettingsKeys.theme) as String?;

    return ThemeMode.values.firstWhere(
      (e) => e.toString().contains(value ?? ''),
      orElse: () => ThemeMode.system,
    );
  }

  set theme(ThemeMode mode) {
    _box.put(SettingsKeys.theme, mode.toString().split('.').last);
    notifyListeners();
  }

  bool get backkey => getToggle(SettingsKeys.backKey);

  set backkey(bool value) => setToggle(SettingsKeys.backKey, value);

  bool get isOptOut => getToggle(MatomoTracker.kOptOut);

  set isOptOut(bool value) => setToggle(MatomoTracker.kOptOut, value);

  bool get isFirstTime => getToggle(SettingsKeys.isFirstTime);

  set isFirstTime(bool value) => setToggle(SettingsKeys.isFirstTime, value);

  bool getToggle(String key) {
    return _box.get(key, defaultValue: false) as bool;
  }

  void setToggle(String key, bool value) {
    _box.put(key, value);
    notifyListeners();
  }
}
