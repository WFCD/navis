import 'dart:async';
import 'dart:isolate';

import 'package:cache/cache.dart';
import 'package:collection/collection.dart';
import 'package:item_repository/src/extensions.dart';
import 'package:storage/storage.dart';
import 'package:warframe_common/warframe_common.dart';

const _itemUpdateInterval = Duration(hours: 6);

typedef ItemUpdateProgress = void Function(double progress, int total);

/// {@template items_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ItemsRepository {
  /// {@macro items_repository}
  const ItemsRepository(this._client, this._cache, this._itemStore);

  final WarframeItemsClient _client;
  final CacheManager _cache;
  final Storage<Map<dynamic, dynamic>> _itemStore;

  // Future<({String? label, DateTime timestamp})?> get lastRun => _itemStore.build;

  Future<WarframeItem?> fetchItemFStore(String uniqueName) async {
    final data = _itemStore.read(uniqueName);
    return data != null ? WarframeItem.fromDatabase(data as Map<String, dynamic>) : null;
  }

  Future<Item?> fetchItemFApi(String uniqueName) async {
    final cached = await _cache.get<Map<String, dynamic>>(uniqueName);
    if (cached != null) return Isolate.run(() => toItem(cached));

    final item = await _client.fetchItem(uniqueName);
    if (item == null) return null;

    await _cache.set(uniqueName, item.toJson(), ttl: _itemUpdateInterval);
    return item;
  }

  Future<List<WarframeItem>> search(String name) async {
    final stored = _itemStore.readAll().cast<Map<String, dynamic>>();
    final resuls = stored.where((i) => i['name'] == name).map(WarframeItem.fromDatabase);
    if (resuls.isNotEmpty) return resuls.toList()..prioritizeResults();

    final items = await _client.searchRaw(name, props: WarframeItem.requiredProps);
    return items.map(WarframeItem.fromApi).toList()..prioritizeResults();
  }

  Future<WarframeItem?> searchIncarnon(String name) async {
    final incarnons = await search('Incarnon');
    final normalizeName = name.replaceAll(RegExp('and', caseSensitive: false), '&');

    return incarnons.firstWhereOrNull((i) => i.name == normalizeName);
  }

  Future<void> updateItems(String buildLabel, {ItemUpdateProgress? onProgress, bool forceUpdate = false}) async {
    const key = 'buildStoreLabel';
    if (!forceUpdate) {
      final lastRun = await _cache.get<Map<String, dynamic>>(key);
      final timestamp = lastRun?['timestamp'] as String?;

      final labelChanged = lastRun?['label'] != buildLabel;
      final lapsed =
          timestamp == null || DateTime.timestamp().difference(DateTime.parse(timestamp)) > _itemUpdateInterval;

      if (!labelChanged || !lapsed) return;
    }

    final items = await _client.fetchAllItemsRaw(WarframeItem.requiredProps);
    final mapped = {for (final item in items) item['uniqueName'] as String: item};
    await _cache.set(key, {'label': buildLabel, 'timestamp': DateTime.timestamp()});

    if (onProgress != null) {
      for (var i = 0; i < items.length; i++) {
        onProgress(i / items.length, items.length);
        final item = items[i];
        await _itemStore.write(item['uniqueName'] as String, item);
      }
    } else {
      await _itemStore.writeAll(mapped);
    }

    return;
  }
}
