import 'dart:convert';

//import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

const mockstate = {
  'news': [],
  'alerts': [],
  'syndicateMissions': [],
  'fissures': [],
  'invasions': [],
  'persistentEnemies': []
};

void main() {
  final client = MockClient();

  WorldstateBloc worldstateBloc;
  //StorageBloc platformBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    worldstateBloc = WorldstateBloc.initialize(client: client);
    //platformBloc = StorageBloc();
    themeBloc = ThemeBloc();

    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{};
      }
      return null;
    });
  });

  group('Test Worldstate bloc', () {
    test('Initial state is Worldstate Uninitialized', () {
      expect(worldstateBloc.initialState,
          const TypeMatcher<WorldstateUninitialized>());
    });

    test('Worldstate is loaded correctly', () async {
      when(client.get('https://api.warframestat.us/pc'))
          .thenAnswer((_) async => http.Response(json.encode(mockstate), 200));

      expectLater(
          worldstateBloc.state,
          emitsInOrder([
            const TypeMatcher<WorldstateUninitialized>(),
            const TypeMatcher<WorldstateLoaded>()
          ]));

      worldstateBloc.dispatch(UpdateEvent.update);
    });

    test('dispose does not create a new state', () {
      expectLater(worldstateBloc.state, emitsInOrder([]));

      worldstateBloc.dispose();
    });
  });

  group('Test Theme bloc', () {
    test('Initial state is ThemeState with no themeData', () {
      expect(themeBloc.initialState, const TypeMatcher<ThemeState>());
    });

    test('dispose does not create a new state', () {
      expectLater(themeBloc.state, emitsInOrder([]));

      themeBloc.dispose();
    });
  });
}
