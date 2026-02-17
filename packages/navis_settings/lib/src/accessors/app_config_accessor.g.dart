// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_accessor.dart';

// ignore_for_file: type=lint
mixin _$AppConfigAccessorMixin on DatabaseAccessor<SettingsDatabase> {
  $AppConfigsTable get appConfigs => attachedDatabase.appConfigs;
  AppConfigAccessorManager get managers => AppConfigAccessorManager(this);
}

class AppConfigAccessorManager {
  final _$AppConfigAccessorMixin _db;
  AppConfigAccessorManager(this._db);
  $$AppConfigsTableTableManager get appConfigs =>
      $$AppConfigsTableTableManager(_db.attachedDatabase, _db.appConfigs);
}
