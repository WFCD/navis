import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/resources/api/worldstate_client.dart';
import 'package:navis/resources/storage/cache.dart';
import 'package:navis/utils/enums.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class WorldstateRepository {
  WorldstateRepository(this.cache);

  final CacheResource cache;

  final _itemFuture = AsyncMemoizer<ItemObject>();

  Future<Worldstate> getWorldstate(Platforms platform) async {
    return compute<Platforms, Worldstate>(_getWorldstate, platform);
  }

  static Future<Worldstate> _getWorldstate(Platforms platform) async {
    const WorldstateClient client = WorldstateClient();

    return await client.getWorldstate(platform);
  }

  Future<List<ItemObject>> searchItems(String searchTerm) async {
    return compute<String, List<ItemObject>>(_searchItems, searchTerm);
  }

  static Future<List<ItemObject>> _searchItems(String searchTerm) async {
    const WorldstateClient client = WorldstateClient();

    return await client.searchItems(searchTerm);
  }

  Future<List<SynthTarget>> getTargets() => compute(_getTargets, null);

  // comute needs an arg to start so just put in null for now
  Future<List<SynthTarget>> _getTargets(dynamic eh) async {
    const WorldstateClient client = WorldstateClient();

    return client.synthTargets();
  }

  Future<ItemObject> getItemDeal(DarvoDeal deal) async {
    return _itemFuture.runOnce(() async {
      return await _getItemDeal(deal);
    });
  }

  Future<ItemObject> _getItemDeal(DarvoDeal deal) async {
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
}
