import 'dart:isolate';

import 'package:http/http.dart';
import 'package:http_client/http_client.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Worldstate;
import 'package:warframestat_repository/src/models/regions.dart';
import 'package:warframestat_repository/src/models/search_item.dart';
import 'package:worldstate_models/worldstate_models.dart';

///
const userAgent = 'navis';

typedef CraigRegion = ({List<CraigNode> nodes, List<CraigJunction> junctions});

/// {@template warframestat_repository}
/// Entry point for Warframestatus endpoints used in Cephalon Navis
/// {@endtemplate}
class WarframestatRepository {
  /// {@macro warframestat_repository}
  WarframestatRepository({required Client client}) : _client = client;

  final Client _client;

  /// The locale request will be made for
  Language language = Language.en;

  Stream<Worldstate> worldstate() async* {
    const delay = Duration(seconds: Duration.secondsPerMinute * 3);

    // In case the stream gets restarted
    yield await _fetchWorldstate(_client, delay, language.name);
    await Future<void>.delayed(delay);

    yield* Stream<Future<Worldstate>>.periodic(
      delay,
      (_) async => _fetchWorldstate(_client, delay, language.name),
    ).asyncMap((fw) async => fw);
  }

  static Future<Worldstate> _fetchWorldstate(Client client, Duration delay, String locale) async {
    final cacheClient = await _cacheClient(client, const Duration(days: Duration.hoursPerDay * 14));
    final dropData = await buildDropData(cacheClient);

    cacheClient.ttl = delay;
    final response = await cacheClient.get(Uri.parse('https://api.warframe.com/cdn/worldState.php'));
    return Isolate.run(() async {
      final deps = Dependency(dropData);
      return RawWorldstate.fromJson(response.body).toWorldstate(deps);
    });
  }

  /// Get static list of synthesis targets
  ///
  /// I doubt the list will be updated since DE doesn't really add much on their
  /// end so caching for even a year is perfectly fine
  Future<List<SynthTarget>> fetchTargets() async {
    final client = SynthTargetClient(
      client: await _cacheClient(_client, const Duration(days: 30)),
      ua: userAgent,
      language: language,
    );

    return client.fetchTargets();
  }

  /// Search warframe-items
  Future<List<SearchItem>> searchItems(String query) async {
    final client = WarframeItemsClient(
      client: await _cacheClient(_client, const Duration(days: 1)),
      ua: userAgent,
      language: language,
    );

    return client.search(
      query,
      props: [
        ItemProps.uniqueName,
        ItemProps.name,
        ItemProps.description,
        ItemProps.imageName,
        ItemProps.type,
        ItemProps.category,
        ItemProps.vaulted,
        ItemProps.wikiaUrl,
        ItemProps.wikiaThumbnail,
      ],
      convert: (list) => list.map(SearchItem.fromJson).toList(),
    );
  }

  /// Get one item based on unique name
  Future<Item?> fetchItem(String uniqueName) async {
    final client = WarframeItemsClient(
      client: await _cacheClient(_client, const Duration(minutes: 30)),
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }

  Future<CraigRegion> fetchRegions() async {
    final client = await _cacheClient(_client, const Duration(days: 30));
    final res = await client.get(Uri.parse('https://cdn.truemaster.app/regions.json'));

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final nodes = _jsonMapList(json['nodes'] as List<dynamic>);
    final junctions = _jsonMapList(json['junctions'] as List<dynamic>);

    return (nodes: nodes.map(CraigNode.fromJson).toList(), junctions: junctions.map(CraigJunction.fromJson).toList());
  }

  List<Map<String, dynamic>> _jsonMapList(List<dynamic> list) {
    return List<Map<String, dynamic>>.from(list);
  }

  static Future<CacheClient> _cacheClient(Client client, Duration ttl) async {
    final http = await CacheClient.init(client);
    http.ttl = ttl;

    return http;
  }
}
