import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:http_client/src/hive/hive_adapters.dart';
import 'package:http_client/src/hive/hive_registrar.g.dart';
import 'package:http_client/src/models/cache_item.dart';
import 'package:path_provider/path_provider.dart';

class CacheClient extends BaseClient {
  CacheClient({Client? client, required Box<CachedItem> cacheBox, this.cacheDuration = const Duration(seconds: 60)})
      : _inner = client ?? Client(),
        _cacheBox = cacheBox;

  final Client _inner;
  final Box<CachedItem> _cacheBox;
  final Duration cacheDuration;

  static Future<CacheClient> create(Client? client, {required Duration cacheDuration}) async {
    final temp = await getTemporaryDirectory();
    Hive.init(temp.path);
    if (!Hive.isAdapterRegistered(CachedItemAdapter().typeId)) Hive.registerAdapters();

    final cache = await Hive.openBox<CachedItem>('navis_cache');
    return CacheClient(cacheBox: cache, client: client, cacheDuration: cacheDuration);
  }

  CacheClient setCacheDuration(Duration cacheDuration) =>
      CacheClient(client: _inner, cacheBox: _cacheBox, cacheDuration: cacheDuration);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request.method != 'GET') return _inner.send(request);
    final cache = _cacheBox.get(request.url.toString());

    if (cache != null && !cache.isExpired) {
      return StreamedResponse(Stream.value(cache.data), HttpStatus.ok);
    }

    final response = await _inner.send(request);
    final bytes = await response.stream.toBytes();

    await _cacheBox.put(
      request.url.toString(),
      CachedItem(data: bytes, timestamp: DateTime.timestamp(), ttl: cacheDuration),
    );

    return response.copy(Stream.value(bytes));
  }

  @override
  void close() {
    super.close();
    _inner.close();
  }
}

extension on StreamedResponse {
  StreamedResponse copy(Stream<List<int>> stream) {
    return StreamedResponse(
      stream,
      statusCode,
      contentLength: contentLength,
      request: request,
      headers: headers,
      isRedirect: isRedirect,
      persistentConnection: persistentConnection,
      reasonPhrase: reasonPhrase,
    );
  }
}
