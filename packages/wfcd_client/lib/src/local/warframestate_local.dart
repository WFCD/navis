import 'package:hive/hive.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/src/base/local/warframestate_local_base.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

class WarframestatCache implements WarframestateCacheBase {
  WarframestatCache(this._box);

  final Box<dynamic> _box;

  static const String _dealId = 'dealId';
  static const String _state = 'worldstate';
  static const String _targets = 'synthTargets';

  @override
  void cacheDealInfo(String id, BaseItem item) {
    _box.put(_dealId, id);
    _box.put(id, item.toString());
  }

  @override
  void cacheSynthTargets(List<SynthTarget> targets) {
    _box.put(_targets, targets.map((t) => (t as SynthTargetModel).toJson()));
  }

  @override
  void cacheWorldstate(Worldstate state) {
    _box.put(_state, (state as WorldstateModel).toJson());
  }

  @override
  String getCachedDealId() => readDisk<String>(_dealId);

  @override
  BaseItem getCachedDeal(String id) {
    final cached = readDisk<Map<String, dynamic>>(id);

    return BaseItem.fromJson(cached);
  }

  @override
  Worldstate getCachedState() {
    final cached = readDisk<Map<String, dynamic>>(_state);

    return WorldstateModel.fromJson(cached);
  }

  @override
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
