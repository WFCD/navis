import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

const Worldstate_Key = 'worldstate';
const DarvoDeal_ID = 'darvo_id';
const DarvoDeal_Key = 'darvo';
const SynthTargets_Key = 'targets';
const SynthTargets_Timestamp = 'target_timestamp';

class WarframestatCache implements WarframestateCacheBase {
  WarframestatCache._(this.box);

  final Box<String> box;

  static WarframestatCache _instance;

  DateTime get synthTargetLastUpdate {
    String timestamp = box.get(SynthTargets_Timestamp);
    timestamp ??= DateTime.now().toIso8601String();

    return DateTime.parse(timestamp);
  }

  @override
  void cacheDealInfo(String id, BaseItem item) {
    box.put(DarvoDeal_ID, id);
    box.put(DarvoDeal_Key, json.encode(item.toJson()));
  }

  String getCachedDealId() {
    final id = box.get(DarvoDeal_ID);

    if (id != null) return id;

    return null;
  }

  @override
  void cacheSynthTargets(List<SynthTarget> targets) {
    final models = targets.map((t) => (t as SynthTargetModel).toJson());

    try {
      box.put(SynthTargets_Timestamp, DateTime.now().toIso8601String());
      box.put(SynthTargets_Key, json.encode(models.toList()));
    } catch (error) {
      logError(error.toString());
      rethrow;
    }
  }

  @override
  void cacheWorldstate(Worldstate worldstate) {
    final model = worldstate as WorldstateModel;

    box.put(Worldstate_Key, json.encode(model)).catchError((Object error) {
      logError(error.toString());
    });
  }

  @override
  BaseItem getCachedDeal() {
    final instance = box.get(DarvoDeal_Key);

    return BaseItem.fromJson(json.decode(instance) as Map<String, dynamic>);
  }

  @override
  Future<Worldstate> getCachedState() async {
    final cached = box.get(Worldstate_Key);

    if (cached != null) {
      return compute<String, Worldstate>(toWorldstate, cached)
          .catchError((Object error) => logError);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<SynthTarget>> getCachedTargets() async {
    final cached = box.get(SynthTargets_Key);

    if (cached != null) {
      return compute<String, List<SynthTarget>>(toTargets, cached)
          .catchError((Object error) => logError(error));
    } else {
      throw CacheException();
    }
  }

  static Future<WarframestatCache> getInstance() async {
    if (_instance == null) {
      final temp = await getTemporaryDirectory();

      Hive.init(temp.path);

      final box = await Hive.openBox<String>('cached_warframestat');

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

  Future<Worldstate> getCachedState();

  Future<List<SynthTarget>> getCachedTargets();
}
