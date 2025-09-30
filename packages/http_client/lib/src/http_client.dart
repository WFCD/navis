import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:flutter_ua/flutter_ua.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

const int cacheMaxSize = 2 * 1024 * 1024;

Future<Client> buildNativeClient() async {
  await FlutterUserAgent.init();

  final Client httpClient;
  final userAgent = FlutterUserAgent.userAgent;

  if (Platform.isIOS || Platform.isMacOS) {
    final config = URLSessionConfiguration.ephemeralSessionConfiguration()
      ..cache = URLCache.withCapacity(memoryCapacity: cacheMaxSize)
      ..httpAdditionalHeaders = {if (userAgent != null) HttpHeaders.userAgentHeader: userAgent};

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
