import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:navis/blocs/search/search_utils.dart';
import 'package:navis/constants/notification_filters.dart' as filters;
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/storage/storage_base.service.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_api_wrapper/wfcd_wrapper.dart';

import 'dateformat_enum.dart';

class PersistentStorageService extends StorageService {
  static const String hive = 'settings';

  static Box _box;
  static PersistentStorageService _instance;

  static PersistentStorageService get instance => _instance;

  @override
  Box get hiveBox => _box;

  @override
  Future<void> startInstance() async {
    super.startInstance();
    final directory = await getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    _box ??= await Hive.openBox(
      hive,
      compactionStrategy: (entries, deleted) {
        return entries > 30 || deleted > 25;
      },
    );
    _instance ??= PersistentStorageService();
  }

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

  ThemeData theme() {
    switch (getFromDisk(SettingsKeys.theme, 0)) {
      case 0:
        return AppTheme.theme.light;
      default:
        return AppTheme.theme.dark;
    }
  }

  Formats get dateformat {
    final diskFormat = getFromDisk(SettingsKeys.dateformatKey, 'mm_dd_yy');

    return Formats.values
        .firstWhere((f) => f.toString() == 'Formats.$diskFormat');
  }

  set dateformat(Formats value) =>
      saveToDisk(SettingsKeys.dateformatKey, value.toString().split('.').last);

  SearchTypes get searchType =>
      stringToSearchType(getFromDisk('searchType', 'drops'));

  set searchType(SearchTypes type) =>
      saveToDisk('searchType', searchTypeToString(type));

  Map<String, bool> get acolytes =>
      {for (String a in filters.acolytes.keys) a: getFromDisk(a, false)};

  Map<String, bool> get simple => {
        for (Map<String, String> s in filters.simple)
          s['key']: getFromDisk(s['key'], false)
      };

  Map<String, bool> get cycles =>
      {for (String c in filters.cycles.keys) c: getFromDisk(c, false)};

  Map<String, bool> get news =>
      {for (String n in filters.newsType.keys) n: getFromDisk(n, false)};

  Map<String, bool> get resources =>
      {for (String r in filters.resources.keys) r: getFromDisk(r, false)};

  dynamic getFromDisk(String key, [dynamic defaultValue]) =>
      _box.get(key, defaultValue: defaultValue);

  void saveToDisk<T>(String key, T value) => _box.put(key, value);
}
