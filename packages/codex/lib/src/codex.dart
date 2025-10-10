import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:codex/src/schema/codex_export.dart';
import 'package:codex/src/schema/codex_item.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:isar_community/isar.dart';
import 'package:logging/logging.dart';
import 'package:navis_database/navis_database.dart';
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

  Isar get _instance => _database.instance;

  Future<List<CodexItem>> search(String query) async {
    return _instance.codexItems.filter().nameContains(query).findAll();
  }

  Future<CodexItem?> fetchItem(String uniqueName) async {
    return _instance.codexItems.where().uniqueNameEqualTo(uniqueName).findFirst();
  }

  /// Updates and cleans up inventory items based on masterable items in warframe-items
  Future<void> initializeCodex() async {
    final itemsClient = WarframeItemsClient(client: _client);
    var export = await _instance.codexExports.get(1);
    if (export != null && !export.isOutdated) {
      _logger.info('Codex is up-to-date');
      return;
    }

    _logger.info('Fetching items...');
    final items =
        (await itemsClient.fetchAllItems(props: codexProps, convert: (list) => list.map(CodexItem.fromJson).toList()))
            as List<CodexItem>;

    _logger.info('Updating codex...');
    final params = (dir: _instance.directory!, schemas: _database.schemas, name: _instance.name);
    await _processItems(items, params);

    _logger.info('Wrapping up...');
    export = CodexExport()
      ..hash = sha256.convert(utf8.encode(items.map((i) => i.uniqueName).join())).toString()
      ..timestamp = DateTime.now();

    await _instance.writeTxn(() async => _instance.codexExports.put(export!));
  }

  static Future<void> _processItems(
    List<CodexItem> items,
    ({String dir, String name, List<CollectionSchema<dynamic>> schemas}) conn,
  ) async {
    await Isolate.run(() async {
      final slices = items.slices(items.length ~/ (Platform.numberOfProcessors ~/ 2));

      await Future.wait(
        slices.map(
          (slice) async => Isolate.run(() async {
            final database = await Isar.open(conn.schemas, directory: conn.dir, name: conn.name);

            await database.writeTxn(() async {
              for (final item in slice) {
                final i = await database.codexItems.where().uniqueNameEqualTo(item.uniqueName).findFirst();
                if (i == item) continue;

                await database.codexItems.put(item);
              }
            });
          }),
        ),
      );
    });
  }
}
