import 'dart:async';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:http/http.dart';

/// {@template cache_client}
/// Custom [BaseClient] that caches responses using Hive
/// {@endtemplate}
class CacheClient extends BaseClient {
  /// {@macro cache_client}
  CacheClient({
    required this.key,
    required this.cacheTime,
    required this.cache,
    Client? client,
  }) : _inner = client ?? Client();

  /// The key the response would be stored under
  final String key;

  /// The [Box] the response would be stored in
  final Box<Map<dynamic, dynamic>> cache;

  /// When the response should be considered invalid
  final Duration cacheTime;

  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final now = DateTime.timestamp();
    final cached = cache.get(key)?.cast<String, dynamic>() ?? {};
    final expiry = cached['expiry'] as DateTime?;

    if (expiry != null && now.isBefore(expiry)) {
      final body = cached['data'] as Uint8List;
      return StreamedResponse(Stream.value(body), 200);
    }

    final response = await _inner.send(request);
    final body = await response.stream.toBytes();

    await cache.put(key, {'expiry': now.add(cacheTime), 'data': body});

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

/// extensions to clean up [CacheClient] box
extension CacheBox on Box<Map<dynamic, dynamic>> {
  /// Cleans up stale cached keys
  Future<void> cleanupCache() async {
    const staleTime = Duration(minutes: 30);

    if (keys.length < 5) return;
    for (final key in keys) {
      final cached = this.get(key)!;
      final expiry = cached['expiry'] as DateTime;
      final elapsedTime = DateTime.timestamp().difference(expiry).abs();

      if (elapsedTime >= staleTime) await this.delete(key);
    }

    await compact();
  }
}
