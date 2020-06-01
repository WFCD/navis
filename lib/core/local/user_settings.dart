import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/core/network/warframestat_remote.dart';
import 'package:path_provider/path_provider.dart';

class Usersettings {
  Usersettings(this._box);

  final Box<dynamic> _box;

  static Usersettings _instance;

  static final _logger = Logger('Usersettings');

  static Future<Usersettings> initUsersettings() async {
    _logger.info('Initializing Usersettings Hive');
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    final box = await Hive.openBox<dynamic>('user_settings').catchError(
      (Object error, StackTrace stack) =>
          _logger.severe('Unable to open Usersettings Hive box', error, stack),
    );

    return _instance ??= Usersettings(box);
  }

  GamePlatforms get platform {
    final value = _box.get(SettingsKeys.platformKey) as String;

    if (value != null) {
      return GamePlatformsX.fromString(value);
    }

    return GamePlatforms.pc;
  }

  set platform(GamePlatforms value) {
    _box.put(SettingsKeys.platformKey, value.asString);
  }

  ThemeMode get theme {
    final value = _box.get(SettingsKeys.theme) as String;

    return ThemeMode.values.firstWhere(
      (element) => element.toString().contains(value),
      orElse: () => null,
    );
  }

  set theme(ThemeMode mode) {
    _box.put(SettingsKeys.theme, mode.toString().split('.').last);
  }

  bool getToggle(String key) {
    return _box.get(key, defaultValue: false) as bool;
  }

  void setToggle(String key, bool value) {
    _box.put(key, value);
  }
}
