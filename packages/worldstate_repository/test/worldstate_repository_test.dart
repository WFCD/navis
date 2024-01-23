import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

import 'fixtures/fixtures.dart';

class MockClient extends Mock implements Client {
  static late Worldstate worldstate;

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await Client().get(url);
    final body = json.decode(response.body) as Map<String, dynamic>;
    worldstate = Worldstate.fromJson(body);

    return response;
  }
}

void main() {
  late Client client;
  late WarframestatCache cache;
  late WorldstateRepository repo;
  late Box<dynamic> testBox;

  late final worldstate = MockClient.worldstate;

  // final List<SynthTarget> synthTargets = Fixtures.synthTargetsFixture
  //  .map((dynamic e) => SynthTargetModel.fromJson(e as Map<String, dynamic>))
  //     .toList();

  // final testDeal = toBaseItem(Fixtures.dealFixture);

  setUpAll(() async {
    registerFallbackValue(Language.en);

    final temp = Directory.systemTemp;
    Hive.init(temp.path);

    testBox = await Hive.openBox<dynamic>('test_box', path: temp.path);
    cache = await WarframestatCache.initCache(temp.path, testBox);
    client = MockClient();
    repo = WorldstateRepository(client: client, cache: cache);
  });

  group('Worldstate', () {
    // Make sure cached test data is cleared before moving on to the next test.
    tearDown(() async {
      await testBox.delete(WarframestatCache.worldstateTimestampKey);
      await testBox.delete(WarframestatCache.worldstateKey);
    });

    test('get => state is cached in the background', () async {
      await repo.getWorldstate();

      expect(cache.getCachedStateTimestamp(), worldstate.timestamp);
      expect(cache.getCachedState(), worldstate);
    });

    test(
      'expired => get new worldstate',
      () async {
        // The tearDown clears keys after every test so we need to have something
        //in cache to test against the timestamp.
        cache.cacheWorldstate(worldstate);

        final state = await repo.getWorldstate();

        await Future<void>.delayed(const Duration(seconds: 61));

        expect(state.timestamp, worldstate.timestamp);
      },
      timeout: const Timeout(Duration(minutes: 3)),
    );

    test('forced => gets a new state regardless of timestamp', () async {
      final fixture = Fixtures.worldstateFixture;
      fixture['timestamp'] = DateTime.now().toUtc().toIso8601String();
      final updateState = Worldstate.fromJson(fixture);

      // The tearDown clears keys after every test so we need to have something
      //in cache to test against the timestamp.
      cache.cacheWorldstate(updateState);

      final state = await repo.getWorldstate(forceUpdate: true);
      final isTimestampAhead =
          state.timestamp.difference(DateTime.now()).abs() >=
              const Duration(seconds: 60);

      expect(isTimestampAhead, true);
    });

    test('throw exception => return cached state', () async {
      cache.cacheWorldstate(worldstate);

      var state = await repo.getWorldstate();
      expect(state.timestamp, worldstate.timestamp);

      state = await repo.getWorldstate();
      expect(state.timestamp, worldstate.timestamp);
    });

    test('throws exception and cache is empty => rethrows exception', () async {
      expect(repo.getWorldstate(), throwsException);

      expect(repo.getWorldstate(), throwsException);
    });
  });

  group('Deal Item', () {});
}
