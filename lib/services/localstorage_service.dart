import 'package:flutter/material.dart';
import 'package:navis/utils/enums.dart';
import 'package:navis/utils/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _prefrence;

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();
    _prefrence ??= await SharedPreferences.getInstance();

    return _instance;
  }

  Platforms get platform {
    final diskPlatform = getFromDisk(platformKey);

    if (diskPlatform != null)
      return Platforms.values
          .firstWhere((p) => p.toString() == 'Platforms.$diskPlatform');

    return Platforms.pc;
  }

  set platform(Platforms value) =>
      saveToDisk(platformKey, value.toString().split('.').last);

  Formats get dateformat {
    final diskFormat = getFromDisk(dateformatKey);

    if (diskFormat != null)
      return Formats.values
          .firstWhere((f) => f.toString() == 'Formats.$diskFormat');

    return Formats.mm_dd_yy;
  }

  set dateformat(Formats value) =>
      saveToDisk(dateformatKey, value.toString().split('.').last);

  bool get darkMode => getFromDisk(darkModeKey) ?? true;
  set darkMode(bool value) => saveToDisk(darkModeKey, value);

  Color get primaryColor {
    return Color(getFromDisk(primaryColorKey) ??
        const Color.fromRGBO(26, 80, 144, .9).value);
  }

  set primaryColor(Color primary) => saveToDisk(primaryColorKey, primary.value);

  Color get accentColor {
    return Color(getFromDisk(accentColorKey) ?? Colors.blueAccent[400].value);
  }

  set accentColor(Color accent) => saveToDisk(accentColorKey, accent.value);

  Map<String, bool> get acolytes => {
        angstkey: getFromDisk(angstkey) ?? false,
        maliceKey: getFromDisk(maliceKey) ?? false,
        maniaKey: getFromDisk(maniaKey) ?? false,
        miseryKey: getFromDisk(miseryKey) ?? false,
        tormentKey: getFromDisk(tormentKey) ?? false,
        violenceKey: getFromDisk(violenceKey) ?? false
      };

  Map<String, bool> get simple => {
        alertsKey: getFromDisk(alertsKey) ?? false,
        baroKey: getFromDisk(baroKey) ?? false,
        darvoKey: getFromDisk(darvoKey) ?? false,
        sortiesKey: getFromDisk(sortiesKey) ?? false
      };

  Map<String, bool> get cycles => {
        earthDayKey: getFromDisk(earthDayKey) ?? false,
        earthNightKey: getFromDisk(earthNightKey) ?? false,
        dayKey: getFromDisk(dayKey) ?? false,
        nightKey: getFromDisk(nightKey) ?? false,
        warmKey: getFromDisk(warmKey) ?? false,
        coldKey: getFromDisk(coldKey) ?? false
      };

  Map<String, bool> get news => {
        newsPrimeKey: getFromDisk(newsPrimeKey) ?? false,
        newsStreamKey: getFromDisk(newsStreamKey) ?? false,
        newsUpdateKey: getFromDisk(newsUpdateKey) ?? false
      };

  dynamic getFromDisk(String key) => _prefrence.get(key);

  void saveToDisk<T>(String key, T value) {
    if (value is String) _prefrence.setString(key, value);
    if (value is bool) _prefrence.setBool(key, value);
    if (value is int) _prefrence.setInt(key, value);
    if (value is List<String>) _prefrence.setStringList(key, value);
  }
}
