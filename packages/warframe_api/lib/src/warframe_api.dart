import 'dart:convert';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_api/src/models/user_data.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:worldstate_models/worldstate_models.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
const _profileApi = 'https://api.warframe.com/cdn/getProfileViewingData.php';

/// How longe before the worldstate is considered expired
const worldstateRefreshTime = Duration(seconds: Duration.secondsPerMinute * 3);

/// {@template warframe_api}
/// An API client to parse responses from Warframe's official endpoints
/// {@endtemplate}
class WarframeApi {
  /// {@macro warframe_api}
  WarframeApi([Client? client]) : _client = client ?? Client();

  final Client _client;

  /// Fetches and parses a worldstate
  Future<Worldstate> fetchWorldstate(
    List<BountyRewardTable> syndicateRewardTable, [
    WorldstateDataLocale locale = .en,
  ]) async {
    final raw = await fetchRawWorldstate();
    final worldstate = await Isolate.run(() => raw.toWorldstate(Dependency(syndicateRewardTable, locale)));

    return worldstate;
  }

  /// Builds a drap data instance
  Future<List<BountyRewardTable>> buildSyndicateRewardTable() async {
    final dropData = await fetchWarframeDropData(_client);
    final bountyTables = await Isolate.run(
      () => Syndicates.values.map((v) => parseBountyRewardTables(dropData, v)).nonNulls.flattenedToList,
    );

    return bountyTables;
  }

  /// Get a copy of a user's data
  Future<Profile> fetchProfile(String id) async {
    final res = await _client.get(Uri.parse('$_profileApi?playerId=$id'));
    final body = res.body; // Response itself can't be passed to the isolate
    final json = await Isolate.run(() => jsonDecode(body) as Map<String, dynamic>);
    final raw = RawProfile.fromMap((json['Results'] as List<dynamic>).first as Map<String, dynamic>);

    return Isolate.run(raw.toProfile);
  }

  /// Self explanatory
  UserData parseUserData(String json) {
    final sanitized = const LineSplitter().convert(json).join();
    final data = jsonDecode(sanitized) as Map<String, dynamic>;

    return UserData.fromJson(data);
  }

  /// Get the worldstate as is without extra parsing or localization
  Future<RawWorldstate> fetchRawWorldstate() async {
    final res = await _client.get(Uri.parse(_worldstateApi));

    return RawWorldstate.fromJson(res.body);
  }
}
