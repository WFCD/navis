import 'dart:convert';
import 'dart:isolate';

import 'package:arbi_api/arbi_api.dart';
import 'package:cache/cache.dart';
import 'package:crypto/crypto.dart';
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
    if (cached != null) return Isolate.run(() => Worldstate.fromMap(cached));

    final data = await _api.fetchWorldstateBytes();
    final worldstate = await Isolate.run(() {
      final json = utf8.decoder.fuse(const JsonDecoder()).convert(data)! as Map<String, dynamic>;
      final raw = RawWorldstate.fromMap(json);
      final deps = Dependency(locale: WorldstateDataLocale.values.byName(locale));

      return raw.toWorldstate(deps)..clean();
    });

    await _cache.set(key, worldstate.toMap(), ttl: _refreshTime);

    return worldstate;
  }

  // ignore: experimental_member_use Its in a controlled environment
  Future<Arbitration> fetchArbitration(String locale) async {
    final cached = await _cache.get<List<dynamic>>('${_arbitrationCacheKey}_$locale');
    if (cached != null) {
      return Isolate.run(() {
        // ignore: experimental_member_use Its in a controlled environment
        final arbis = List<Map<String, dynamic>>.from(cached).map(Arbitration.fromJson).toList();
        return arbis.current;
      });
    }

    final lang = WorldstateDataLocale.values.byName(locale);
    final timestamp = DateTime.timestamp();
    final raw = await _arbiApi.fetchArbis();
    final arbis = _parseArbitrations(raw, lang);
    final ttl = timestamp.difference(arbis.last.expiry);
    await _cache.set(_arbitrationCacheKey, arbis.map((i) => i.toJson()).toList(), ttl: ttl);

    return arbis.firstWhere((i) => timestamp.isAfter(i.activation) && timestamp.isBefore(i.expiry));
  }

  // ignore: experimental_member_use Its in a controlled environment
  Iterable<Arbitration> _parseArbitrations(String csv, [WorldstateDataLocale locale = .en]) sync* {
    final timestamp = DateTime.timestamp();
    final nodes = solNodes(locale);
    final lines = const LineSplitter().convert(csv);

    for (final line in lines) {
      final [seconds, key] = line.split(',');
      final activation = DateTime.fromMillisecondsSinceEpoch(int.parse(seconds) * 1000);
      final expiry = activation.add(arbitrationActiveTime);

      if (timestamp.isAfter(expiry)) continue;

      final node = nodes.fetchNode(key);
      // ignore: experimental_member_use See above
      yield Arbitration(
        id: md5.convert(utf8.encode(line)).toString(),
        activation: activation,
        expiry: expiry,
        node: node.name,
        nodeKey: key,
        enemy: node.enemy,
        type: node.type ?? key,
        typeKey: key,
        archwing: false,
        sharkwing: false,
        expired: timestamp.isAfter(expiry),
      );
    }
  }
}
