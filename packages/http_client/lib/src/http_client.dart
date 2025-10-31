import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
// import 'package:cupertino_http/cupertino_http.dart';
import 'package:flutter_ua/flutter_ua.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

const int cacheMaxSize = 2 * 1024 * 1024;

Future<Client> buildNativeClient() async {
  await FlutterUserAgent.init();

  Client? httpClient;
  final userAgent = FlutterUserAgent.userAgent;

  // TODO(orn): Not on the app store so I can just ignore iOS perf until then, but readd when
  //  cupertino_http gets updated
  // if (Platform.isIOS || Platform.isMacOS) {
  //   final config = URLSessionConfiguration.ephemeralSessionConfiguration()
  //     ..cache = URLCache.withCapacity(memoryCapacity: cacheMaxSize)
  //     ..httpAdditionalHeaders = {if (userAgent != null) HttpHeaders.userAgentHeader: userAgent};

  //   httpClient = CupertinoClient.fromSessionConfiguration(config);
  // }

  if (Platform.isAndroid) {
    final engine = CronetEngine.build(
      cacheMode: CacheMode.memory,
      cacheMaxSize: cacheMaxSize,
      enableBrotli: true,
      userAgent: userAgent,
    );

    httpClient = CronetClient.fromCronetEngine(engine, closeEngine: true);
  }

  return httpClient ?? IOClient(HttpClient()..userAgent = userAgent);
}
