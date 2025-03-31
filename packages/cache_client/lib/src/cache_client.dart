import 'dart:convert';

import 'package:cache_client/src/cached_item.dart';
import 'package:cache_client/src/hive/hive_registrar.g.dart';
import 'package:crypto/crypto.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:http/http.dart';

class CacheClient extends BaseClient {
  /// {@macro cache_client}
  CacheClient({required this.cache, this.ttl = const Duration(seconds: 60), Client? client})
      : _inner = client ?? Client();

  final Box<CachedItem> cache;

  final Duration ttl;

  final Client _inner;

  static Future<CacheClient> initCacheClient({Duration ttl = const Duration(seconds: 60), Client? client}) async {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapters();
    final box = await Hive.openBox<CachedItem>('cache_client.tmp');

    return CacheClient(cache: box, ttl: ttl, client: client);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request.method != 'GET') return _inner.send(request);

    final hash = md5.convert(utf8.encode(request.url.toString())).toString();
    final cached = cache.get(hash);

    if (cached != null && !cached.isExpired) {
      return StreamedResponse(Stream.value(cached.data), 200);
    }

    final response = await _inner.send(request);
    final body = await response.stream.toBytes();

    await cache.put(
      hash,
      CachedItem(body, DateTime.timestamp().add(ttl)),
    );

    return response.copy(Stream.value(body));
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
