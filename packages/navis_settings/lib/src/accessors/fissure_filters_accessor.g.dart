// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fissure_filters_accessor.dart';

// ignore_for_file: type=lint
mixin _$FissureFilterAccessorMixin on DatabaseAccessor<SettingsDatabase> {
  $AppConfigsTable get appConfigs => attachedDatabase.appConfigs;
  $ToggleSettingsTable get toggleSettings => attachedDatabase.toggleSettings;
  $FissureFiltersTable get fissureFilters => attachedDatabase.fissureFilters;
  FissureFilterAccessorManager get managers =>
      FissureFilterAccessorManager(this);
}

class FissureFilterAccessorManager {
  final _$FissureFilterAccessorMixin _db;
  FissureFilterAccessorManager(this._db);
  $$AppConfigsTableTableManager get appConfigs =>
      $$AppConfigsTableTableManager(_db.attachedDatabase, _db.appConfigs);
  $$ToggleSettingsTableTableManager get toggleSettings =>
      $$ToggleSettingsTableTableManager(
        _db.attachedDatabase,
        _db.toggleSettings,
      );
  $$FissureFiltersTableTableManager get fissureFilters =>
      $$FissureFiltersTableTableManager(
        _db.attachedDatabase,
        _db.fissureFilters,
      );
}
