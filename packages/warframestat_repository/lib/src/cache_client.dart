import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart';

///
typedef CachedItem = ({DateTime timestamp, Uint8List data});

/// {@template cache_client}
/// Custom [BaseClient] that caches responses using Hive
/// {@endtemplate}
class CacheClient extends BaseClient {
  /// {@macro cache_client}
  CacheClient({required this.cacheTime, Client? client})
      : _inner = client ?? Client();

  /// When the response should be considered invalid
  final Duration cacheTime;

  final Client _inner;

  final Map<String, CachedItem> _cache = {};

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request.method != 'GET') return _inner.send(request);

    final now = DateTime.timestamp();
    final cached = _cache[request.url.toString()];

    if (cached != null && now.isBefore(cached.timestamp)) {
      return StreamedResponse(Stream.value(cached.data), 200);
    }

    final response = await _inner.send(request);
    final body = await response.stream.toBytes();

    _cache[request.url.toString()] =
        (timestamp: now.add(cacheTime), data: body);

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
