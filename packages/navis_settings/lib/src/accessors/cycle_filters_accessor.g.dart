// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_filters_accessor.dart';

// ignore_for_file: type=lint
mixin _$CycleFiltersAccessorMixin on DatabaseAccessor<SettingsDatabase> {
  $AppConfigsTable get appConfigs => attachedDatabase.appConfigs;
  $ToggleSettingsTable get toggleSettings => attachedDatabase.toggleSettings;
  $CycleFiltersTable get cycleFilters => attachedDatabase.cycleFilters;
  CycleFiltersAccessorManager get managers => CycleFiltersAccessorManager(this);
}

class CycleFiltersAccessorManager {
  final _$CycleFiltersAccessorMixin _db;
  CycleFiltersAccessorManager(this._db);
  $$AppConfigsTableTableManager get appConfigs =>
      $$AppConfigsTableTableManager(_db.attachedDatabase, _db.appConfigs);
  $$ToggleSettingsTableTableManager get toggleSettings =>
      $$ToggleSettingsTableTableManager(
        _db.attachedDatabase,
        _db.toggleSettings,
      );
  $$CycleFiltersTableTableManager get cycleFilters =>
      $$CycleFiltersTableTableManager(_db.attachedDatabase, _db.cycleFilters);
}
