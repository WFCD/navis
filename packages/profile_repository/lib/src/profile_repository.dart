import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:cache/cache.dart';
import 'package:profile_repository/src/utils/masterable_item.dart';
import 'package:storage/storage.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';

const _cacheKey = 'profile';
const _refreshTime = Duration(minutes: 60);
const _overrides = <String>['Excalibur Prime', 'Lato Prime', 'Skana Prime'];

typedef XpInfo = ({Map<String, MasterableItem> lookup, List<MasterableItem> list});

/// {@template profile_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ProfileRepository {
  /// {@macro profile_repository}
  const ProfileRepository(this._api, this._cache, this._itemStore);

  final WarframeApi _api;
  final CacheManager _cache;
  final Storage<Map<dynamic, dynamic>> _itemStore;

  Future<Profile> fetchProfile(String input) async {
    final userData = json.decode(input) as Map<String, dynamic>;
    if (!userData.containsKey('user_id')) throw const FormatException('Missing user id');

    final cache = await _cache.get<Map<String, dynamic>>(_cacheKey);
    if (cache != null) {
      final profile = await Isolate.run(() => Profile.fromMap(cache));
      if (profile.id == userData['user_id']) return profile;
    }

    final data = await _api.fetchProfile(userData['id'] as String);
    final profile = await Isolate.run(() => Profile.fromMap(data));
    await _cache.set(_cacheKey, profile, ttl: _refreshTime);

    return profile;
  }

  Future<XpInfo> buildXpInfo() async {
    final cache = await _cache.get<Map<String, dynamic>>(_cacheKey);
    if (cache == null) return (lookup: <String, MasterableItem>{}, list: <MasterableItem>[]);

    final profile = await Isolate.run(() => Profile.fromMap(cache));
    final items = List<Map<String, dynamic>>.from(_itemStore.readAll());
    final xpLookup = {for (final xpItem in profile.loadout.xpInfo) xpItem.uniqueName: xpItem.xp};
    final info = <MasterableItem>[];

    int? siriusOrionXp;
    for (final i in items) {
      final item = WarframeItem.fromDatabase(i);
      final xp = xpLookup[item.uniqueName] ?? 0;

      // These get removed from the xp info so players aren't nagged about unobtainable items
      if (_overrides.contains(item.name)) continue;

      // Syncs Sirius' & Orion's rank
      if (item.uniqueName.contains('SiriusOrion')) {
        siriusOrionXp ??= xp;
        info.add(MasterableItem(item: item, xp: max(xp, siriusOrionXp)));
      }

      info.add(MasterableItem(item: item, xp: xp));
    }

    info.sort((a, b) => a.xp.compareTo(b.xp));
    return (lookup: {for (final i in info) i.item.uniqueName: i}, list: info);
  }

  bool validateUserData(String input) {
    final userData = json.decode(input) as Map<String, dynamic>;
    return userData.containsKey('user_id');
  }
}
