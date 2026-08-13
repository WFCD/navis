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
    if (data == null) {
      final items = _itemStore.readAll();
      // Find the closest match in case of a partial uniqueName
      final results = items.where(
        (i) => (i['uniqueName'] as String).contains(uniqueName.split('/').last.replaceAll(' ', '')),
      );
      final closesMatch = results.firstOrNull;

      return closesMatch != null ? WarframeItem.fromDatabase(Map<String, dynamic>.from(closesMatch)) : null;
    }

    return WarframeItem.fromDatabase(Map<String, dynamic>.from(data));
  }

  Future<Item?> fetchItemFApi(String uniqueName) async {
    final cached = await _cache.get<Map<String, dynamic>>(uniqueName);
    if (cached != null) return Isolate.run(() => toItem(cached));

    final item = await _client.fetchItem(uniqueName);
    if (item == null) return null;

    await _cache.set(uniqueName, item.toJson(), ttl: _itemUpdateInterval);
    return item;
  }

  Future<WarframeItem?> fetchFStorByName(String name) async {
    final items = await search(name.replaceAll('Blueprint', '').trim());
    return items.firstWhereOrNull((item) => item.name == name);
  }

  Future<List<WarframeItem>> search(String query) async {
    try {
      final stored = _itemStore.readAll();
      final resuls = stored
          .where((i) => (i['name'] as String).toLowerCase().contains(query.toLowerCase()))
          .map((i) => WarframeItem.fromDatabase(Map<String, dynamic>.from(i)));

      if (resuls.isNotEmpty) return resuls.toList(growable: false)..prioritizeResults();

      final items = await _client.searchRaw(query, props: WarframeItem.requiredProps);
      return items.map(WarframeItem.fromApi).toList(growable: false)..prioritizeResults();
    } on Exception {
      return [];
    }
  }

  Future<WarframeItem?> searchIncarnon(String name) async {
    final incarnons = await search('Incarnon');
    final normalizeName = name.replaceAll(RegExp('and', caseSensitive: false), '&');

    return incarnons.firstWhereOrNull((i) => i.name.contains(normalizeName));
  }

  Future<List<WarframeItem>> searchMasterable(String name) async {
    final results = await search(name);
    return results.where((i) => i.isMasterable).toList(growable: false);
  }

  Future<void> updateItems(String buildLabel, {ItemUpdateProgress? onProgress, bool forceUpdate = false}) async {
    const key = 'buildStoreLabel';
    final lastRun = await _cache.get<Map<String, dynamic>>(key);

    if (!forceUpdate) {
      final timestamp = lastRun?['timestamp'] as String?;
      final labelChanged = lastRun?['label'] != buildLabel;
      final lapsed =
          timestamp == null || DateTime.timestamp().difference(DateTime.parse(timestamp)) > _itemUpdateInterval;

      if (!labelChanged || !lapsed) return;
    }

    final items = await _client.fetchAllItemsRaw(WarframeItem.requiredProps);
    final mapped = {for (final item in items) item['uniqueName'] as String: item};

    final timestamp = DateTime.timestamp().toIso8601String();
    if (forceUpdate) {
      await _cache.set(key, {'label': lastRun?['label'], 'timestamp': timestamp});
    } else {
      await _cache.set(key, {'label': buildLabel, 'timestamp': timestamp});
    }

    if (onProgress != null) {
      for (var i = 0; i < items.length; i++) {
        onProgress(i / items.length, items.length);
        final item = items[i];
        await _itemStore.write(item['uniqueName'] as String, WarframeItem.fromApi(item).toJson());
      }
    } else {
      await _itemStore.writeAll(mapped);
    }

    return;
  }
}
