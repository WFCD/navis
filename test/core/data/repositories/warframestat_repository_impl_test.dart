import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/data/datasources/warframestat_local.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/data/repositories/warframestat_repository_impl.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:supercharged/supercharged.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

import '../../../fixtures/fixture_reader.dart';

class MockWarframestatLocal extends Mock implements WarframestatCache {}

class MockWarframestatRemote extends Mock implements WarframestatRemote {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  WarframestatRepository repository;

  WarframestatCache mockCache;
  WarframestatRemote mockRemote;
  NetworkInfo mockNetworkInfo;

  setUp(() {
    mockCache = MockWarframestatLocal();
    mockRemote = MockWarframestatRemote();
    mockNetworkInfo = MockNetworkInfo();

    repository = WarframestatRepositoryImpl(
      local: mockCache,
      remote: mockRemote,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('Device online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('Device offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getWorldstate', () {
    const tPlatform = GamePlatforms.pc;
    final tWorldstate = WorldstateModel.fromJson(
        json.decode(fixture('worldstate.json')) as Map<String, dynamic>);

    runTestOnline(() {
      test(
          'should return instance of Worldstate when the call to remote data source is successful',
          () async {
        when(mockRemote.getWorldstate(any))
            .thenAnswer((_) async => tWorldstate);

        final result = await repository.getWorldstate(tPlatform);

        verify(mockRemote.getWorldstate(tPlatform));
        expect(result, equals(tWorldstate));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(mockRemote.getWorldstate(any))
            .thenAnswer((_) async => tWorldstate);

        await repository.getWorldstate(tPlatform);

        verify(mockRemote.getWorldstate(tPlatform));
        verify(mockCache.cacheWorldstate(tWorldstate));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemote.getWorldstate(any)).thenThrow(ServerException());

        final call = repository.getWorldstate;

        verifyZeroInteractions(mockCache);
        expect(() => call(tPlatform), throwsA(ServerFailure()));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockCache.getCachedState()).thenAnswer((_) async => tWorldstate);

        final result = await repository.getWorldstate(tPlatform);

        verifyZeroInteractions(mockRemote);
        verify(mockCache.getCachedState());
        expect(result, equals(tWorldstate));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockCache.getCachedState()).thenThrow(CacheException());

        final call = repository.getWorldstate;

        expect(() => call(tPlatform), throwsA(CacheFailure()));
      });
    });
  });

  group('getSynthTargets', () {
    final tTargets =
        (json.decode(fixture('synthTargets.json')) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map<SynthTarget>((t) => SynthTargetModel.fromJson(t))
            .toList();

    runTestOnline(() {
      setUp(() {
        when(mockCache.synthTargetLastUpdate)
            .thenAnswer((_) => DateTime.now().subtract(10.days));
      });

      test(
          'should return a List of synthTarget instaces when the call to remote data source is successful',
          () async {
        when(mockRemote.getSynthTargets()).thenAnswer((_) async => tTargets);

        final results = await repository.getSynthTargets();

        verify(mockRemote.getSynthTargets());
        expect(results, equals(tTargets));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(mockRemote.getSynthTargets()).thenAnswer((_) async => tTargets);

        await repository.getSynthTargets();

        verify(mockRemote.getSynthTargets());
        verify(mockCache.cacheSynthTargets(tTargets));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemote.getSynthTargets()).thenThrow(ServerException());

        expect(repository.getSynthTargets, throwsA(ServerFailure()));
      });
    });

    runTestOffline(() {
      setUp(() {
        when(mockCache.synthTargetLastUpdate).thenAnswer((_) => DateTime.now());
      });

      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockCache.getCachedTargets()).thenAnswer((_) async => tTargets);

        final results = await repository.getSynthTargets();

        verifyZeroInteractions(mockRemote);
        verify(mockCache.getCachedTargets());
        expect(results, equals(tTargets));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockCache.getCachedTargets()).thenThrow(CacheException());

        expect(repository.getSynthTargets, throwsA(CacheFailure()));
      });
    });
  });

  group('getDealInfo', () {
    const tItem = BaseItem(
      name: 'Chroma',
      description: 'A master of the deadly elements, '
          'Chroma can alter his damage output by changing '
          'his Emissive Color.',
      type: 'Warframe',
      imageName: 'chroma.png',
      tradable: false,
    );

    runTestOnline(() {
      test('return test item when searching chroma', () async {
        when(mockRemote.searchItems(any)).thenAnswer((_) async => [tItem]);

        final result = await repository.getDealInfo('id', 'chroma');

        verify(mockRemote.searchItems('chroma'));
        expect(result, equals(tItem));
      });

      test('make sure the deal\'s Item info is cached properly', () async {
        when(mockRemote.searchItems(any)).thenAnswer((_) async => [tItem]);

        await repository.getDealInfo('id', 'chroma');

        verify(mockRemote.searchItems('chroma'));
        verify(mockCache.cacheDealInfo('id', tItem));
      });

      // Doesn't matter if there is a server problem it will always return from cache when the deal is the same
      // as the previous one, having said that the deals card will also not render when there is a server problem
      test('return the cached deal\'s item info ', () async {
        when(mockCache.getCachedDealId()).thenAnswer((_) => 'id');
        when(mockCache.getCachedDeal()).thenAnswer((_) => tItem);

        await repository.getDealInfo('id', 'chroma');

        verify(mockCache.getCachedDealId());
        verify(mockCache.getCachedDeal());
      });
    });
  });
}
