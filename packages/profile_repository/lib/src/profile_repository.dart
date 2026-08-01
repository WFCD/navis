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
const _siriusOrion = <String>['/Lotus/Powersuits/SiriusOrion/SiriusSuit', '/Lotus/Powersuits/SiriusOrion/OrionSuit'];

typedef XpInfo = ({Map<String, MasterableItem> lookup, List<MasterableItem> list});

/// {@template profile_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ProfileRepository {
  /// {@macro profile_repository}
  ProfileRepository(this._api, this._cache, this._itemStore);

  final WarframeApi _api;
  final CacheManager _cache;
  final Storage<Map<dynamic, dynamic>> _itemStore;

  XpInfo _xpInfo = (lookup: {}, list: []);

  XpInfo get xpInfo => _xpInfo;

  static bool validateUserData(String input) {
    try {
      final userData = json.decode(input) as Map<String, dynamic>;
      return userData.containsKey('user_id');
    } on FormatException {
      return false;
    }
  }

  Future<Profile> fetchProfile(WarframeSupportedPlatform platform, String input) async {
    final userData = json.decode(input) as Map<String, dynamic>;
    if (!userData.containsKey('user_id')) throw const FormatException('Missing user id');

    final cache = await _cache.get<Map<String, dynamic>>(_cacheKey);
    if (cache != null) {
      final profile = await Isolate.run(() => Profile.fromMap(cache));
      if (profile.id == userData['user_id']) return profile;
    }

    final data = await _api.fetchProfile(platform, userData['user_id'] as String);
    final results = List<Map<String, dynamic>>.from(data['Results'] as List<dynamic>);
    final profile = await Isolate.run(() => RawProfile.fromMap(results.first).toProfile());
    await _cache.set(_cacheKey, profile.toMap(), ttl: _refreshTime);

    // You have buildXPInfo to create full items so for memory sake there's no need for profile to have it as well
    return profile.copyWith(loadout: profile.loadout.copyWith(xpInfo: []));
  }

  Future<void> buildXpInfo() async {
    final cachedProfile = await _cache.get<Map<String, dynamic>>(_cacheKey);
    if (cachedProfile == null) return;

    final profile = await Isolate.run(() => Profile.fromMap(cachedProfile));
    final items = _itemStore.readAll();
    final xpLookup = {for (final xpItem in profile.loadout.xpInfo) xpItem.uniqueName: xpItem.xp};
    final info = <MasterableItem>[];

    for (final i in items) {
      final item = WarframeItem.fromDatabase(Map<String, dynamic>.from(i));
      if (!item.isMasterable) continue;

      final xp = xpLookup[item.uniqueName] ?? 0;

      // These get removed from the xp info so players aren't nagged about unobtainable items
      if (_overrides.contains(item.name)) continue;

      // Syncs Sirius' & Orion's rank
      if (item.uniqueName.contains('Powersuits/SiriusOrion')) {
        final temp = max(xpLookup[_siriusOrion.first] ?? 0, xpLookup[_siriusOrion.last] ?? 0);
        info.add(MasterableItem(item: item, xp: temp));
        continue;
      }

      info.add(MasterableItem(item: item, xp: xp));
    }

    info.sort((a, b) => a.xp.compareTo(b.xp));
    _xpInfo = (lookup: {for (final i in info) i.item.uniqueName: i}, list: info);
  }

  List<MasterableItem> searchXpInfo(String query) {
    return _xpInfo.list.where((i) => i.item.name.contains(query)).toList();
  }
}
