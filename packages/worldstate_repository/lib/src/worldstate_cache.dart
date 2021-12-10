import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';

/// {@template warframestate_cache}
/// [WarframestatCache] acts is used to cache responses from
// ignore: comment_references
/// [WorldstateRepository].
///
/// Hive is used as the underline caching system.
/// {@endtemplate}
class WarframestatCache {
  /// {@macro warframestate_cache}
  const WarframestatCache._(this._box);

  final Box<dynamic> _box;

  static WarframestatCache? _instance;

  /// This opens up an instance of [Box] in order to store information
  ///
  /// Use the optional [path] to change the temp directory.
  ///
  /// Because we use this in Navis as a cache and is stored in the app temp
  /// directory, [Hive.init()] would have already been called before the box
  /// was open. [path] will really only ever be used for
  /// testing and/or for caching.
  static Future<WarframestatCache> initCache(
    String path, [
    Box<dynamic>? testBox,
  ]) async {
    const kBoxName = 'worldstate_cache';

    log('Initializing WarframestatCache Hive');

    final box = testBox ?? await Hive.openBox<dynamic>(kBoxName, path: path);
    return _instance ??= WarframestatCache._(box);
  }

  /// The Hive key where the deal id and information are stored
  static const String dealIdKey = 'dealId';

  /// The Hive key where the worldstate is stored.
  static const String worldstateKey = 'worldstate';

  /// The Hive key where the timestamp for the worldstate is stored.
  static const String worldstateTimestampKey = 'worldstateTimestamp';

  /// The Hive key where synthTargets are stored.
  static const String synthTargetsKey = 'synthTargets';

  /// Caches [Item] information about a deal.
  ///
  /// The deal ID is stored separately  for easier comparing.
  void cacheDealInfo(String id, Item item) {
    _box
      ..put(dealIdKey, id)
      ..put(id, json.encode(fromBaseItem(item)));
  }

  /// Caches a list of [SynthTarget]s.
  void cacheSynthTargets(List<SynthTarget> targets) {
    _box.put(
      synthTargetsKey,
      targets.map((t) => (t as SynthTargetModel).toJson()).toList(),
    );
  }

  /// Caches a worldstate.
  ///
  /// [Worldstate.timestamp] is cached separately for easier comparing
  void cacheWorldstate(Worldstate state) {
    final model = WorldstateModel.fromWorldstate(state);

    _box
      ..put(worldstateTimestampKey, state.timestamp)
      ..put(worldstateKey, json.encode(model.toJson()));
  }

  /// Get the stored deal ID.
  String? getCachedDealId() => _readDisk<String>(dealIdKey);

  /// Get the stored [Item] for a daily deal.
  Item? getCachedDeal(String id) {
    final cached = _readDisk<String>(id);

    if (cached == null) return null;

    return toBaseItem(json.decode(cached) as Map<String, dynamic>);
  }

  /// Get the timestamp for a stored [Worldstate].
  DateTime? getCachedStateTimestamp() {
    return _readDisk<DateTime>(worldstateTimestampKey);
  }

  /// Get the stored [Worldstate].
  Worldstate? getCachedState() {
    final cached = _readDisk<String>(worldstateKey);

    if (cached != null) {
      return WorldstateModel.fromJson(
        json.decode(cached) as Map<String, dynamic>,
      );
    }

    return null;
  }

  /// Get a list of stored [SynthTarget]s.
  List<SynthTarget>? getCachedTargets() {
    final cached = _readDisk<List<dynamic>>(synthTargetsKey);

    return cached
        ?.map((dynamic t) {
          return Map<String, dynamic>.from(t as Map<dynamic, dynamic>);
        })
        .map((e) => SynthTargetModel.fromJson(e))
        .toList();
  }

  T? _readDisk<T>(String key) {
    final cache = _box.get(key) as T?;

    if (cache == null) return null;

    return cache;
  }
}
