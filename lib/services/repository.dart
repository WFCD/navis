import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/services/notifications/notification_service.dart';
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:package_info/package_info.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import 'storage/persistent_storage.service.dart';

class Repository {
  Repository(this.persistent, this.cache, this.packageInfo);

  final PersistentStorageService persistent;
  final CacheStorageService cache;
  final PackageInfo packageInfo;

  final notifications = NotificationService.notifications;

  final _itemFuture = AsyncMemoizer<BaseItem>();

  static final warframestat = WarframestatClient(http.Client());

  // The amount of search items can be very little or too much to do on the main thread
  // so to be safe keep off the main thread
  Future<List<BaseItem>> searchItems(String term) async {
    return compute(_searchItems, term);
  }

  Future<List<SlimDrop>> searchDrops(String term) {
    return compute(_searchDrops, term);
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

  static Future<List<SlimDrop>> _searchDrops(String term) async {
    final warframestat = WarframestatClient(http.Client());
    final results = await warframestat.searchDrops(term);

    return results.where((element) => element.item.contains(term)).toList();
  }

  static Future<List<BaseItem>> _searchItems(String searchTerm) async {
    final warframestat = WarframestatClient(http.Client());
    final results = await warframestat.searchItems(searchTerm);

    return results;
  }
}
