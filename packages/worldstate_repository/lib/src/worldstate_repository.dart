import 'dart:convert';
import 'dart:isolate';

import 'package:arbi_api/arbi_api.dart';
import 'package:cache/cache.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:worldstate_repository/src/utils/utils.dart';

const _worldstateCacheKey = 'worldstate';
const _arbitrationCacheKey = 'arbitration';
const _refreshTime = Duration(minutes: 3);
const arbitrationActiveTime = Duration(hours: 1, seconds: 60);

/// {@template worldstate_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WorldstateRepository {
  /// {@macro worldstate_repository}
  WorldstateRepository(this._cache, this._api, this._arbiApi);

  final CacheManager _cache;
  final WarframeApi _api;
  final ArbiApi _arbiApi;

  Stream<Worldstate> worldstateEmitter(String locale) async* {
    yield* Stream.periodic(_refreshTime, (_) => buildWorldstate(locale)).asyncMap((f) => f);
  }

  Future<Worldstate> buildWorldstate(String locale) async {
    final key = '$_worldstateCacheKey}_$locale';
    final cached = await _cache.get<Map<String, dynamic>>(key);
    if (cached != null) return await Isolate.run(() => Worldstate.fromMap(cached));

    final data = await _api.fetchWorldstateBytes();
    final arby = await _fetchArbitration(locale);

    final worldstate = await Isolate.run(() {
      final json = utf8.decoder.fuse(const JsonDecoder()).convert(data)! as Map<String, dynamic>;
      final raw = RawWorldstate.fromMap(json);
      final deps = Dependency(locale: WorldstateDataLocale.values.byName(locale));
      var worldstate = raw.toWorldstate(deps);
      if (arby != null) {
        worldstate = worldstate.copyWith(arbitration: Arbitration.fromWF(arby, deps));
      }

      return worldstate..clean();
    });

    await _cache.set(key, worldstate.toMap(), ttl: _refreshTime);

    return worldstate;
  }

  Future<Map<String, dynamic>?> _fetchArbitration(String locale) async {
    final timestamp = DateTime.timestamp();
    final activeKey = '${_arbitrationCacheKey}_${locale}_active';

    bool isActive(String activation, String expiry) {
      final start = DateTime.parse(activation);
      final end = DateTime.parse(expiry);
      return timestamp.isAfter(start) && timestamp.isBefore(end) || timestamp.isAtSameMomentAs(start);
    }

    final current = await _cache.get<Map<String, dynamic>>(activeKey);
    if (current != null) {
      final active = isActive(current['activation'] as String, current['expiry'] as String);
      if (active) return current;
    }

    final cached = await _cache.get<List<dynamic>>('${_arbitrationCacheKey}_$locale');
    if (cached != null) {
      for (final j in List<Map<String, dynamic>>.from(cached)) {
        final active = isActive(j['activation'] as String, j['expiry'] as String);
        if (active) {
          await _cache.set(activeKey, j);
          return j;
        }
      }
    }

    return null;
  }

  Future<void> buildArbitrationCache(String locale) async {
    final key = '${_arbitrationCacheKey}_$locale';
    final cached = await _cache.get<List<dynamic>>(key);
    if (cached != null) return;

    final lang = WorldstateDataLocale.values.byName(locale);
    final raw = await _arbiApi.fetchArbis();
    final arbis = _parseArbitrations(raw, lang);
    await _cache.set(key, arbis.toList(), ttl: const Duration(days: 365));
  }

  Iterable<Map<String, dynamic>> _parseArbitrations(String csv, [WorldstateDataLocale locale = .en]) sync* {
    final timestamp = DateTime.timestamp();
    final lines = const LineSplitter().convert(csv);

    for (final line in lines) {
      final [seconds, key] = line.split(',');
      final activation = DateTime.fromMillisecondsSinceEpoch(int.parse(seconds) * 1000);
      final expiry = activation.add(arbitrationActiveTime);

      if (timestamp.isAfter(expiry)) continue;

      yield {'activation': activation.toIso8601String(), 'expiry': expiry.toIso8601String(), 'key': key};
    }
  }
}
