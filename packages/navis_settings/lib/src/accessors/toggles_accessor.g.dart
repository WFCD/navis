// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggles_accessor.dart';

// ignore_for_file: type=lint
mixin _$TogglesAccessorMixin on DatabaseAccessor<SettingsDatabase> {
  $AppConfigsTable get appConfigs => attachedDatabase.appConfigs;
  $ToggleSettingsTable get toggleSettings => attachedDatabase.toggleSettings;
  TogglesAccessorManager get managers => TogglesAccessorManager(this);
}

class TogglesAccessorManager {
  final _$TogglesAccessorMixin _db;
  TogglesAccessorManager(this._db);
  $$AppConfigsTableTableManager get appConfigs =>
      $$AppConfigsTableTableManager(_db.attachedDatabase, _db.appConfigs);
  $$ToggleSettingsTableTableManager get toggleSettings =>
      $$ToggleSettingsTableTableManager(
        _db.attachedDatabase,
        _db.toggleSettings,
      );
}
