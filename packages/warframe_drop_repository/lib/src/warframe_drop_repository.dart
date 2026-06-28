import 'dart:isolate';

import 'package:cache/cache.dart';
import 'package:html/parser.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';

const _cacheKey = 'drops';
const _dropDataRefresh = Duration(days: 30);

/// {@template warframe_drop_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WarframeDropRepository {
  /// {@macro warframe_drop_repository}
  WarframeDropRepository(this._api, this._cache);

  final CacheManager _cache;
  final WarframeApi _api;

  Future<DropData> buildDrops(String buildLabel) async {
    final key = '${_cacheKey}_$buildLabel';
    final cached = await _cache.get<Map<String, dynamic>>(key);
    if (cached != null) return Isolate.run(() => DropData.fromMap(cached));

    final page = await _api.fetchDropData();
    final data = await Isolate.run(() {
      final html = parse(page, encoding: 'utf-8');
      return buildDropData(html.body!);
    });

    await _cache.set(key, data.toMap(), ttl: _dropDataRefresh);

    return data;
  }

  Future<DropData> parseData(String page) async {
    return Isolate.run(() {
      final html = parse(page, encoding: 'utf-8');
      return buildDropData(html.body!);
    });
  }
}
