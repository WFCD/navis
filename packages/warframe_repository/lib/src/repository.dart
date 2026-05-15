import 'dart:convert';
import 'dart:isolate';

import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_repository/src/user_data.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:worldstate_models/worldstate_models.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
const _profileApi = 'https://api.warframe.com/cdn/getProfileViewingData.php';

const __dropDataRefreshTime = Duration(days: DateTime.daysPerWeek * DateTime.monthsPerYear);

/// How longe before the worldstate is considered expired
const worldstateRefreshTime = Duration(seconds: Duration.secondsPerMinute * 3);

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
  Future<Worldstate> fetchWorldstate([WorldstateDataLocale locale = .en]) async {
    const key = 'worldstate';
    final data = await _cacheManager.get<Map<String, dynamic>>(key);
    if (data != null) return Worldstate.fromMap(data);

    final dropData = await buildWorldstateDropData();
    final raw = await _fetchRawWorldstate();
    final worldstate = await Isolate.run(() => raw.toWorldstate(Dependency(locale: locale, dropData: dropData)));

    await _cacheManager.set('worldstate', worldstate.toMap(), ttl: worldstateRefreshTime);

    return worldstate;
  }

  /// Emits a worldstate every 3 mins
  Stream<Worldstate> worldstateEmitter({WorldstateDataLocale locale = .en, @visibleForTesting Duration? tick}) async* {
    yield* Stream<Future<Worldstate>>.periodic(
      tick ?? worldstateRefreshTime,
      (_) async => fetchWorldstate(locale),
    ).asyncMap((future) async => future);
  }

  // At some point this will just build out all the data and added to the explorer page
  /// Builds and caches both bounty reward tables and mission reward tables
  Future<DropData> buildWorldstateDropData() async {
    final buildLabel = (await _fetchRawWorldstate()).buildLabel;
    final dropData = await _cacheManager.get<Map<String, dynamic>>('drop_data_$buildLabel');
    if (dropData != null) {
      return Isolate.run(() => DropData.fromMap(dropData));
    }

    final res = await _client.get(Uri.parse(warframeDropDataPage));
    final raw = res.bodyBytes;
    final data = await Isolate.run(() async {
      final html = await Isolate.run(() => parse(raw, encoding: 'urf-8'));
      return buildDropData(html.body!);
    });

    await _cacheManager.set('drop_data_$buildLabel', await Isolate.run(data.toMap), ttl: __dropDataRefreshTime);

    return data;
  }

  /// Self explanatory
  UserData convertUserData(String json) {
    final sanitized = const LineSplitter().convert(json).join();
    final data = jsonDecode(sanitized) as Map<String, dynamic>;

    return UserData.fromJson(data);
  }

  /// Get a copy of a user's data
  Future<Profile> fetchProfile(String id) async {
    const key = 'profile';
    final data = await _cacheManager.get<Map<String, dynamic>>(key);
    if (data != null) return Profile.fromMap(data);

    final res = await _client.get(Uri.parse('$_profileApi?playerId=$id'));
    final body = res.body; // Can't pass Response into isolate... yay
    final profile = await Isolate.run(() {
      final json = jsonDecode(body) as Map<String, dynamic>;
      return RawProfile.fromMap((json['Results'] as List<dynamic>).first as Map<String, dynamic>).toProfile();
    });

    await _cacheManager.set(key, profile.toMap(), ttl: const Duration(minutes: 60));

    return profile;
  }

  Future<RawWorldstate> _fetchRawWorldstate() async {
    final res = await _client.get(Uri.parse(_worldstateApi));
    return RawWorldstate.fromJson(res.body);
  }
}
