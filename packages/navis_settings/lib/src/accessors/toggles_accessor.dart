import 'package:drift/drift.dart';
import 'package:navis_settings/src/accessors/accessors.dart';
import 'package:navis_settings/src/schema/schema.dart';
import 'package:navis_settings/src/settings_database.dart';

part 'toggles_accessor.g.dart';

@DriftAccessor(tables: [ToggleSettings])
class TogglesAccessor extends DatabaseAccessor<SettingsDatabase> with _$TogglesAccessorMixin {
  TogglesAccessor(super.attachedDatabase);

  Stream<ToggleSetting> watchSettings() => select(toggleSettings).watchSingle();

  Future<ToggleSetting> fetchToggles() async {
    final settings = await AppConfigAccessor(attachedDatabase).fetchSettings();
    final temp = await select(toggleSettings).getSingleOrNull();
    if (temp == null) {
      return into(toggleSettings).insertReturning(ToggleSettingsCompanion.insert(settingsId: settings.id));
    }

    return temp;
  }

  Future<void> updateToggles({
    bool? enableGiftAlerts,
    bool? enableOperationAlerts,
    bool? enableBaroAlerts,
    bool? enableDarvoAlerts,
    bool? enableSorieAlerts,
    bool? enableArchonAlerts,
    bool? enablePrimeAccess,
    bool? enableStreams,
    bool? enableUpdates,
  }) async {
    final current = await select(toggleSettings).getSingle();

    await (update(toggleSettings)..where((s) => s.id.equals(current.id))).write(
      ToggleSettingsCompanion(
        enableGiftAlerts: Value.absentIfNull(enableGiftAlerts),
        enableOperationAlerts: Value.absentIfNull(enableOperationAlerts),
        enableBaroAlerts: Value.absentIfNull(enableBaroAlerts),
        enableDarvoAlerts: Value.absentIfNull(enableDarvoAlerts),
        enableSorieAlerts: Value.absentIfNull(enableSorieAlerts),
        enableArchonAlerts: Value.absentIfNull(enableArchonAlerts),
        enablePrimeAccess: Value.absentIfNull(enablePrimeAccess),
        enableStreams: Value.absentIfNull(enableStreams),
        enableUpdates: Value.absentIfNull(enableUpdates),
      ),
    );
  }
}
