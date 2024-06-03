import 'dart:convert' hide json;
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

import 'fixtures/fixtures.dart';

class MockClient extends Mock implements Client {}

class MockBaseRequest extends Mock implements BaseRequest {}

class MockBox extends Mock implements Box<Map<dynamic, dynamic>> {}

StreamedResponse fakeResponse(String data) =>
    StreamedResponse(Stream.value(utf8.encode(data)), 200);

void main() {
  late Client client;
  late Box<Map<dynamic, dynamic>> testBox;
  late WarframestatRepository repository;

  setUpAll(() async {
    registerFallbackValue(MockBaseRequest());
    registerFallbackValue(Uri());
    Hive.init(Directory.systemTemp.path);
  });

  setUp(() async {
    client = MockClient();
    testBox = MockBox();
    repository = WarframestatRepository(cache: testBox, client: client);
  });

  tearDown(() async {
    reset(client);
    reset(testBox);
  });

  group('Language', () {
    test('get => Language.en', () => expect(repository.language, Language.en));

    test('set => Language.es', () {
      repository.language = Language.es;

      expect(repository.language, Language.es);
    });
  });

  group('Worldstate', () {
    final fixture = Fixtures.worldstateFixture;
    final json = jsonEncode(fixture);
    final bytes = utf8.encode(json);

    test('fetch() => get worldstate and cache', () async {
      when(() => client.send(any()))
          .thenAnswer((_) async => fakeResponse(json));
      when(() => testBox.put('worldstate_en', any())).thenAnswer((_) async {});

      final state = await repository.fetchWorldstate();

      expect(state.timestamp.toIso8601String(), '2024-05-25T18:53:37.000Z');
      verify(() => testBox.put('worldstate_en', any()));
    });

    test('fetch() => from cache', () async {
      when(() => testBox.get('worldstate_en')).thenAnswer(
        (_) => {
          'expiry': DateTime.timestamp().add(const Duration(minutes: 3)),
          'data': bytes,
        },
      );

      final state = await repository.fetchWorldstate();

      expect(state.timestamp.toIso8601String(), '2024-05-25T18:53:37.000Z');
      verifyNever(() => client.send(any()));
    });
  });

  group('Deal info', () {
    final fixture = Fixtures.itemsFixture;
    final json = jsonEncode(fixture);
    final bytes = utf8.encode(json);

    test('fetch() => get item and cache', () async {
      when(() => client.send(any()))
          .thenAnswer((_) async => fakeResponse(json));
      when(() => testBox.put('deal_en', any())).thenAnswer((_) async {});

      final deal = await repository.fetchDealInfo(
        '/Lotus/Powersuits/Dragon/ChromaPrime',
        'Chroma Prime',
      );

      expect(deal, isNotNull);
      expect(deal!.uniqueName, '/Lotus/Powersuits/Dragon/ChromaPrime');
      expect(deal.name, 'Chroma Prime');
      verify(() => testBox.put('deal_en', any()));
    });

    test('fetch() => from cache', () async {
      when(() => testBox.get('deal_en')).thenAnswer(
        (_) => {
          'expiry': DateTime.timestamp().add(const Duration(hours: 24)),
          'data': bytes,
        },
      );

      final deal = await repository.fetchDealInfo(
        '/Lotus/Powersuits/Dragon/ChromaPrime',
        'Chroma Prime',
      );

      expect(deal, isNotNull);
      expect(deal!.uniqueName, '/Lotus/Powersuits/Dragon/ChromaPrime');
      expect(deal.name, 'Chroma Prime');
      verifyNever(() => client.send(any()));
    });
  });

  group('Item search', () {
    final fixture = Fixtures.itemsFixture;
    final items = toItems(fixture);
    final (uniqueName, name) =
        ('/Lotus/Powersuits/Dragon/ChromaPrime', 'Chroma Prime');

    final chroma = items.firstWhere((i) => i.uniqueName == uniqueName).toJson();

    String search(String query) {
      final results = items.where((i) => i.name.contains(query));
      return jsonEncode(results.map((i) => i.toJson()).toList());
    }

    test('fetch() => search item', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => Response(
          search(name),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final items = await repository.searchItems(name);

      expect(items.isNotEmpty, true);
      verifyNever(() => testBox.put(any<String>(), any()));
    });

    test('fetch() => get item', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => Response(
          jsonEncode(chroma),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final item = await repository.fetchItem(uniqueName);

      expect(item.name, name);
      verifyNever(() => testBox.put(any<String>(), any()));
    });
  });
}
