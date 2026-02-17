import 'package:drift/drift.dart';
import 'package:navis_settings/navis_settings.dart';
import 'package:navis_settings/src/accessors/abstract_accessor.dart';
import 'package:navis_settings/src/schema/notification_filters.dart';

part 'fissure_filters_accessor.g.dart';

@DriftAccessor(tables: [FissureFilters])
class FissureFilterAccessor extends DatabaseAccessor<SettingsDatabase>
    with _$FissureFilterAccessorMixin
    implements FilterAccessor {
  FissureFilterAccessor(super.attachedDatabase);

  @override
  Future<List<FissureFilter>> getAll() => select(fissureFilters).get();

  @override
  Future<FissureFilter?> getFilter(int id) async {
    return (select(fissureFilters)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> addFilter(FissureFilter filter) async {
    final toggles = await select(toggleSettings).getSingle();
    if (await doesExist(filter) != null) throw Exception(filter.toString());

    return into(fissureFilters).insert(
      FissureFiltersCompanion.insert(
        type: filter.type,
        tier: filter.tier,
        togglesId: toggles.id,
        enableRegular: filter.enableRegular,
        enableSteelPath: filter.enableSteelPath,
        enableVoidStorm: filter.enableVoidStorm,
      ),
    );
  }

  @override
  Future<int?> doesExist(FissureFilter filter) async {
    final toggles = await select(toggleSettings).getSingle();
    final filters = select(fissureFilters)
      ..where((c) => c.type.equals(filter.type) & c.tier.equals(filter.tier) & c.togglesId.equals(toggles.id));

    return (await filters.getSingleOrNull())?.id;
  }

  @override
  Future<void> removeFilter(int id) {
    return (delete(fissureFilters)..where((c) => c.id.equals(id))).go();
  }
}
