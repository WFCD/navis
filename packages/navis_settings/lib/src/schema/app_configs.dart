import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

class AppConfigs extends Table {
  late final id = integer().autoIncrement()();

  late final language = text().withDefault(const Constant('en'))();

  late final theme = integer().withDefault(Constant(ThemeMode.system.index))();

  late final optOut = boolean().withDefault(const Constant(false))();

  late final account = text().nullable()();
}
