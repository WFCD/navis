import 'package:hive/hive.dart';
import 'package:navis/constants/storage_keys.dart';
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

  Formats get dateformat {
    final diskFormat = getFromDisk(SettingsKeys.dateformatKey);

    if (diskFormat != null)
      return Formats.values
          .firstWhere((f) => f.toString() == 'Formats.$diskFormat');

    return Formats.mm_dd_yy;
  }

  set dateformat(Formats value) =>
      saveToDisk(SettingsKeys.dateformatKey, value.toString().split('.').last);

  Map<String, bool> get acolytes => {
        NotificationKeys.angstkey:
            getFromDisk(NotificationKeys.angstkey) ?? false,
        NotificationKeys.maliceKey:
            getFromDisk(NotificationKeys.maliceKey) ?? false,
        NotificationKeys.maniaKey:
            getFromDisk(NotificationKeys.maniaKey) ?? false,
        NotificationKeys.miseryKey:
            getFromDisk(NotificationKeys.miseryKey) ?? false,
        NotificationKeys.tormentKey:
            getFromDisk(NotificationKeys.tormentKey) ?? false,
        NotificationKeys.violenceKey:
            getFromDisk(NotificationKeys.violenceKey) ?? false
      };

  Map<String, bool> get simple => {
        NotificationKeys.alertsKey:
            getFromDisk(NotificationKeys.alertsKey) ?? false,
        NotificationKeys.baroKey:
            getFromDisk(NotificationKeys.baroKey) ?? false,
        NotificationKeys.darvoKey:
            getFromDisk(NotificationKeys.darvoKey) ?? false,
        NotificationKeys.sortiesKey:
            getFromDisk(NotificationKeys.sortiesKey) ?? false
      };

  Map<String, bool> get cycles => {
        NotificationKeys.earthDayKey:
            getFromDisk(NotificationKeys.earthDayKey) ?? false,
        NotificationKeys.earthNightKey:
            getFromDisk(NotificationKeys.earthNightKey) ?? false,
        NotificationKeys.dayKey: getFromDisk(NotificationKeys.dayKey) ?? false,
        NotificationKeys.nightKey:
            getFromDisk(NotificationKeys.nightKey) ?? false,
        NotificationKeys.warmKey:
            getFromDisk(NotificationKeys.warmKey) ?? false,
        NotificationKeys.coldKey: getFromDisk(NotificationKeys.coldKey) ?? false
      };

  Map<String, bool> get news => {
        NotificationKeys.newsPrimeKey:
            getFromDisk(NotificationKeys.newsPrimeKey) ?? false,
        NotificationKeys.newsStreamKey:
            getFromDisk(NotificationKeys.newsStreamKey) ?? false,
        NotificationKeys.newsUpdateKey:
            getFromDisk(NotificationKeys.newsUpdateKey) ?? false
      };

  DateTime get tableTimestamp {
    final timestamp = getFromDisk('tableTimestamp');

    if (timestamp != null)
      return DateTime.fromMillisecondsSinceEpoch(timestamp);

    return timestamp;
  }

  void saveTimestamp(DateTime timestamp) {
    saveToDisk('tableTimestamp', timestamp?.millisecondsSinceEpoch);
  }

  dynamic getFromDisk(String key) => _preferences.get(key);

  void saveToDisk<T>(String key, T value) => _preferences.put(key, value);

  Future<void> dispose() async => await _preferences.close();
}
