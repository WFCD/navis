import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

import 'fakes.dart';
import 'fixtures/fixtures.dart';
import 'mocks.dart';

void main() {
  late UserSettings settings;
  late WarframestatCache cache;
  late WorldstateRepository repo;
  late Box<dynamic> testBox;
  late WorldstateComputeRunners runners;

  final Worldstate worldstate =
      WorldstateModel.fromJson(Fixtures.worldstateFixture);

  final List<SynthTarget> synthTargets = Fixtures.synthTargetsFixture
      .map((dynamic e) => SynthTargetModel.fromJson(e as Map<String, dynamic>))
      .toList();

  final testDeal = toBaseItem(Fixtures.dealFixture);

  setUpAll(() async {
    final temp = Directory.systemTemp;
    Hive.init(temp.path);

    settings = MockUserSettings();
    testBox = await Hive.openBox<dynamic>('test_box', path: temp.path);
    cache = await WarframestatCache.initCache(temp.path, testBox);
    runners = MockWorldstateComputeRunners();
    repo = WorldstateRepository(
      settings: settings,
      cache: cache,
      runners: runners,
    );

    registerFallbackValue(FakeWorldstateRequestType());
    registerFallbackValue(FakeItemSearchRequestType());
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

      final updateState =
          worldstate.copyWith(timestamp: DateTime.now().toUtc());

      when(() => runners.getWorldstate(any()))
          .thenAnswer((_) async => updateState);

      final state = await repo.getWorldstate();

      expect(state.timestamp, updateState.timestamp);
    });

    test('forced => gets a new state regardless of timestamp', () async {
      final updateState =
          worldstate.copyWith(timestamp: DateTime.now().toUtc());

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
