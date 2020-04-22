import 'package:hive/hive.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/src/base/local/warframestate_local_base.dart';
import 'package:wfcd_client/src/exceptions/exceptions.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

class WarframestatCache implements WarframestateCacheBase {
  WarframestatCache(this._box);

  final Box<dynamic> _box;

  static const String _dealId = 'dealId';
  static const String _dealItem = 'dealItem';
  static const String _state = 'worldstate';
  static const String _targets = 'synthTargets';

  @override
  void cacheDealInfo(String id, BaseItem item) {
    _box.put(_dealId, id);
    _box.put(_dealItem, item.toJson());
  }

  @override
  void cacheSynthTargets(List<SynthTarget> targets) {
    _box.put(_targets, targets.map((t) => t as SynthTargetModel));
  }

  @override
  void cacheWorldstate(Worldstate state) {
    _box.put(_state, (state as WorldstateModel).toJson());
  }

  @override
  BaseItem getCachedDeal() => readDisk<BaseItem>(_dealItem);

  @override
  Worldstate getCachedState() => readDisk<WorldstateModel>(_state);

  @override
  List<SynthTarget> getCachedTargets() => readDisk<List<SynthTarget>>(_targets);

  T readDisk<T>(String key) {
    final cache = _box.get(key) as T;

    if (cache == null) throw NotCachedException();

    return cache;
  }
}
