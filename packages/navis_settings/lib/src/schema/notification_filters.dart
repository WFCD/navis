import 'package:drift/drift.dart';
import 'package:navis_settings/src/schema/app_configs.dart';

class ToggleSettings extends Table {
  late final id = integer().autoIncrement()();

  /// Alerts
  late final enableGiftAlerts = boolean().withDefault(const Constant(false))();
  late final enableOperationAlerts = boolean().withDefault(const Constant(false))();

  /// Baro Ki'Teer
  late final enableBaroAlerts = boolean().withDefault(const Constant(false))();

  /// Weekly and daily stuff
  late final enableDarvoAlerts = boolean().withDefault(const Constant(false))();
  late final enableSorieAlerts = boolean().withDefault(const Constant(false))();
  late final enableArchonAlerts = boolean().withDefault(const Constant(false))();

  /// Warframe news and stream announcements
  late final enablePrimeAccess = boolean().withDefault(const Constant(false))();
  late final enableStreams = boolean().withDefault(const Constant(false))();
  late final enableUpdates = boolean().withDefault(const Constant(false))();

  late final settingsId = integer().references(AppConfigs, #id)();
}

abstract class Filters extends Table {
  late final id = integer().autoIncrement()();
  late final type = text()();
  late final togglesId = integer().references(ToggleSettings, #id)();
}

class CycleFilters extends Filters {
  late final phase = text()();
}

class FissureFilters extends Filters {
  late final tier = integer()();
  late final enableRegular = boolean()();
  late final enableSteelPath = boolean()();
  late final enableVoidStorm = boolean()();
}
