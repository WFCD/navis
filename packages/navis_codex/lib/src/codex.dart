import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:navis_codex/src/models/warframe_item.dart';
import 'package:navis_codex/src/tables/tables.dart';
import 'package:navis_codex/src/utils/extensions.dart';
import 'package:profile_models/profile_models.dart' as profile;
import 'package:sentry_drift/sentry_drift.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:warframestat_client/warframestat_client.dart' as wfcd;

part 'codex.g.dart';

typedef MasterableItem = ({CodexItem item, int xp});

@DriftDatabase(tables: [CodexBuilds, CodexItems, XpItems])
class CodexDatabase extends _$CodexDatabase {
  CodexDatabase(Client client, CacheManager manager, [QueryExecutor? executor])
    : _client = client,
      _manager = manager,
      super(executor ?? _openConnection());

  final Client _client;
  final CacheManager _manager;

  final _logger = Logger('Codex');

  static const _name = 'codex';

  static QueryExecutor _openConnection() {
    return driftDatabase(name: _name).interceptWith(SentryQueryInterceptor(databaseName: _name));
  }

  Future<void> initialize() async {
    final client = wfcd.WarframeItemsClient(client: _client);
    final buildLabel = (await WarframeRepository(client: _client, manager: _manager).fetchWorldstate()).buildLabel;
    var lastBuild = await select(codexBuilds).getSingleOrNull();
    if (lastBuild?.buildLabel == buildLabel || !(lastBuild?.isOutdated ?? true)) {
      _logger.info('Codex updated');
      return;
    }

    _logger.info('Fetching items');
    List<WarframeItem> items;
    try {
      items = await client.fetchAllItems(props: codexProps, encoder: WarframeItem.fromJson) as List<WarframeItem>;
    } on Exception {
      _logger.warning('Failed to populate codex with items');
      return;
    }

    _logger.info('Updating items');
    final inserts = items.map((i) => i.toCodexItem()).toList();
    await batch((batch) async {
      batch.insertAllOnConflictUpdate(codexItems, inserts);
    });

    _logger.info('Updating timestamp');
    lastBuild = CodexBuild(id: 1, buildLabel: buildLabel, timestamp: DateTime.timestamp());
    await codexBuilds.insertOnConflictUpdate(lastBuild);

    _logger.info('Finished updating the codex');
  }

  Future<List<CodexItem>> search(String query) async {
    // TODO(orn): have a better way to pull static images like this
    const ignores = ['Chassis', 'Neuroptics', 'System'];
    if (ignores.any((i) => query.contains(i))) return [];

    final results = await (codexItems.select(distinct: true)..where((i) => i.name.contains(query))).get();
    if (results.isNotEmpty) return results;

    _logger.warning("$query wasn't found falling back to warframe-items");
    final client = wfcd.WarframeItemsClient(client: _client);
    final items = await client.search(query, props: codexProps, encoder: WarframeItem.fromJson);

    return items.map((i) => i.toCodexItem()).toList();
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
