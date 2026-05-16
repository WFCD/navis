import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:logging/logging.dart';
import 'package:navis_codex/src/tables/tables.dart';
import 'package:profile_models/profile_models.dart' as profile;
import 'package:sentry_drift/sentry_drift.dart';
import 'package:warframestat_client/warframestat_client.dart' as wfcd;

part 'codex.g.dart';

typedef MasterableItem = ({CodexItem item, int xp});

@DriftDatabase(tables: [CodexBuilds, CodexItems, XpItems])
class CodexDatabase extends _$CodexDatabase {
  CodexDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  final _logger = Logger('Codex');

  static const _name = 'codex';

  static QueryExecutor _openConnection() {
    return driftDatabase(name: _name).interceptWith(SentryQueryInterceptor(databaseName: _name));
  }

  Future<void> addItems(List<CodexItem> items) async {
    return computeWithDatabase(
      connect: CodexDatabase.new,
      computation: (codex) async {
        await codex.batch((batch) async {
          batch.insertAllOnConflictUpdate(codex.codexItems, items);
        });
      },
    );
  }

  Future<List<CodexItem>> search(String query) async {
    return (codexItems.select(distinct: true)..where((i) => i.name.contains(query))).get();
  }

  Future<List<CodexItem>> fetchMasterable() async {
    return (select(codexItems)..where((i) => i.isMasterable.equals(true))).get();
  }

  Future<void> syncXpInfo(List<profile.XpItem> xpInfo) async {
    final items = xpInfo.map((i) => XpItem(uniqueName: i.uniqueName, xp: i.xp));

    _logger.info('Syncing XP info');
    await batch((batch) async {
      batch.insertAllOnConflictUpdate(xpItems, items);
    });
    _logger.info('XP info in sync');
  }

  Future<List<MasterableItem>> buildXpInfo() async {
    final items = await fetchMasterable();
    final xi = await select(xpItems).get();
    final mappedXpItems = {for (final x in xi) x.uniqueName: x.xp};

    return items.map((i) => (item: i, xp: mappedXpItems[i.uniqueName] ?? 0)).toList();
  }

  @override
  int get schemaVersion => 1;
}
