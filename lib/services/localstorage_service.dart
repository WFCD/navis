import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static Box _preferences;

  static Future<LocalStorageService> getInstance() async {
    final directory = await getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    _instance ??= LocalStorageService();
    _preferences ??= await Hive.openBox(
      'settings',
      compactionStrategy: (entries, deleted) {
        return entries > 30 || deleted > 25;
      },
    );

    return _instance;
  }

  Box get instance => Hive.box('settings');

  Platforms get platform {
    final diskPlatform = getFromDisk(SettingsKeys.platformKey);

    if (diskPlatform != null)
      return Platforms.values.firstWhere(
        (p) => p.toString() == 'Platforms.$diskPlatform',
      );

    return null;
  }

  set platform(Platforms value) =>
      saveToDisk(SettingsKeys.platformKey, value.toString().split('.').last);

  ThemeData get theme {
    switch (getFromDisk(SettingsKeys.theme, 1)) {
      case 0:
        return AppTheme.theme.light;
      case 1:
        return AppTheme.theme.dark;
      default:
        return AppTheme.theme.amoled;
    }
  }

  Formats get dateformat {
    final diskFormat = getFromDisk(SettingsKeys.dateformatKey, 'mm_dd_yy');

    return Formats.values
        .firstWhere((f) => f.toString() == 'Formats.$diskFormat');
  }

  set dateformat(Formats value) =>
      saveToDisk(SettingsKeys.dateformatKey, value.toString().split('.').last);

  Map<String, bool> get acolytes => {
        NotificationKeys.angstkey:
            getFromDisk(NotificationKeys.angstkey, false),
        NotificationKeys.maliceKey:
            getFromDisk(NotificationKeys.maliceKey, false),
        NotificationKeys.maniaKey:
            getFromDisk(NotificationKeys.maniaKey, false),
        NotificationKeys.miseryKey:
            getFromDisk(NotificationKeys.miseryKey, false),
        NotificationKeys.tormentKey:
            getFromDisk(NotificationKeys.tormentKey, false),
        NotificationKeys.violenceKey:
            getFromDisk(NotificationKeys.violenceKey, false)
      };

  Map<String, bool> get simple => {
        NotificationKeys.alertsKey:
            getFromDisk(NotificationKeys.alertsKey, false),
        NotificationKeys.baroKey: getFromDisk(NotificationKeys.baroKey, false),
        NotificationKeys.darvoKey:
            getFromDisk(NotificationKeys.darvoKey, false),
        NotificationKeys.sortiesKey:
            getFromDisk(NotificationKeys.sortiesKey, false)
      };

  Map<String, bool> get cycles => {
        NotificationKeys.earthDayKey:
            getFromDisk(NotificationKeys.earthDayKey, false),
        NotificationKeys.earthNightKey:
            getFromDisk(NotificationKeys.earthNightKey, false),
        NotificationKeys.dayKey: getFromDisk(NotificationKeys.dayKey, false),
        NotificationKeys.nightKey:
            getFromDisk(NotificationKeys.nightKey, false),
        NotificationKeys.warmKey: getFromDisk(NotificationKeys.warmKey, false),
        NotificationKeys.coldKey: getFromDisk(NotificationKeys.coldKey, false)
      };

  Map<String, bool> get news => {
        NotificationKeys.newsPrimeKey:
            getFromDisk(NotificationKeys.newsPrimeKey, false),
        NotificationKeys.newsStreamKey:
            getFromDisk(NotificationKeys.newsStreamKey, false),
        NotificationKeys.newsUpdateKey:
            getFromDisk(NotificationKeys.newsUpdateKey, false)
      };

  Map<String, bool> get resources => {
        NotificationKeys.sniptronVandalBP:
            getFromDisk(NotificationKeys.sniptronVandalBP, false),
        NotificationKeys.sheeveHeatsink:
            getFromDisk(NotificationKeys.sheeveHeatsink, false),
        NotificationKeys.deraVandalBarrel:
            getFromDisk(NotificationKeys.deraVandalBarrel, false),
        NotificationKeys.deraVandalBP:
            getFromDisk(NotificationKeys.deraVandalBP, false),
        NotificationKeys.wraithTwinVIpersBarrel:
            getFromDisk(NotificationKeys.wraithTwinVIpersBarrel, false),
        NotificationKeys.latronWraithReceiver:
            getFromDisk(NotificationKeys.latronWraithReceiver, false),
        NotificationKeys.fieldron:
            getFromDisk(NotificationKeys.fieldron, false),
        NotificationKeys.detoniteInjector:
            getFromDisk(NotificationKeys.detoniteInjector, false),
        NotificationKeys.aladNavCoordinate:
            getFromDisk(NotificationKeys.aladNavCoordinate, false),
        NotificationKeys.mutagenMass:
            getFromDisk(NotificationKeys.mutagenMass, false),
        NotificationKeys.orokinCatalyst:
            getFromDisk(NotificationKeys.orokinCatalyst, false),
        NotificationKeys.orokinReactor:
            getFromDisk(NotificationKeys.orokinReactor, false),
        NotificationKeys.forma: getFromDisk(NotificationKeys.forma, false),
        NotificationKeys.exilusAdapter:
            getFromDisk(NotificationKeys.exilusAdapter, false)
      };

  DateTime get tableTimestamp {
    final timestamp =
        getFromDisk('tableTimestamp', DateTime.now().millisecondsSinceEpoch);

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  void saveTimestamp(DateTime timestamp) {
    saveToDisk('tableTimestamp', timestamp?.millisecondsSinceEpoch);
  }

  dynamic getFromDisk(String key, [dynamic defaultValue]) =>
      _preferences.get(key, defaultValue: defaultValue);

  void saveToDisk<T>(String key, T value) => _preferences.put(key, value);

  Future<void> dispose() async => await _preferences.close();
}
