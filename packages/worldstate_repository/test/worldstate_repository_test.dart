import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

import 'fixtures/fixtures.dart';
import 'mocks.dart';

void main() {
  late WarframestatCache cache;
  late WorldstateRepository repo;
  late Box<dynamic> testBox;
  late WorldstateComputeRunners runners;

  final Worldstate worldstate = Worldstate.fromJson(Fixtures.worldstateFixture);

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
    runners = MockWorldstateComputeRunners();
    repo = WorldstateRepository(cache: cache, runners: runners);
  });

  group('Worldstate', () {
    // Make sure cached test data is cleared before moving on to the next test.
    tearDown(() async {
      await testBox.delete(WarframestatCache.worldstateTimestampKey);
      await testBox.delete(WarframestatCache.worldstateKey);
    });

    test('get => state is cached in the background', () async {
      when(() => runners.getWorldstate(any()))
          .thenAnswer((_) async => worldstate);

      await repo.getWorldstate();

      expect(cache.getCachedStateTimestamp(), worldstate.timestamp);
      expect(cache.getCachedState(), worldstate);
    });

    test('expired => get new worldstate', () async {
      // The tearDown clears keys after every test so we need to have something
      //in cache to test against the timestamp.
      cache.cacheWorldstate(worldstate);

      final fixture = Fixtures.worldstateFixture;
      fixture['timestamp'] = DateTime.now().toUtc().toIso8601String();
      final updateState = Worldstate.fromJson(fixture);

      when(() => runners.getWorldstate(any()))
          .thenAnswer((_) async => updateState);

      final state = await repo.getWorldstate();

      expect(state.timestamp, updateState.timestamp);
    });

    test('forced => gets a new state regardless of timestamp', () async {
      final fixture = Fixtures.worldstateFixture;
      fixture['timestamp'] = DateTime.now().toUtc().toIso8601String();
      final updateState = Worldstate.fromJson(fixture);

      // The tearDown clears keys after every test so we need to have something
      //in cache to test against the timestamp.
      cache.cacheWorldstate(updateState);

      when(() => runners.getWorldstate(any()))
          .thenAnswer((_) async => worldstate);

      final state = await repo.getWorldstate(forceUpdate: true);

      expect(state.timestamp, worldstate.timestamp);
    });

    test('throw exception => return cached state', () async {
      // The tearDown clears keys after every test so we need to have something
      //in cache to test against the timestamp.
      cache.cacheWorldstate(worldstate);

      when(() => runners.getWorldstate(any()))
          .thenThrow(const ServerException(''));

      var state = await repo.getWorldstate();
      expect(state.timestamp, worldstate.timestamp);

      when(() => runners.getWorldstate(any()))
          .thenThrow(const FormatException());

      state = await repo.getWorldstate();
      expect(state.timestamp, worldstate.timestamp);
    });

    test('throws exception and cache is empty => rethrows exception', () async {
      when(() => runners.getWorldstate(any()))
          .thenThrow(const ServerException(''));
      expect(repo.getWorldstate(), throwsException);

      when(() => runners.getWorldstate(any()))
          .thenThrow(const FormatException());
      expect(repo.getWorldstate(), throwsException);
    });
  });

  group('Deal Item', () {});
}
