import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:navis_settings/src/accessors/accessors.dart';
import 'package:navis_settings/src/schema/schema.dart';

part 'settings_database.g.dart';

/// {@template navis_settings}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
@DriftDatabase(
  tables: [AppConfigs, ToggleSettings, CycleFilters, FissureFilters],
  daos: [CycleFiltersAccessor, FissureFilterAccessor],
)
class SettingsDatabase extends _$SettingsDatabase {
  /// {@macro navis_settings}
  SettingsDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
