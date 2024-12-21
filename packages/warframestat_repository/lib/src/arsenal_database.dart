import 'package:drift/drift.dart';
import 'package:warframestat_client/warframestat_client.dart'
    show ItemType, MinimalItem, XpItem;
import 'package:warframestat_repository/src/converters/converters.dart';
import 'package:warframestat_repository/src/tables/tables.dart';
import 'package:warframestat_repository/src/utils/utils.dart';

part 'arsenal_database.g.dart';

@DriftDatabase(tables: [ArsenalItem, ArsenalManifest, ArsenalItemXp])
class ArsenalDatabase extends _$ArsenalDatabase {
  ArsenalDatabase(super.e);

  @override
  int get schemaVersion => 1;

  Future<DateTime?> lastUpdate() async {
    return (await select(arsenalManifest).getSingleOrNull())?.lastUpdate;
  }

  Future<void> updateTimeStamp() {
    return update(arsenalManifest).write(
      ArsenalManifestCompanion.insert(
        id: const Value(1),
        lastUpdate: DateTime.timestamp(),
      ),
    );
  }

  Future<void> updateItems(List<MinimalItem> items) {
    return transaction(() async {
      for (final item in items) {
        // Sometimes items are fixed upstream, if it's no longer masterable
        // then remove it from the manifest
        if (item.masterable != true) {
          await (delete(arsenalItem)
                ..where((i) => i.uniqueName.equals(item.uniqueName)))
              .go();

          continue;
        }

        await into(arsenalItem).insertOnConflictUpdate(item.toInsertable());
      }

      await into(arsenalManifest).insertOnConflictUpdate(
        ArsenalManifestCompanion.insert(
          id: const Value(1),
          lastUpdate: DateTime.timestamp(),
        ),
      );
    });
  }

  Future<void> updateXp(List<XpItem> items) async {
    return transaction(() async {
      for (final item in items) {
        await into(arsenalItemXp).insertOnConflictUpdate(
          ArsenalItemXpCompanion.insert(
            uniqueName: item.uniqueName,
            xp: item.xp,
          ),
        );
      }
    });
  }

  Future<List<MasteryProgress>> fetchArsenal() {
    return transaction(() async {
      final items = await select(arsenalItem).get();
      final primaryKeys = items.map((i) => i.uniqueName);
      final xp = await (select(arsenalItemXp)
            ..where((xp) => xp.uniqueName.isIn(primaryKeys)))
          .get();

      final xpMap = {for (final x in xp) x.uniqueName: x.xp};

      return items.map((item) {
        final xp = xpMap[item.uniqueName] ?? 0;
        return MasteryProgress(
          item: item,
          xp: xp,
          missing: !xpMap.containsKey(item.uniqueName),
        );
      }).toList();
    });
  }
}
