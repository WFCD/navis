import 'dart:io';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:test/test.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

import 'load_fixtures.dart';

class MockClient extends Mock implements Client {}

class MockCacheManager extends Mock implements CacheManager {}

Response response(String body, [int statusCode = 200]) {
  return Response(body, statusCode, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
}

void main() {
  group('WarframeRepository', () {
    late MockClient mockClient;
    late MockCacheManager mockCacheManager;
    late WarframeRepository repository;

    final mockWorldstateJson = WorldstateFixture.load().json;
    final raw = RawWorldstate.fromJson(mockWorldstateJson);
    final mockWorldstateMap = Worldstate.fromRaw(raw, Dependency()).toMap();

    final mockDropDataMap = {
      'bountyRewardTables': const <Map<String, dynamic>>[],
      'missionRewards': const <Map<String, dynamic>>[],
      'relics': const <Map<String, dynamic>>[],
      'transientRewards': const <Map<String, dynamic>>[],
    };

    setUp(() {
      registerFallbackValue(Uri());
      registerFallbackValue(Duration.zero);

      mockClient = MockClient();
      mockCacheManager = MockCacheManager();
      repository = WarframeRepository(
        client: mockClient,
        manager: mockCacheManager,
      );
    });

    group('fetchWorldstate', () {
      test('returns cached worldstate when available', () async {
        when(
          () => mockCacheManager.get<Map<String, dynamic>>('worldstate'),
        ).thenReturn(Future.value(mockWorldstateMap));

        final result = await repository.fetchWorldstate();

        expect(result, isA<Worldstate>());
        verify(() => mockCacheManager.get<Map<String, dynamic>>('worldstate')).called(1);
        verifyNever(() => mockClient.get(any()));
      });

      test('fetches and caches worldstate when not cached', () async {
        when(() => mockCacheManager.get<Map<String, dynamic>>('worldstate')).thenReturn(null);
        when(() => mockCacheManager.get<Map<String, dynamic>>('drop_data')).thenReturn(Future.value(mockDropDataMap));
        when(() => mockCacheManager.set(any(), any(), ttl: any(named: 'ttl'))).thenAnswer((_) async {});
        when(() => mockClient.get(any())).thenAnswer(
          (_) async => response(mockWorldstateJson),
        );

        final result = await repository.fetchWorldstate();

        expect(result, isA<Worldstate>());
        verify(() => mockCacheManager.get<Map<String, dynamic>>('worldstate')).called(1);
        verify(() => mockCacheManager.get<Map<String, dynamic>>('drop_data')).called(1);
        verify(() => mockClient.get(any())).called(1);
        verify(() => mockCacheManager.set('worldstate', any(), ttl: any(named: 'ttl'))).called(1);
      });
    });

    group('fetchDropData', () {
      test('returns cached drop data when available', () async {
        when(() => mockCacheManager.get<Map<String, dynamic>>('drop_data')).thenReturn(Future.value(mockDropDataMap));

        final result = await repository.fetchSyndicateRewards();

        expect(result, isA<DropData>());
        verify(() => mockCacheManager.get<Map<String, dynamic>>('drop_data')).called(1);
        verifyNever(() => mockClient.get(any()));
      });

      // test('fetches and caches drop data when not cached', () async {
      //   when(() => mockCacheManager.get('drop_data')).thenReturn(null);
      //   when(() => mockCacheManager.set(any(), any(), ttl: any(named: 'ttl'))).thenAnswer((_) async {});

      // TODO(Orn): Mock the buildDropData function behavior
      // This will require you to mock the HTTP calls inside buildDropData
      // For simplicity, you might need to refactor to inject drop data

      //
      // This test would require more setup depending on buildDropData implementation
      // });
    });

    group('worldstateEmitter', () {
      test('emits worldstate periodically', () async {
        when(
          () => mockCacheManager.get<Map<String, dynamic>>('worldstate'),
        ).thenReturn(Future.value(mockWorldstateMap));

        final stream = repository.worldstateEmitter(tick: const Duration(milliseconds: 500));

        await expectLater(
          stream.take(1),
          emits(isA<Worldstate>()),
        );
      });
    });
  });
}
