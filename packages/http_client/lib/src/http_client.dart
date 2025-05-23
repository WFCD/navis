import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

const cacheMaxSize = 2 * 1024 * 1024;
const userAgent = 'cephalon_navis';

Client buildNativeClient() {
  final Client httpClient;

  if (Platform.isIOS || Platform.isMacOS) {
    final config = URLSessionConfiguration.ephemeralSessionConfiguration()
      ..cache = URLCache.withCapacity(memoryCapacity: cacheMaxSize)
      ..httpAdditionalHeaders = {HttpHeaders.userAgentHeader: userAgent};

    httpClient = CupertinoClient.fromSessionConfiguration(config);
  } else if (Platform.isAndroid) {
    final engine = CronetEngine.build(
      cacheMode: CacheMode.memory,
      cacheMaxSize: cacheMaxSize,
      enableBrotli: true,
      userAgent: userAgent,
    );

    httpClient = CronetClient.fromCronetEngine(engine, closeEngine: true);
  } else {
    httpClient = IOClient(HttpClient()..userAgent = userAgent);
  }

  return httpClient;
}
