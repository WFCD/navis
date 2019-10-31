import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

class WorldstateApiService {
  WorldstateApiService();

  static const dropTablePath = '/drop_table.json';

  final _persistent = PersistentStorageService.instance;
  final _cache = CacheStorageService.instance;

  final AsyncMemoizer<ItemObject> _itemFuture = AsyncMemoizer();

  Future<List<ItemObject>> search(String searchTerm) async {
    return compute(_search, searchTerm);
  }

  static Future<List<ItemObject>> _search(String searchTerm) async {
    final api = WorldstateApiWrapper(http.Client());

    return await api.searchItems(searchTerm);
  }

  Future<ItemObject> getDealItem(DarvoDeal deal) async {
    return _itemFuture.runOnce(() async {
      return await getDeal(deal);
    });
  }

  Future<ItemObject> getDeal(DarvoDeal deal) async {
    final cachedDeal = _cache.dealId;

    if ((cachedDeal != deal.id) ?? true) {
      final items = await search(deal.item);

      final item = items.firstWhere(
        (i) => i.name == deal.item,
        orElse: () => BasicItem(name: deal.item, description: ''),
      );

      _cache.saveDarvoDealItem(deal.id, item);

      return item;
    }

    return _cache.dealItem;
  }

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    final _platform = platform ?? _persistent.platform ?? Platforms.pc;

    return compute<Platforms, Worldstate>(_retrieveWorldstate, _platform);
  }

  static Future<Worldstate> _retrieveWorldstate([Platforms platform]) async {
    final api = WorldstateApiWrapper(http.Client());
    final worldstate = await api.getWorldstate(platform);

    return cleanState(worldstate);
  }
}
