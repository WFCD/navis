import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:cache/src/models/cached_data.dart';
import 'package:storage/storage.dart';

/// {@template cache}
/// A cache manager for storing Map data.
/// {@endtemplate}
class CacheManager {
  /// {@macro cache}
  const CacheManager(this._storage);

  final Storage<Map<dynamic, dynamic>> _storage;

  /// Get the given data stored under [key]
  Future<T>? get<T>(String key) {
    final data = _storage.read(key);
    final cached = data != null ? CachedData.fromJson(Map<String, dynamic>.from(data)) : null;
    if (cached == null || cached.isExpired) return null;

    return Isolate.run(() => json.decode(cached.data) as T);
  }

  /// Store [data] under [key] with an optional [ttl]
  ///
  /// The default [ttl] is 60 seconds if non is given
  Future<void> set(String key, Object data, {Duration ttl = const Duration(seconds: 60)}) async {
    final encoded = await Isolate.run(() => json.encode(data));
    await _storage.write(key, CachedData(data: encoded, ttl: ttl).toJson());
  }

  Future<void> clean() async {
    final toRemove = <dynamic>[];
    final cached = _storage.readAll();
    for (final cache in cached) {
      final data = CachedData.fromJson(cache as Map<String, dynamic>);
      if (data.isExpired) continue;
      toRemove.add(cache);
    }

    await _storage.deleteAll(toRemove);
  }
}
