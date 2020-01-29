import 'package:hive/hive.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WfcdCacheDataSource {
  Worldstate getCachedState();

  Future<void> cacheWorldstate(Worldstate state);

  List<SynthTarget> getCachedTargets();

  Future<void> cacheSynthTargets(List<SynthTarget> targets);
}

class WfcdCacheSource implements WfcdCacheDataSource {
  final Box cacheBox;

  WfcdCacheSource(this.cacheBox);

  static const Worldstate_Key = 'worldstate';
  static const SynthTargets_Key = 'synthTargets';
  static const Synth_Last_Update = 'synth_last_update';

  // static Future<void> init({Box testBox}) async {
  //   final temp = await getTemporaryDirectory();

  //   Hive.init(temp.path);

  //   if (testBox != null) {
  //     _box = testBox;
  //   }

  //   _box ??= await Hive.openBox<dynamic>('cached_data');

  //   return _instance ??= WorldstateCachedDataSource._();
  // }

  DateTime get synthTargetLastUpdate {
    final timestamp = cacheBox.get(Synth_Last_Update) as String;

    return DateTime.parse(timestamp);
  }

  @override
  Future<void> cacheSynthTargets(List<SynthTarget> targets) async {
    final timestamp = DateTime.now().toIso8601String();

    await cacheBox.put(Synth_Last_Update, timestamp);
    await cacheBox.put(SynthTargets_Key, targets.map((t) => t.toJson()));
  }

  @override
  Future<void> cacheWorldstate(Worldstate state) async {
    await cacheBox.put(Worldstate_Key, state.toJson());
  }

  @override
  Worldstate getCachedState() {
    final cached = cacheBox.get(Worldstate_Key) as Map<String, dynamic>;

    if (cached != null) {
      return Worldstate.fromJson(cached);
    } else {
      throw CacheException();
    }
  }

  @override
  List<SynthTarget> getCachedTargets() {
    final cached = cacheBox.get(SynthTargets_Key) as List<dynamic>;

    if (cached != null) {
      return cached
          .cast<Map<String, dynamic>>()
          .map<SynthTarget>((c) => SynthTarget.fromJson(c))
          .toList();
    } else {
      throw CacheException();
    }
  }
}
