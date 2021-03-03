import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';

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

  void cacheDealInfo(String id, Item item) {
    _box..put(_dealId, id)..put(id, json.encode(fromBaseItem(item)));
  }

  void cacheSynthTargets(List<SynthTarget> targets) {
    _box.put(_targets, targets.map((t) => (t as SynthTargetModel).toJson()));
  }

  void cacheWorldstate(Worldstate state) {
    _box.put(_state, json.encode((state as WorldstateModel).toJson()));
  }

  String getCachedDealId() => readDisk<String>(_dealId);

  Item getCachedDeal(String id) {
    final cached = readDisk<String>(id);

    return toBaseItem(json.decode(cached) as Map<String, dynamic>);
  }

  Worldstate getCachedState() {
    final cached = readDisk<String>(_state);

    if (cached != null) {
      return WorldstateModel.fromJson(
          json.decode(cached) as Map<String, dynamic>);
    }

    return null;
  }

  List<SynthTarget> getCachedTargets() {
    final cached = readDisk<Iterable<Map<String, dynamic>>>(_targets);

    return cached?.map((t) => SynthTargetModel.fromJson(t))?.toList();
  }

  T readDisk<T>(String key) {
    final cache = _box.get(key) as T;

    if (cache == null) return null;

    return cache;
  }
}
