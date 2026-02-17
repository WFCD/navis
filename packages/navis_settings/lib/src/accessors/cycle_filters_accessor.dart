import 'package:drift/drift.dart';
import 'package:navis_settings/navis_settings.dart';
import 'package:navis_settings/src/accessors/abstract_accessor.dart';
import 'package:navis_settings/src/schema/notification_filters.dart';

part 'cycle_filters_accessor.g.dart';

@DriftAccessor(tables: [CycleFilters])
class CycleFiltersAccessor extends DatabaseAccessor<SettingsDatabase>
    with _$CycleFiltersAccessorMixin
    implements FilterAccessor {
  CycleFiltersAccessor(super.attachedDatabase);

  @override
  Future<List<CycleFilter>> getAll() => select(cycleFilters).get();

  @override
  Future<CycleFilter?> getFilter(int id) async {
    return (select(cycleFilters)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> addFilter(CycleFilter filter) async {
    final toggles = await select(toggleSettings).getSingle();
    if (await doesExist(filter) != null) throw Exception(filter.toString());

    return into(cycleFilters).insert(
      CycleFiltersCompanion.insert(type: filter.type, phase: filter.phase, togglesId: toggles.id),
    );
  }

  @override
  Future<int?> doesExist(CycleFilter filter) async {
    final toggles = await select(toggleSettings).getSingle();
    final filters = select(cycleFilters)
      ..where((c) => c.type.equals(filter.type) & c.phase.equals(filter.phase) & c.togglesId.equals(toggles.id));

    return (await filters.getSingleOrNull())?.id;
  }

  @override
  Future<void> removeFilter(int id) {
    return (delete(cycleFilters)..where((c) => c.id.equals(id))).go();
  }
}
