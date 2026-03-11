import 'package:drift/drift.dart';
import 'package:navis_codex/src/codex.steps.dart';
import 'package:navis_codex/src/tables/tables.dart';
import 'package:warframestat_client/warframestat_client.dart' as wfcd;

part 'codex.g.dart';

@DriftDatabase(tables: [CodexItems])
class CodexDatabase extends _$CodexDatabase {
  CodexDatabase(super.e);

  static const name = 'codex';

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.deleteTable('codex_builds');
          await m.deleteTable('xp_items');
        },
      ),
    );
  }

  Future<void> addItem(CodexItem item) {
    return into(codexItems).insertOnConflictUpdate(item);
  }

  Future<void> addItems(List<CodexItem> items) {
    return batch((batch) => batch.insertAllOnConflictUpdate(codexItems, items));
  }

  Future<CodexItem?> fetchItem(String uniqueName) {
    return (select(codexItems, distinct: true)..where((i) => i.uniqueName.contains(uniqueName))).getSingleOrNull();
  }

  Future<List<CodexItem>> search(String query) async {
    // TODO(orn): have a better way to pull static images like this
    const ignores = ['Chassis', 'Neuroptics', 'System'];
    if (ignores.any((i) => query.contains(i))) return [];

    return (select(codexItems, distinct: true)..where((i) => i.name.contains(query))).get();
  }

  Future<List<CodexItem>> fetchMasterable() async {
    return (select(codexItems)..where((i) => i.isMasterable.equals(true))).get();
  }
}
