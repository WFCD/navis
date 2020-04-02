import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:navis/constants/notification_filters.dart' as filters;
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/storage/storage_base.service.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/search_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_client/enums.dart';

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

    _box ??= await Hive.openBox(hive);
    _instance ??= PersistentStorageService();
  }

  Platforms get platform {
    final diskPlatform = _box.get(SettingsKeys.platformKey);

    if (diskPlatform != null)
      return Platforms.values.firstWhere(
        (p) => p.toString() == 'Platforms.$diskPlatform',
      );

    return null;
  }

  set platform(Platforms value) {
    _box.put(SettingsKeys.platformKey, value.toString().split('.').last);
  }

  ThemeData get theme {
    final int flip = _box.get(SettingsKeys.theme);

    switch (flip) {
      case 0:
        return NavisThemes.light;
      case 1:
        return NavisThemes.dark;
      default:
        return null;
    }
  }

  CodexDatabase get searchType {
    final saved = _box.get(SettingsKeys.codexDatabase, defaultValue: 'drops');

    return CodexDatabaseX.parseString(saved);
  }

  set searchType(CodexDatabase type) {
    _box.put(SettingsKeys.codexDatabase, type.toProperString());
  }

  Map<String, bool> get acolytes {
    return {
      for (String a in filters.acolytes.keys)
        a: _box.get(a, defaultValue: false)
    };
  }

  Map<String, bool> get simple {
    return {
      for (Map<String, String> s in filters.simple)
        s['key']: _box.get(s['key'], defaultValue: false)
    };
  }

  Map<String, bool> get cycles {
    return {
      for (String c in filters.cycles.keys) c: _box.get(c, defaultValue: false)
    };
  }

  Map<String, bool> get news {
    return {
      for (String n in filters.newsType.keys)
        n: _box.get(n, defaultValue: false)
    };
  }

  Map<String, bool> get resources {
    final resources = SplayTreeMap<String, String>.from(
        filters.resources, (a, b) => a.compareTo(b));

    return {
      for (String r in resources.keys) r: _box.get(r, defaultValue: false)
    };
  }
}
