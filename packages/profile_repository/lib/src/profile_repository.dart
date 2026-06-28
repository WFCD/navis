import 'dart:isolate';

import 'package:cache/cache.dart';
import 'package:profile_repository/src/utils/masterable_item.dart';
import 'package:storage/storage.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';

const _cacheKey = 'profile';
const _refreshTime = Duration(minutes: 60);

/// {@template profile_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ProfileRepository {
  /// {@macro profile_repository}
  const ProfileRepository(this._api, this._cache, this._db);

  final WarframeApi _api;
  final CacheManager _cache;
  final Storage<Map<dynamic, dynamic>> _db;

  Future<Profile> fetchProfile(String id) async {
    final cache = await _cache.get<Map<String, dynamic>>(_cacheKey);
    if (cache != null) {
      final profile = await Isolate.run(() => Profile.fromMap(cache));
      if (profile.id == id) return profile;
    }

    final data = await _api.fetchProfile(id);
    final profile = await Isolate.run(() => Profile.fromMap(data));
    await _cache.set(_cacheKey, profile, ttl: _refreshTime);

    return profile;
  }

  Future<List<MasterableItem>> buildXpInfo() async {
    final cache = await _cache.get<Map<String, dynamic>>(_cacheKey);
    if (cache == null) return [];

    final profile = await Isolate.run(() => Profile.fromMap(cache));
    final items = _createLookup(List<Map<String, dynamic>>.from(_db.readAll()));
    final info = profile.loadout.xpInfo.map((i) => MasterableItem(item: items[i.uniqueName]!, xp: i.xp)).toList();
    _fixSiriusOrion(info);

    return info;
  }

  Map<String, WarframeItem> _createLookup(List<Map<String, dynamic>> items) {
    final entries = items.map((i) {
      final item = WarframeItem.fromDatabase(i);
      return MapEntry(item.uniqueName, item);
    });

    return Map.fromEntries(entries);
  }

  // Syncs Sirius & Orion powersuit entiries
  void _fixSiriusOrion(List<MasterableItem> items) {
    final siriusOrion = items.where((i) => i.item.uniqueName.contains('SiriusOrion'));
    // One will always be 0
    final largestXp = siriusOrion.map((i) => i.xp).reduce((value, i) => value + i);

    for (final f in siriusOrion) {
      items[items.indexOf(f)] = MasterableItem(item: f.item, xp: largestXp);
    }
  }
}
