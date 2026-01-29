import 'dart:convert';
import 'dart:isolate';

import 'package:hive_ce/hive.dart';
import 'package:meta/meta.dart';
import 'package:navis_cache/hive/hive_adapters.dart';
import 'package:navis_cache/src/models/cached_data.dart';

/// {@template cache}
/// A cache manager for storing Map data.
/// {@endtemplate}
class CacheManager {
  /// {@macro cache}
  const CacheManager._({required this.name, required Box<CachedData> box}) : _box = box;

  /// Box name
  final String name;
  final Box<CachedData> _box;

  /// Creates a new cache manager using Hive as the backend
  static Future<CacheManager> open(String path, {String name = 'temp'}) async {
    Hive.init(path);
    if (!Hive.isAdapterRegistered(CachedDataAdapter().typeId)) Hive.registerAdapter(CachedDataAdapter());

    final box = await Hive.openBox<CachedData>(name);

    return CacheManager._(name: name, box: box);
  }

  /// Get the given data stored under [key]
  Future<T>? get<T>(String key) {
    final cached = _box.get(key);
    if (cached == null || cached.isExpired) return null;

    return Isolate.run(() => json.decode(cached.data) as T);
  }

  /// Store [data] under [key] with an optional [ttl]
  ///
  /// The default [ttl] is 60 seconds if non is given
  Future<void> set(String key, Object data, {Duration ttl = const Duration(seconds: 60)}) async {
    final encoded = await Isolate.run(() => json.encode(data));
    await _box.put(key, CachedData.create(encoded, ttl: ttl));
  }

  /// Closes the internal box
  @visibleForTesting
  Future<void> close() => _box.close();
}
