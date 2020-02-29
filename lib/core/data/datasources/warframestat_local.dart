import 'package:hive/hive.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

const Worldstate_Key = 'worldstate';
const DarvoDeal_Key = 'darvo';
const SynthTargets_Key = 'targets';

class WarframestatCache implements WarframestateCacheBase {
  static WarframestatCache _instance;

  final Box<Map<String, dynamic>> box;
  WarframestatCache._(this.box);

  DateTime get synthTargetLastUpdate {
    final targets = box.get(SynthTargets_Key);

    return DateTime.parse(targets['timestamp'] as String);
  }

  @override
  void cacheDealInfo(String id, BaseItem item) {
    box.put(DarvoDeal_Key, <String, dynamic>{'id': id, 'item': item.toJson()});
  }

  String getCachedDealId() {
    final instance = box.get(DarvoDeal_Key);

    if (instance != null) return instance['id'] as String;

    return null;
  }

  @override
  void cacheSynthTargets(List<SynthTarget> targets) {
    final timestamp = DateTime.now().toIso8601String();

    try {
      box.put('targets', <String, dynamic>{
        'timestamp': timestamp,
        'synth_targets': targets.map((t) => t.toJson())
      });
    } catch (error) {
      logError(error.toString());
      rethrow;
    }
  }

  @override
  void cacheWorldstate(Worldstate worldstate) {
    box.put(Worldstate_Key, worldstate.toJson()).catchError((Object error) {
      logError(error.toString());
    });
  }

  @override
  BaseItem getCachedDeal() {
    final instance = box.get(DarvoDeal_Key);

    return BaseItem.fromJson(instance['item'] as Map<String, dynamic>);
  }

  @override
  Worldstate getCachedState() {
    final cached = box.get(Worldstate_Key);

    if (cached != null) {
      return Worldstate.fromJson(cached);
    } else {
      throw CacheException();
    }
  }

  @override
  List<SynthTarget> getCachedTargets() {
    final cached = box.get(SynthTargets_Key) as List<dynamic>;

    if (cached != null) {
      return cached
          .cast<Map<String, dynamic>>()
          .map<SynthTarget>((c) => SynthTarget.fromJson(c))
          .toList();
    } else {
      throw CacheException();
    }
  }

  static Future<WarframestatCache> getInstance() async {
    if (_instance == null) {
      final temp = await getTemporaryDirectory();

      Hive.init(temp.path);

      final box =
          await Hive.openBox<Map<String, dynamic>>('cached_warframestat');

      return _instance ??= WarframestatCache._(box);
    }

    return _instance;
  }
}

abstract class WarframestateCacheBase {
  void cacheDealInfo(String id, BaseItem item);

  void cacheSynthTargets(List<SynthTarget> targets);

  void cacheWorldstate(Worldstate state);

  BaseItem getCachedDeal();

  Worldstate getCachedState();

  List<SynthTarget> getCachedTargets();
}
