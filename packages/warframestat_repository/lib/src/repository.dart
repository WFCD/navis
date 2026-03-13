// ignore_for_file: experimental_member_use Its cool, I know what I'm doing

import 'dart:isolate';

import 'package:http/http.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Worldstate;
import 'package:warframestat_repository/src/models/regions.dart';
import 'package:warframestat_repository/src/utils/parse_arbi.dart';

///
const userAgent = 'navis';

typedef CraigRegion = ({List<CraigNode> nodes, List<CraigJunction> junctions});

/// {@template warframestat_repository}
/// Entry point for Warframestatus endpoints used in Cephalon Navis
/// {@endtemplate}
class WarframestatRepository {
  /// {@macro warframestat_repository}
  WarframestatRepository({required Client client, required CacheManager manager})
    : _client = client,
      _manager = manager;

  final Client _client;
  final CacheManager _manager;

  /// The locale request will be made for
  Language language = Language.en;

  /// Get static list of synthesis targets
  ///
  /// I doubt the list will be updated since DE doesn't really add much on their
  /// end so caching for even a year is perfectly fine
  Future<List<SynthTarget>> fetchTargets() async {
    const key = 'synth_targets';
    final data = await _manager.get<List<dynamic>>(key);
    if (data != null) {
      final targets = List<Map<String, dynamic>>.from(data);
      return targets.map(SynthTarget.fromJson).toList();
    }

    final client = SynthTargetClient(client: _client, ua: userAgent, language: language);
    final targets = await client.fetchTargets();
    await _manager.set(
      key,
      targets.map((t) => t.toJson()).toList(),
      ttl: const Duration(days: DateTime.monthsPerYear * DateTime.daysPerWeek),
    );

    return client.fetchTargets();
  }

  /// Get one item based on unique name
  Future<Item?> fetchItem(String uniqueName) async {
    final data = await _manager.get<Map<String, dynamic>>(uniqueName);
    if (data != null) return toItem(data);

    final client = WarframeItemsClient(client: _client, ua: userAgent, language: language);
    final item = await client.fetchItem(uniqueName);
    if (item == null) return null;

    await _manager.set(uniqueName, item.toJson(), ttl: const Duration(days: DateTime.daysPerWeek));

    return item;
  }

  Future<CraigRegion> fetchRegions() async {
    const key = 'regions';
    final data = _manager.get<Map<String, dynamic>>(key);
    if (data != null) {}

    final res = await _client.get(Uri.parse('https://cdn.truemaster.app/regions.json'));
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final regions = _decodeData(json);

    await _manager.set(key, json, ttl: const Duration(days: 31));

    return regions;
  }

  Future<Arbitration> fetchArbitrations() async {
    const key = 'arbis';
    bool isActive(Arbitration a) {
      final now = DateTime.timestamp();
      return now.isAfter(a.activation) && now.isBefore(a.expiry);
    }

    final data = await _manager.get<List<dynamic>>(key);
    if (data != null) {
      final arbis = List<Map<String, dynamic>>.from(data).map(Arbitration.fromJson).toList();
      return arbis.firstWhere(isActive);
    }

    final res = await _client.get(Uri.parse('https://browse.wf/arbys.txt'));
    final csv = res.body;
    final arbis = await Isolate.run(() => parseArbitration(csv));
    final ttl = DateTime.timestamp().difference(arbis.last.expiry);

    await _manager.set(key, arbis.map((a) => a.toJson()).toList(), ttl: ttl);
    return arbis.firstWhere(isActive);
  }

  CraigRegion _decodeData(Map<String, dynamic> data) {
    final nodes = List<Map<String, dynamic>>.from(data['nodes'] as List<dynamic>);
    final junctions = List<Map<String, dynamic>>.from(data['junctions'] as List<dynamic>);

    return (nodes: nodes.map(CraigNode.fromJson).toList(), junctions: junctions.map(CraigJunction.fromJson).toList());
  }
}
