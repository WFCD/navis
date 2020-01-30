import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/services/notifications/notification_service.dart';
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/utils/helper_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/clients.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'storage/persistent_storage.service.dart';

class Repository {
  Repository(this.persistent, this.cache, this.packageInfo);

  final PersistentStorageService persistent;
  final CacheStorageService cache;
  final PackageInfo packageInfo;

  final notifications = NotificationService.notifications;
  static const warframestat = WorldstateClient();

  final _itemFuture = AsyncMemoizer<BaseItem>();

  static const _dropTableFileName = 'drop_table.json';

  List<SlimDrop> _dropTable;

  Future<File> _dropTableFile() async {
    final temp = await getTemporaryDirectory();
    final table = File('${temp.path}/$_dropTableFileName');

    return table;
  }

  Future<bool> get isDropTableDownloaded async {
    final table = await _dropTableFile();

    return table.existsSync();
  }

  Future<void> loadDropTable() async {
    final table = await _dropTableFile();

    if (!await isDropTableDownloaded) return;

    _dropTable ??= await compute(toDrops, table.readAsStringSync());
  }

  void disposeDropTable() {
    if (_dropTable != null) _dropTable = null;
    return;
  }

  // Prefer to download and update drop table from here
  // since this does the work in a different thread
  Future<bool> updateDropTable() async {
    final directory = await getTemporaryDirectory();
    final instance =
        DropTableCache(cache.getDropTableTimestamp, directory.path);

    final updateTimestamp = await compute(_updateDropTable, instance);

    if (updateTimestamp != instance.localTimestamp) {
      cache.saveDropTableTimestamp(updateTimestamp);
      return true;
    }

    return false;
  }

  static Future<DateTime> _updateDropTable(DropTableCache instance) async {
    final warframestat = DropTableClient(instance.path);
    final timestamp = await warframestat.dropsTimestamp();

    if (timestamp != instance.localTimestamp) {
      await warframestat.downloadDropTable();
      return timestamp;
    }

    return instance.localTimestamp;
  }

  // The amount of search items can be very little or too much to do on the main thread
  // so to be safe keep off the main thread
  Future<List<BaseItem>> searchItems(String term) async {
    return compute(_searchItems, term);
  }

  Future<List<SlimDrop>> searchDrops(String term) {
    return compute(_searchDropTable, DropTableSearch(term, _dropTable));
  }

  Future<BaseItem> getDealItem(DarvoDeal deal) async {
    return _itemFuture.runOnce(() async {
      return await _getDeal(deal);
    });
  }

  Future<BaseItem> _getDeal(DarvoDeal deal) async {
    final cachedDeal = cache.dealId;

    if ((cachedDeal != deal.id) ?? true) {
      final items = await searchItems(deal.item);

      final item = items.firstWhere(
        (i) => i.name == deal.item,
        orElse: () => BaseItem(
          name: deal.item,
          description: '',
          imageName: '',
          tradable: false,
          type: 'null',
        ),
      );

      cache.saveDarvoDealItem(deal.id, item);

      return item;
    }

    return cache.dealItem;
  }

  static Future<List<BaseItem>> _searchItems(String searchTerm) async {
    const warframestat = WorldstateClient();
    final searchs = await warframestat.searchItems(searchTerm);

    return searchs;
  }

  static Future<List<SlimDrop>> _searchDropTable(
      DropTableSearch instance) async {
    final term = instance.searchTerm.toLowerCase();

    return instance.dropTable
        .where((i) => i.item.toLowerCase().contains(term))
        .toList();
  }
}

class DropTableCache {
  DropTableCache(this.localTimestamp, this.path);

  final DateTime localTimestamp;
  final String path;
}

class DropTableSearch {
  DropTableSearch(this.searchTerm, this.dropTable);

  final String searchTerm;
  final List<SlimDrop> dropTable;
}
