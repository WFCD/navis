import 'dart:convert' hide json;
import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

import 'fixtures/fixtures.dart';

class MockClient extends Mock implements Client {}

class MockBaseRequest extends Mock implements BaseRequest {}

StreamedResponse fakeResponse(String data) => StreamedResponse(Stream.value(utf8.encode(data)), 200);

void main() {
  late Client client;
  late WarframestatRepository repository;

  setUpAll(() async {
    registerFallbackValue(MockBaseRequest());
    registerFallbackValue(Uri());
    Hive.init(Directory.systemTemp.path);
  });

  setUp(() async {
    client = MockClient();
    repository = WarframestatRepository(client: client);
  });

  tearDown(() async {
    reset(client);
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

    test('fetch() => get worldstate', () async {
      when(() => client.send(any())).thenAnswer((_) async => fakeResponse(json));

      final state = await repository.fetchWorldstate();

      expect(state.timestamp.toIso8601String(), '2024-05-25T18:53:37.000Z');
    });

    test('fetch() => get worldstate from cache', () async {
      when(() => client.send(any())).thenAnswer((_) async => fakeResponse(json));

      await repository.fetchWorldstate();
      clearInteractions(client);

      final state = await repository.fetchWorldstate();

      expect(state.timestamp.toIso8601String(), '2024-05-25T18:53:37.000Z');
      verifyNever(() => client.send(any()));
    });
  });

  group('Item search', () {
    final fixture = Fixtures.itemsFixture;
    final items = toItems(fixture);
    final (uniqueName, name) = ('/Lotus/Powersuits/Dragon/ChromaPrime', 'Chroma Prime');

    final chroma = items.firstWhere((i) => i.uniqueName == uniqueName).toJson();

    String search(String query) {
      final results = items.where((i) => i.name.contains(query));
      return jsonEncode(results.map((i) => i.toJson()).toList());
    }

    test('fetch() => search item', () async {
      when(() => client.send(any())).thenAnswer((_) async => fakeResponse(search(name)));

      final items = await repository.searchItems(name);

      expect(items.isNotEmpty, true);
    });

    test('fetch() => get item', () async {
      when(() => client.send(any())).thenAnswer((_) async => fakeResponse(jsonEncode(chroma)));

      final item = await repository.fetchItem(uniqueName);

      expect(item?.name, name);
    });
  });
}
