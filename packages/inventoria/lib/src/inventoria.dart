import 'dart:convert';

import 'package:cache_client/cache_client.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:inventoria/src/inventoria.steps.dart';
import 'package:inventoria/src/models/models.dart';
import 'package:inventoria/src/utils/utils.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'inventoria.g.dart';

/// {@template inventoria}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class Inventoria {
  /// {@macro inventoria}
  Inventoria({required Box<CachedItem> cache, Client? client})
    : _cache = cache,
      _client = client ?? Client(),
      _database = InventoriaDatabase();

  final Box<CachedItem> _cache;
  final Client _client;
  final InventoriaDatabase _database;

  final _logger = Logger('Inventoria');

  /// Get all stored inventory items
  Future<List<InventoryItemData>> fetchInventory() {
    return _database.managers.inventoryItem.get();
  }

  /// Get stored profile
  Future<DriftProfileData?> fetchProfile() {
    return _database.managers.driftProfile.getSingleOrNull();
  }

  /// Clears out the entire database
  Future<void> reset() async {
    _logger.warning('Clearing all items');
    await _database.inventoriaManifest.deleteAll();
    await _database.inventoryItem.deleteAll();
    await _database.driftProfile.deleteAll();
  }

  /// Update offline copy of profile and xp items
  Future<void> updateProfile(String id) async {
    _logger.info('Updating profile');
    final client = ProfileClient(
      client: CacheClient(cache: _cache, client: _client, ttl: const Duration(minutes: 60)),
      playerId: id,
    );
    final profile = await client.fetchProfile();

    await _database
        .into(_database.driftProfile)
        .insertOnConflictUpdate(
          DriftProfileCompanion.insert(id: profile.accountId, username: profile.username, rank: profile.masteryRank),
        );

    final manifest = await fetchInventory();
    if (manifest.isEmpty) {
      _logger.warning('Manifest is empty, building manifest list before syncing XP');
      await updateInventory();
    }

    _logger.info('Syncing XP with items');
    await _database.computeWithDatabase(
      connect: InventoriaDatabase.new,
      computation: (d) async {
        final items = await d.select(d.inventoryItem).get();
        final manifest = items.map((i) => i.uniqueName);
        final updates = profile.loadout.xpInfo.where((x) {
          if (!manifest.contains(x.uniqueName)) return false;
          final item = items.firstWhere((i) => i.uniqueName == x.uniqueName);

          return item.xp < x.xp;
        });

        await d.transaction(() async {
          for (final update in updates) {
            final item = items.firstWhere((i) => i.uniqueName == update.uniqueName);

            await (d.update(d.inventoryItem)
              ..whereSamePrimaryKey(item)).write(InventoryItemCompanion(xp: Value(update.xp)));
          }
        });
      },
    );
  }

  /// Updates and cleans up inventory items based on masterable items in warframe-items
  Future<void> updateInventory() async {
    final timestamp = (await _database.managers.inventoriaManifest.getSingleOrNull())?.timestamp;
    if (timestamp != null && timestamp.difference(DateTime.timestamp()) < const Duration(days: 7)) return;

    _logger.info('Building inventory manifest');
    final items = (await WarframeItemsClient(
      client: _client,
    ).fetchAllItems(minimal: true)).where((i) => (i as MinimalItem).masterable ?? false);

    final currentItems = await _database.managers.inventoryItem.get();

    final currentManifest = currentItems.map((i) => i.uniqueName);
    final newManifest = items.map((i) => i.uniqueName);

    final newItems = items.where((i) => !currentManifest.contains(i.uniqueName)).map((i) => i.toInsert());
    _logger.info('Adding ${newItems.length} new items');
    await _database.batch((b) => b.insertAll(_database.inventoryItem, newItems));

    final oldItems = currentItems.where((i) => !newManifest.contains(i.uniqueName)).map((i) => i.uniqueName);
    if (oldItems.isNotEmpty) {
      _logger.warning(
        '${oldItems.length} are marked for removal (they may have been mistakenly marked masterable via warframe-items)',
      );
    }
    await _database.batch((b) => b.deleteWhere(_database.inventoryItem, (i) => i.uniqueName.isIn(oldItems)));

    await _database.inventoriaManifest.insertOnConflictUpdate(
      InventoriaManifestData(
        id: 1,
        hash: sha256.convert(utf8.encode(newManifest.join())).toString(),
        timestamp: DateTime.timestamp(),
      ),
    );
  }
}

@visibleForTesting
@DriftDatabase(tables: [InventoryItem, DriftProfile, InventoriaManifest])
class InventoriaDatabase extends _$InventoriaDatabase {
  /// {@macro inventoria}
  InventoriaDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: _databaseName));

  @override
  int get schemaVersion => 3;

  static const _databaseName = 'inventoria';

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (Migrator m, Schema2 schema) async {
          await m.addColumn(inventoryItem, schema.inventoryItem.isMissing);
          await m.addColumn(inventoryItem, schema.inventoryItem.isHidden);
          await m.alterTable(TableMigration(schema.inventoryItem));
        },
        from2To3: (Migrator m, Schema3 schema) => m.createTable(schema.inventoriaManifest),
      ),
    );
  }
}
