import 'dart:isolate';

import 'package:cache/cache.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:worldstate_models/worldstate_models.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
// const _profileApi = 'https://api.warframe.com/cdn/getProfileViewingData.php';
const __dropDataRefreshTime = Duration(days: DateTime.daysPerWeek * DateTime.monthsPerYear);

/// How longe before the worldstate is considered expired
const worldstateRefreshTime = Duration(seconds: Duration.secondsPerMinute);

/// {@template warframe_repository}
/// Repository to interact and transform data straight from DE
/// {@endtemplate}
class WarframeRepository {
  /// {@macro warframe_repository}
  const WarframeRepository({required Client client, required CacheManager manager})
    : _client = client,
      _cacheManager = manager;

  final Client _client;
  final CacheManager _cacheManager;

  /// Fetches and parses a worldstate
  Future<Worldstate> fetchWorldstate([String locale = 'en']) async {
    const key = 'worldstate';
    final data = await _cacheManager.get<Map<String, dynamic>>(key);
    if (data != null) return Worldstate.fromMap(data);

    final syndicateBountyTables = await fetchSyndicateRewards();
    final raw = await _fetchRawWorldstate();
    final worldstate = await Isolate.run(() => raw.toWorldstate(Dependency(syndicateBountyTables)));
    // ignore: avoid_redundant_argument_values Keep in case we need to increase the time later on
    await _cacheManager.set('worldstate', worldstate.toMap(), ttl: worldstateRefreshTime);

    return worldstate;
  }

  /// Emits a worldstate every 3 mins
  Stream<Worldstate> worldstateEmitter({String locale = 'en', @visibleForTesting Duration? tick}) async* {
    yield* Stream<Future<Worldstate>>.periodic(
      tick ?? worldstateRefreshTime,
      (_) async => fetchWorldstate(locale),
    ).asyncMap((future) async => future);
  }

  /// Builds a drap data instance
  Future<List<BountyRewardTable>> fetchSyndicateRewards() async {
    final buildLabel = (await _fetchRawWorldstate()).buildLabel;
    final data = await _cacheManager.get<List<dynamic>>(buildLabel);
    if (data != null) return List<Map<String, dynamic>>.from(data).map(BountyRewardTable.fromMap).toList();

    final dropData = await fetchWarframeDropData(_client);
    final bountyTables = await Isolate.run(
      () => Syndicates.values.map((v) => parseBountyRewardTables(dropData, v)).nonNulls.flattenedToList,
    );
    await _cacheManager.set(buildLabel, bountyTables.map((t) => t.toMap()).toList(), ttl: __dropDataRefreshTime);

    return bountyTables;
  }

  Future<RawWorldstate> _fetchRawWorldstate() async {
    const key = '_raw';
    final data = await _cacheManager.get<String>(key);
    if (data != null) return RawWorldstate.fromJson(data);

    final res = await _client.get(Uri.parse(_worldstateApi));
    // ignore: avoid_redundant_argument_values Keep in case we need to increase the time later on
    await _cacheManager.set(key, res.body, ttl: worldstateRefreshTime);

    return RawWorldstate.fromJson(res.body);
  }
}
