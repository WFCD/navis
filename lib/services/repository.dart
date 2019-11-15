import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/services/notifications/notification_service.dart';
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/utils/json_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_api_wrapper/wfcd_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'storage/persistent_storage.service.dart';

class Repository {
  Repository(this.persistent, this.cache, this.packageInfo);

  final PersistentStorageService persistent;
  final CacheStorageService cache;
  final PackageInfo packageInfo;

  final notifications = NotificationService.notifications;
  final warframestat = WfcdWrapper();

  final _itemFuture = AsyncMemoizer<ItemObject>();

  static const _dropTableFileName = 'drop_table.json';

  List<SlimDrop> _dropTable;

  Future<bool> get isDropTableDownloaded async {
    final temp = await getTemporaryDirectory();
    final table = File('${temp.path}/$_dropTableFileName');

    return table.existsSync();
  }

  Future<void> loadDropTable() async {
    final temp = await getTemporaryDirectory();
    final table = File('${temp.path}/$_dropTableFileName');

    _dropTable ??=
        await compute(JsonToObjects.convertToDrop, table.readAsStringSync());
  }

  void disposeDropTable() {
    if (_dropTable != null) _dropTable = null;
    return;
  }

  // Prefer to download and update drop table from here
  // since this does the work in a different thread
  Future<bool> updateDropTable() async {
    final temp = await getTemporaryDirectory();
    final table = File('${temp.path}/$_dropTableFileName');

    final instance = DropTableCache(cache.getDropTableTimestamp, table);

    final updateTimestamp = await compute(_updateDropTable, instance);

    if (updateTimestamp != instance.localTimestamp) {
      cache.saveDropTableTimestamp(updateTimestamp);
      return true;
    }

    return false;
  }

  static Future<DateTime> _updateDropTable(DropTableCache instance) async {
    final warframestat = WfcdWrapper();
    final timestamp = await warframestat.dropsTimestamp();

    if (timestamp != instance.localTimestamp) {
      await warframestat.downloadDropTable(instance.table);
      return timestamp;
    }

    return instance.localTimestamp;
  }

  // The amount of search items can be very little or too much to do on the main thread
  // so to be safe keep off the main thread
  Future<List<ItemObject>> searchItems(String term) async {
    return compute(_searchItems, term);
  }

  Future<List<SlimDrop>> searchDrops(String term) {
    return compute(_searchDropTable, DropTableSearch(term, _dropTable));
  }

  Future<ItemObject> getDealItem(DarvoDeal deal) async {
    return _itemFuture.runOnce(() async {
      return await _getDeal(deal);
    });
  }

  Future<ItemObject> _getDeal(DarvoDeal deal) async {
    final cachedDeal = cache.dealId;

    if ((cachedDeal != deal.id) ?? true) {
      final items = await searchItems(deal.item);

      final item = items.firstWhere(
        (i) => i.name == deal.item,
        orElse: () => BasicItem(name: deal.item, description: ''),
      );

      cache.saveDarvoDealItem(deal.id, item);

      return item;
    }

    return cache.dealItem;
  }

  static Future<List<ItemObject>> _searchItems(String searchTerm) async {
    final warframestat = WfcdWrapper();
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
  DropTableCache(this.localTimestamp, this.table);

  final DateTime localTimestamp;
  final File table;
}

class DropTableSearch {
  DropTableSearch(this.searchTerm, this.dropTable);

  final String searchTerm;
  final List<SlimDrop> dropTable;
}
