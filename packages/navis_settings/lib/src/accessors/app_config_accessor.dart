import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:navis_settings/navis_settings.dart';
import 'package:navis_settings/src/schema/schema.dart';

part 'app_config_accessor.g.dart';

@DriftAccessor(tables: [AppConfigs])
class AppConfigAccessor extends DatabaseAccessor<SettingsDatabase> with _$AppConfigAccessorMixin {
  AppConfigAccessor(super.attachedDatabase);

  Stream<AppConfig> watchSettings() => select(appConfigs).watchSingle();

  Future<AppConfig> fetchSettings() async {
    final temp = await select(appConfigs).getSingleOrNull();
    if (temp == null) {
      return into(appConfigs).insertReturning(AppConfigsCompanion.insert());
    }

    return temp;
  }

  Future<void> updateSettings({String? language, ThemeMode? theme, bool? optOut, String? account}) async {
    final current = await select(appConfigs).getSingle();

    await (update(appConfigs)..where((s) => s.id.equals(current.id))).write(
      AppConfigsCompanion(
        language: Value.absentIfNull(language),
        theme: Value.absentIfNull(theme?.index),
        optOut: Value.absentIfNull(optOut),
        account: Value.absentIfNull(account),
      ),
    );
  }
}
