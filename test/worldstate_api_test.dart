import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/export.dart';
import 'package:navis/services/worldstate.dart';
import 'package:navis/utils/enums.dart';
import 'package:test/test.dart';

const mockstate = {
  'news': [],
  'alerts': [],
  'syndicateMissions': [],
  'fissures': [],
  'invasions': [],
  'persistentEnemies': []
};

class MockClient extends Mock implements http.Client {}

void main() {
  final client = MockClient();

  WorldstateAPI worldstateApi;

  setUpAll(() {
    worldstateApi = WorldstateAPI();
  });

  group('Test Worldstate APi', () {
    test('Test PC endpoint', () async {
      when(client.get('https://api.warframestat.us/pc'))
          .thenAnswer((_) async => http.Response(json.encode(mockstate), 200));

      final state =
          await worldstateApi.getWorldstate(Platforms.pc, client: client);

      expect(state, const TypeMatcher<WorldState>());
    });

    test('Test PS4 endpoint', () async {
      when(client.get('https://api.warframestat.us/ps4'))
          .thenAnswer((_) async => http.Response(json.encode(mockstate), 200));

      final state =
          await worldstateApi.getWorldstate(Platforms.ps4, client: client);

      expect(state, const TypeMatcher<WorldState>());
    });

    test('Test Xbox one endpoint', () async {
      when(client.get('https://api.warframestat.us/xb1'))
          .thenAnswer((_) async => http.Response(json.encode(mockstate), 200));

      final state =
          await worldstateApi.getWorldstate(Platforms.xb1, client: client);

      expect(state, const TypeMatcher<WorldState>());
    });

    test('Test Switch endpoint', () async {
      when(client.get('https://api.warframestat.us/swi'))
          .thenAnswer((_) async => http.Response(json.encode(mockstate), 200));

      final state =
          await worldstateApi.getWorldstate(Platforms.swi, client: client);

      expect(state, const TypeMatcher<WorldState>());
    });
  });
}
