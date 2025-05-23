import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:http_client/src/cache_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final timestamp = DateTime.timestamp();

  late final Client mockClient;
  late final CacheClient cacheClient;

  setUpAll(() async {
    registerFallbackValue(FakeRequest());

    PathProviderPlatform.instance = MockPathProviderPlatform();

    mockClient = MockClient();
    cacheClient = await CacheClient.init(mockClient);
  });

  tearDownAll(() async {
    await Hive.deleteFromDisk();
  });

  test(
    'Make sure client returns from cache',
    () async {
      final cache = "{'timestamp': ${timestamp.toIso8601String()}}";
      when(() => mockClient.send(any()))
          .thenAnswer((_) async => StreamedResponse(Stream.value(utf8.encode(cache)), 200));

      var response = await cacheClient.get(Uri.https('example.com'));
      expect(response.body, cache);

      reset(mockClient);

      response = await cacheClient.get(Uri.https('example.com'));
      verifyNever(() => mockClient.send(any()));
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );
}

class MockClient extends Mock implements Client {}

class FakeRequest extends Fake implements BaseRequest {}

class MockPathProviderPlatform extends Mock with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async => Directory.systemTemp.absolute.path;
}
