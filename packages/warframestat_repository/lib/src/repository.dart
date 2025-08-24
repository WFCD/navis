import 'package:http/http.dart';
import 'package:http_client/http_client.dart';
import 'package:logging/logging.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/src/models/regions.dart';
import 'package:warframestat_repository/src/models/search_item.dart';
import 'package:web_socket_client/web_socket_client.dart';

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

  final _logger = Logger('WarframestatRepository');

  Stream<Worldstate> worldstate() async* {
    final websocket = WarframestatWebsocket();
    final connection = websocket.connection;

    await for (final conn in connection) {
      switch (conn) {
        case Connecting():
          _logger.info('Worldstate connection is being established');
        case Connected() || Reconnected():
          _logger.info('Worldstate connection has been established');
          yield* websocket.worldstate;
        case Reconnecting() || Disconnecting():
          final buffer = StringBuffer('Worldstate connection');

          if (conn is Reconnecting) buffer.write(' was ');
          if (conn is Disconnecting) buffer.write(' is being ');

          _logger.warning(buffer..write('terminated'));
        case Disconnected():
          _logger.shout('Websocket connection was terminated: ${conn.reason}', conn.error, conn.stackTrace);
      }
    }
  }

  /// Get static list of synthesis targets
  ///
  /// I doubt the list will be updated since DE doesn't really add much on their
  /// end so caching for even a year is perfectly fine
  Future<List<SynthTarget>> fetchTargets() async {
    final client = SynthTargetClient(
      client: await _cacheClient(const Duration(days: 30)),
      ua: userAgent,
      language: language,
    );

    return client.fetchTargets();
  }

  /// Search warframe-items
  Future<List<SearchItem>> searchItems(String query) async {
    final client = WarframeItemsClient(
      client: await _cacheClient(const Duration(days: 1)),
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
      client: await _cacheClient(const Duration(minutes: 30)),
      ua: userAgent,
      language: language,
    );

    return client.fetchItem(uniqueName);
  }

  Future<CraigRegion> fetchRegions() async {
    final client = await _cacheClient(const Duration(days: 30));
    final res = await client.get(Uri.parse('https://cdn.truemaster.app/regions.json'));

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final nodes = _jsonMapList(json['nodes'] as List<dynamic>);
    final junctions = _jsonMapList(json['junctions'] as List<dynamic>);

    return (nodes: nodes.map(CraigNode.fromJson).toList(), junctions: junctions.map(CraigJunction.fromJson).toList());
  }

  List<Map<String, dynamic>> _jsonMapList(List<dynamic> list) {
    return List<Map<String, dynamic>>.from(list);
  }

  Future<CacheClient> _cacheClient(Duration ttl) async {
    final client = await CacheClient.init(_client);
    client.ttl = ttl;

    return client;
  }
}
