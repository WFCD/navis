import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:navis/constants/notification_filters.dart' as filters;
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/resources/storage/storage_base.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/enums.dart';
// import 'package:navis/utils/extensions.dart';

class PersistentResource extends StorageResource {
  const PersistentResource(Box box) : super(box);

  static const String hive = 'settings';

  Platforms get platform {
    final diskPlatform = box.get(SettingsKeys.platformKey) as String;

    if (diskPlatform != null) {
      return Platforms.values.firstWhere(
        (p) => p.toString() == 'Platforms.$diskPlatform',
      );
    }
    return null;
  }

  set platform(Platforms value) {
    box.put(SettingsKeys.platformKey, value.toString().split('.').last);
  }

  ThemeData get theme {
    final int flip = box.get(SettingsKeys.theme, defaultValue: 0) as int;

    switch (flip) {
      case 0:
        return AppTheme.theme.light;
      default:
        return AppTheme.theme.dark;
    }
  }

  Formats get dateformat {
    final diskFormat =
        box.get(SettingsKeys.dateformatKey, defaultValue: 'mm_dd_yy') as String;

    return Formats.values
        .firstWhere((f) => f.toString() == 'Formats.$diskFormat');
  }

  set dateformat(Formats value) {
    box.put(SettingsKeys.dateformatKey, value.toString().split('.').last);
  }

  Map<String, bool> get acolytes => _toMap(filters.acolytes.keys.toList());

  Map<String, bool> get cycles => _toMap(filters.cycles.keys.toList());

  Map<String, bool> get news => _toMap(filters.newsType.keys.toList());

  Map<String, bool> get resources => _toMap(filters.resources.keys.toList());

  Map<String, bool> get simple {
    return {
      for (final s in filters.simple)
        s['key']: box.get(s['key'], defaultValue: false) as bool
    };
  }

  Map<String, bool> _toMap(List<String> keys) {
    return {for (final s in keys) s: box.get(s, defaultValue: false) as bool};
  }
}
