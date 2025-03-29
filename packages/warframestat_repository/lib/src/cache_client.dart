import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';

part 'cache_client.g.dart';

///
typedef CachedItem = ({DateTime timestamp, Uint8List data});

/// {@template cache_client}
/// Custom [BaseClient] that caches responses using Hive
/// {@endtemplate}
class CacheClient extends BaseClient {
  /// {@macro cache_client}
  CacheClient({required this.cacheTime, required this.cacheBox, Client? client}) : _inner = client ?? Client();

  /// When the response should be considered invalid
  final Duration cacheTime;

  final Box<HiveCacheItem> cacheBox;

  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request.method != 'GET') return _inner.send(request);

    final hash = md5.convert(utf8.encode(request.url.toString())).toString();
    final cached = cacheBox.get(hash);

    if (cached != null && !cached.isExpired) {
      return StreamedResponse(Stream.value(cached.data), 200);
    }

    final response = await _inner.send(request);
    final body = await response.stream.toBytes();

    await cacheBox.put(
      hash,
      HiveCacheItem(body, DateTime.timestamp().add(cacheTime)),
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

@HiveType(typeId: 0)
class HiveCacheItem extends HiveObject {
  HiveCacheItem(this.data, this.expiry);

  @HiveField(0)
  final Uint8List data;

  @HiveField(1)
  final DateTime expiry;

  bool get isExpired => DateTime.timestamp().isAfter(expiry);
}
