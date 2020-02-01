import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_local.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_remote.dart';
import 'package:navis/features/worldstate/data/repositories/warframestat_repository_impl.dart';
import 'package:navis/features/worldstate/domain/repositories/warfamestat_repository.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

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
    final tWorldstate = Worldstate.fromJson(
        json.decode(fixture('worldstate.json')) as Map<String, dynamic>);

    runTestOnline(() {
      test('make sure device is online', () async {
        await repository.getWorldstate(GamePlatforms.pc);

        final result = await mockNetworkInfo.isConnected;

        verify(mockNetworkInfo.isConnected);
        expect(result, true);
      });

      test(
          'should return instance of Worldstate when the call to remote data source is successful',
          () async {
        when(mockRemote.getWorldstate(any))
            .thenAnswer((_) async => tWorldstate);

        final result = await repository.getWorldstate(tPlatform);

        verify(mockRemote.getWorldstate(tPlatform));
        expect(result, equals(Right<Failure, Worldstate>(tWorldstate)));
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

        final result = await repository.getWorldstate(tPlatform);

        verify(mockRemote.getWorldstate(tPlatform));
        verifyZeroInteractions(mockCache);
        expect(result, equals(Left<Failure, Worldstate>(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('make sure device is offline', () async {
        await repository.getWorldstate(GamePlatforms.pc);

        final result = await mockNetworkInfo.isConnected;

        verify(mockNetworkInfo.isConnected);
        expect(result, false);
      });

      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockCache.getCachedState()).thenAnswer((_) => tWorldstate);

        final result = await repository.getWorldstate(tPlatform);

        verifyZeroInteractions(mockRemote);
        verify(mockCache.getCachedState());
        expect(result, equals(Right<Failure, Worldstate>(tWorldstate)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockCache.getCachedState()).thenThrow(CacheException());

        final result = await repository.getWorldstate(tPlatform);

        verifyZeroInteractions(mockRemote);
        verify(mockCache.getCachedState());
        expect(result, equals(Left<Failure, Worldstate>(CacheFailure())));
      });
    });
  });

  group('getSynthTargets', () {
    final tTargets =
        (json.decode(fixture('synthTargets.json')) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map<SynthTarget>((t) => SynthTarget.fromJson(t))
            .toList();

    runTestOnline(() {
      test('make sure device is online', () async {
        await repository.getSynthTargets();

        final result = await mockNetworkInfo.isConnected;

        verify(mockNetworkInfo.isConnected);
        expect(result, true);
      });

      test(
          'should return a List of synthTarget instaces when the call to remote data source is successful',
          () async {
        when(mockRemote.getSynthTargets()).thenAnswer((_) async => tTargets);

        final results = await repository.getSynthTargets();

        verify(mockRemote.getSynthTargets());
        expect(results, equals(Right<Failure, List<SynthTarget>>(tTargets)));
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

        final results = await repository.getSynthTargets();

        verify(mockRemote.getSynthTargets());
        verifyZeroInteractions(mockCache);
        expect(
            results, equals(Left<Failure, List<SynthTarget>>(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockCache.getCachedTargets()).thenAnswer((_) => tTargets);

        final results = await repository.getSynthTargets();

        verifyZeroInteractions(mockRemote);
        verify(mockCache.getCachedTargets());
        expect(results, equals(Right<Failure, List<SynthTarget>>(tTargets)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockCache.getCachedTargets()).thenThrow(CacheException());

        final result = await repository.getSynthTargets();

        verifyZeroInteractions(mockRemote);
        verify(mockCache.getCachedTargets());
        expect(
            result, equals(Left<Failure, List<SynthTarget>>(CacheFailure())));
      });
    });
  });
}
