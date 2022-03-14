import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

import 'fixtures/fixture_reader.dart';

class MockUserSettings extends Mock implements UserSettings {}

class MockWorldstateComputeRunners extends Mock
    implements WorldstateComputeRunners {}

class FakeWorldstateRequest extends Fake implements WorldstateRequestType {}

void main() {
  final temp = Directory.systemTemp;
  final mockRunners = MockWorldstateComputeRunners();

  final worldstateFixture = fixture<Map<String, dynamic>>('worldstate.json');
  final Worldstate worldstate = WorldstateModel.fromJson(worldstateFixture);

  final synthTargetsFixture = fixture<List<dynamic>>('synthTargets.json');
  final List<SynthTarget> synthTargets = synthTargetsFixture
      .map((dynamic e) => SynthTargetModel.fromJson(e as Map<String, dynamic>))
      .toList();

  const kTestSearchTerm = 'Chroma Prime';
  const kTestSearchId = 'mockID';
  final dealFixture = fixture<Map<String, dynamic>>('darvo_deal.json');
  final testDeal = toBaseItem(dealFixture);

  late UserSettings settings;
  late WarframestatCache cache;
  late WorldstateRepository repo;
  late Box<dynamic> testBox;

  setUpAll(() => Hive.init(temp.path));

  setUp(() async {
    settings = MockUserSettings();
    testBox = await Hive.openBox<dynamic>('test_box', path: temp.path);
    cache = await WarframestatCache.initCache(temp.path, testBox);
    repo = WorldstateRepository(
      settings: settings,
      cache: cache,
      runners: mockRunners,
    );

    registerFallbackValue(FakeWorldstateRequest());
    when(() => settings.platform).thenAnswer((_) => GamePlatforms.pc);
    when(() => settings.language).thenAnswer((_) => const Locale('en'));
  });

  tearDown(() {
    testBox.clear();
  });

  test('Test cache init', () async {
    expect(
      await WarframestatCache.initCache(temp.path),
      isA<WarframestatCache>(),
    );
  });

  group('Test retrivial of data and caching', () {
    test('worldstate fetch', () async {
      when(() => mockRunners.getWorldstate(any()))
          .thenAnswer((_) async => worldstate);

      expect(await repo.getWorldstate(), equals(worldstate));
      expect(cache.getCachedStateTimestamp(), equals(worldstate.timestamp));
      expect(cache.getCachedState(), equals(worldstate));

      reset(mockRunners);
    });

    test('worldstate fetch from cache', () async {
      final now = DateTime.now().add(const Duration(seconds: 2)).toUtc();
      final state = worldstate.copyWith(timestamp: now);

      await testBox.put(WarframestatCache.worldstateTimestampKey, now);
      await testBox.put(
        WarframestatCache.worldstateKey,
        json.encode(WorldstateModel.fromWorldstate(state).toJson()),
      );

      final s = await repo.getWorldstate();

      expect(cache.getCachedStateTimestamp(), equals(now));
      expect(s.timestamp, now);

      reset(mockRunners);
    });

    test('synthtargets', () async {
      when(mockRunners.getTargets).thenAnswer((_) async => synthTargets);

      expect(await repo.getSynthTargets(), equals(synthTargets));
      expect(cache.getCachedTargets(), equals(synthTargets));
    });

    test("Test the an daily deal's information is retrived", () async {
      when(() => mockRunners.getItemDealInfo(kTestSearchTerm))
          .thenAnswer((_) async => testDeal);

      final results = await repo.getDealInfo(kTestSearchId, kTestSearchTerm);

      expect(results, equals(testDeal));
      expect(cache.getCachedDeal(kTestSearchId), equals(testDeal));
    });
  });

  group('Test exception handling', () {
    reset(mockRunners);

    test('Make sure a cached version of the state is returned', () async {
      when(() => mockRunners.getWorldstate(any()))
          .thenThrow(const ServerException(''));

      cache.cacheWorldstate(worldstate);

      expect(await repo.getWorldstate(), equals(worldstate));
    });

    test('Make sure the exception is rethrown', () async {
      await testBox.delete(WarframestatCache.worldstateTimestampKey);
      await testBox.delete(WarframestatCache.worldstateKey);

      when(() => mockRunners.getWorldstate(any()))
          .thenThrow(const ServerException(''));

      await expectLater(
        repo.getWorldstate(),
        throwsA(isA<ServerException>()),
      );
    });

    test('test worldstate FormatException', () async {
      await testBox.delete(WarframestatCache.worldstateTimestampKey);
      await testBox.delete(WarframestatCache.worldstateKey);

      when(() => mockRunners.getWorldstate(any()))
          .thenThrow(const FormatException());

      await expectLater(
        repo.getWorldstate(),
        throwsA(isA<FormatException>()),
      );
    });

    test(
      'Make sure we force an update when cache is empty '
      'and state is expired',
      () async {
        when(() => mockRunners.getWorldstate(any()))
            .thenAnswer((_) async => worldstate);

        cache.cacheWorldstate(worldstate);
        await testBox.delete(WarframestatCache.worldstateKey);

        await repo.getWorldstate();

        verify(() => mockRunners.getWorldstate(any()));
      },
    );

    test('SynthTarget ServerException', () async {
      when(mockRunners.getTargets).thenThrow(const ServerException(''));

      cache.cacheSynthTargets(synthTargets);

      expect(await repo.getSynthTargets(), equals(synthTargets));

      await testBox.delete(WarframestatCache.synthTargetsKey);
      await expectLater(
          repo.getSynthTargets(), throwsA(isA<ServerException>()));
    });

    test('Deal info ServerException', () async {
      cache.cacheDealInfo(kTestSearchId, testDeal);

      expect(
        await repo.getDealInfo(kTestSearchId, kTestSearchTerm),
        equals(testDeal),
      );

      await testBox.delete(WarframestatCache.dealIdKey);
      when(() => mockRunners.getItemDealInfo(kTestSearchTerm))
          .thenAnswer((_) async => testDeal);

      expect(
        await repo.getDealInfo(kTestSearchId, kTestSearchTerm),
        equals(testDeal),
      );

      await testBox.delete(WarframestatCache.dealIdKey);
      await testBox.delete(kTestSearchId);
      when(() => mockRunners.getItemDealInfo(any()))
          .thenThrow(const ServerException(''));

      await expectLater(
        repo.getDealInfo(kTestSearchId, kTestSearchTerm),
        throwsA(isA<ServerException>()),
      );

      // We already deleted the cache version in the previous test
      when(() => mockRunners.getItemDealInfo(kTestSearchTerm))
          .thenThrow(const ItemNotFoundException(kTestSearchTerm));

      await expectLater(
        repo.getDealInfo(kTestSearchId, kTestSearchTerm),
        throwsA(isA<ItemNotFoundException>()),
      );
    });
  });
}
