import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WarframestateCacheBase {
  Worldstate getCachedState();

  Future<void> cacheWorldstate(Worldstate state);

  List<SynthTarget> getCachedTargets();

  Future<void> cacheSynthTargets(List<SynthTarget> targets);
}

class WarframestatCache implements WarframestateCacheBase {
  final Box cacheBox;

  WarframestatCache(this.cacheBox);

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

    try {
      await cacheBox.put(Synth_Last_Update, timestamp);
      await cacheBox.put(SynthTargets_Key, targets.map((t) => t.toJson()));
    } catch (err) {
      logError('Fail to Cache SynthTargets: ${err.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> cacheWorldstate(Worldstate worldstate) async {
    await cacheBox
        .put(Worldstate_Key, json.encode(worldstate.toJson()))
        .catchError((Object error) {
      logError('Failed to cache worldstate: ${error.toString()}');
    });
  }

  @override
  Worldstate getCachedState() {
    final cached = cacheBox.get(Worldstate_Key) as String;

    if (cached != null) {
      return Worldstate.fromJson(json.decode(cached) as Map<String, dynamic>);
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
