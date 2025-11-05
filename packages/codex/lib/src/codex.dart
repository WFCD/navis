import 'dart:convert';

import 'package:codex/src/schema/codex_export.dart';
import 'package:codex/src/schema/codex_item.dart';
import 'package:codex/src/schema/masterable_item.dart';
import 'package:codex/src/schema/profile.dart';
import 'package:codex/src/utils/isolates.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:isar_community/isar.dart';
import 'package:logging/logging.dart';
import 'package:warframestat_client/warframestat_client.dart';

/// {@template codex}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class Codex {
  Codex(NavisDatabase database, Client client) : _client = client, _database = database;

  final Client _client;
  final NavisDatabase _database;

  final _logger = Logger('Codex');

  static List<CollectionSchema<dynamic>> schemas = [CodexExportSchema, CodexItemSchema];

  Future<CodexItem?> fetchItem(String uniqueName) async {
    return _database.instance.codexItems.where().uniqueNameEqualTo(uniqueName).findFirst();
  }

  Future<List<CodexItem>> fetchMasterable() async {
    return _database.instance.codexItems.filter().masterableEqualTo(true).findAll();
  }

  Future<PlayerProfile?> fetchProfile() async {
    return _database.instance.playerProfiles.get(profileDefaultId);
  }

  /// Updates and cleans up inventory items based on masterable items in warframe-items
  Future<void> initializeCodex() async {
    final client = WarframeItemsClient(client: _client);
    var export = await _database.instance.codexExports.get(1);
    if (export != null && !export.isOutdated) {
      _logger.info('Codex is up-to-date');
      return;
    }

    _logger.info('Fetching items...');
    final items = await client.fetchAllItems(
      props: codexProps,
      convert: (list) => list.map(CodexItem.fromJson).toList(),
    );

    _logger.info('Updating codex...');
    final conn = (dir: _database.instance.directory!, schemas: NavisDatabase.schemas, name: _database.instance.name);
    await processCodexItems(conn, items as List<CodexItem>);

    _logger.info('Wrapping up...');
    final now = DateTime.now();
    export = CodexExport()
      ..hash = sha256.convert(utf8.encode('${now.toIso8601String()}-${items.length}')).toString()
      ..timestamp = now;

    await _database.instance.writeTxn(() async => _database.instance.codexExports.put(export!));
  }

  Future<PlayerProfile> syncProfile(String id) async {
    final client = ProfileClient(playerId: id);
    final profile = await client.fetchProfile();

    final player = PlayerProfile(
      playerId: profile.accountId,
      username: profile.username,
      rank: profile.masteryRank,
      dailyStanding: ProfileDailyStanding.fromRecord(profile.dailyStanding),
      unlockedOperator: profile.unlockedOperator,
    );

    await _database.instance.playerProfiles.put(player);

    final conn = (dir: _database.instance.directory!, schemas: NavisDatabase.schemas, name: _database.instance.name);
    await processXpInfo(conn, profile.loadout.xpInfo);

    return (await fetchProfile())!;
  }

  Future<void> resetProfile() async {
    await _database.instance.playerProfiles.clear();
    await _database.instance.masterableItems.clear();
  }

  Future<List<CodexItem>> search(String query) async {
    return _database.instance.codexItems.filter().nameContains(query).findAll();
  }

  Future<List<CodexItem>> syncXpInfo() async {
    final profile = await _database.instance.playerProfiles.get(profileDefaultId);
    final client = ProfileClient(playerId: profile!.playerId);
    final xpInfo = await client.fetchXpInfo();

    final conn = (dir: _database.instance.directory!, schemas: NavisDatabase.schemas, name: _database.instance.name);
    await processXpInfo(conn, xpInfo);

    return fetchMasterable();
  }
}

class NavisDatabase {
  NavisDatabase(this.instance);

  final Isar instance;

  static const List<CollectionSchema<dynamic>> schemas = [
    CodexExportSchema,
    CodexItemSchema,
    MasterableItemSchema,
    PlayerProfileSchema,
  ];

  static Future<NavisDatabase> open({required String directory}) async {
    final instance = await Isar.open(schemas, directory: directory, maxSizeMiB: 1024 * 20, name: 'navis_database');
    return NavisDatabase(instance);
  }
}
