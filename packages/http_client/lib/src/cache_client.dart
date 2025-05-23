import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:http_client/src/hive/hive_registrar.g.dart';
import 'package:http_client/src/models/cache_item.dart';
import 'package:path_provider/path_provider.dart';

class CacheClient extends BaseClient {
  CacheClient(Client client, Box<CachedItem> cache)
      : _inner = client,
        _cache = cache;

  final Box<CachedItem> _cache;
  final Client _inner;

  /// Set time to live for cache invalidation
  Duration ttl = const Duration(seconds: 60);

  static Future<CacheClient> init(Client client) async {
    final temp = await getTemporaryDirectory();
    Hive.init(temp.absolute.path);
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapters();

    final cache = await Hive.openBox<CachedItem>('temp_emptor.cache');
    await _cleanup(cache);

    // TODO(Orn): May have to throw this into an isolate if it lags the main thread
    Timer.periodic(const Duration(hours: Duration.hoursPerDay), (_) => _cleanup(cache, flush: true));

    return CacheClient(client, cache);
  }

  static Future<void> _cleanup(Box<CachedItem> cache, {bool flush = false}) async {
    // make sure all changes are written before deciding what to remove. Then flush again in the end
    if (flush) await cache.flush();

    final toRemove = <String>[];
    for (final key in cache.keys) {
      final item = cache.get(key)!;
      if (item.isExpired) toRemove.add(key as String);
    }

    toRemove.forEach(cache.delete);
    await cache.flush();
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request.method != 'GET') return _inner.send(request);

    final hash = md5.convert(utf8.encode(request.url.toString())).toString();
    final cache = _cache.get(hash);

    if (cache != null && !cache.isExpired) {
      return StreamedResponse(Stream.value(cache.data), HttpStatus.ok);
    }

    final response = await _inner.send(request);
    final bytes = await response.stream.toBytes();

    await _cache.put(
      hash,
      CachedItem(data: bytes, timestamp: DateTime.timestamp(), ttl: ttl),
    );

    return response.copy(Stream.value(bytes));
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
