import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../local/user_settings.dart';

class UserSettingsNotifier extends ChangeNotifier {
  UserSettingsNotifier(Usersettings usersettings)
      : _usersettings = usersettings;

  final Usersettings _usersettings;

  Locale? get language => _usersettings.language;

  GamePlatforms get platform => _usersettings.platform;

  ThemeMode get theme => _usersettings.theme;

  bool get backKey => _usersettings.backkey;

  bool get isOptOut => _usersettings.isOptOut;

  bool get isFirstTime => _usersettings.isFirstTime;

  bool getToggle(String key) => _usersettings.getToggle(key);

  void setLanguage(Locale? locale, {bool rebuild = false}) {
    _usersettings.setLanguage(locale);
    if (rebuild) notifyListeners();
  }

  void setPlatform(GamePlatforms value) {
    _usersettings.platform = value;
    notifyListeners();
  }

  void setTheme(ThemeMode themeMode) {
    _usersettings.theme = themeMode;
    notifyListeners();
  }

  void toggleBackKey(bool value) {
    _usersettings.backkey = value;
    notifyListeners();
  }

  void setOptOut(bool value) {
    _usersettings.isOptOut = value;
    notifyListeners();
  }

  void setFirstTime(bool value) {
    _usersettings.isFirstTime = value;
    notifyListeners();
  }

  void setToggle(String key, bool value) {
    _usersettings.setToggle(key, value);
    notifyListeners();
  }
}
