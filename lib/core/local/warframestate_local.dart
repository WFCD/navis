import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logging/logging.dart';

class WarframestatCache {
  WarframestatCache(this._box);

  final Box<dynamic> _box;

  static WarframestatCache _instance;

  static final _logger = Logger('WarframestatCache');

  static Future<WarframestatCache> initCache() async {
    _logger.info('Initializing WarframestatCache Hive');
    final temp = await getTemporaryDirectory();
    Hive.init(temp.path);

    final box = await Hive.openBox<dynamic>('worldstate_cache').catchError(
      (Object error, StackTrace stack) =>
          _logger.severe('Unable to open Hive box', error, stack),
    );

    return _instance ??= WarframestatCache(box);
  }

  static const String _dealId = 'dealId';
  static const String _state = 'worldstate';
  static const String _targets = 'synthTargets';

  void cacheDealInfo(String id, BaseItem item) {
    _box.put(_dealId, id);
    _box.put(id, json.encode(item.toJson()));
  }

  void cacheSynthTargets(List<SynthTarget> targets) {
    _box.put(_targets, targets.map((t) => (t as SynthTargetModel).toJson()));
  }

  void cacheWorldstate(Worldstate state) {
    _box.put(_state, (state as WorldstateModel).toJson());
  }

  String getCachedDealId() => readDisk<String>(_dealId);

  BaseItem getCachedDeal(String id) {
    final cached = readDisk<String>(id);

    return BaseItem.fromJson(json.decode(cached) as Map<String, dynamic>);
  }

  Worldstate getCachedState() {
    final cached = readDisk<Map<String, dynamic>>(_state);

    return WorldstateModel.fromJson(cached);
  }

  List<SynthTarget> getCachedTargets() {
    final cached = readDisk<Iterable<Map<String, dynamic>>>(_targets);

    return cached.map((t) => SynthTargetModel.fromJson(t)).toList();
  }

  T readDisk<T>(String key) {
    final cache = _box.get(key) as T;

    if (cache == null) return null;

    return cache;
  }
}
