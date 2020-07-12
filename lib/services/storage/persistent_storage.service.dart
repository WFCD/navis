import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/storage/storage_base.service.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/search_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_client/wfcd_client.dart';

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

  GamePlatforms get platform {
    final diskPlatform = _box.get(SettingsKeys.platformKey);

    if (diskPlatform != null) return GamePlatformsX.fromString(diskPlatform);

    return null;
  }

  set platform(GamePlatforms value) {
    _box.put(SettingsKeys.platformKey, value.asString);
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

  bool getToggle(String key) {
    return _box.get(key, defaultValue: false);
  }

  void setToggle(String key, bool value) {
    _box.put(key, value);
  }
}
