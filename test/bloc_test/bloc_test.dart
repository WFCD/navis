import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:test/test.dart';

import 'assetBundle.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final client = MockClient();

  WorldstateBloc worldstateBloc;
  PlatformBloc platformBloc;
  ThemeBloc themeBloc;

  setUpAll(() {
    worldstateBloc = WorldstateBloc.initialize(client: client);
    platformBloc = PlatformBloc();
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
      final jsons = await DiskAssetBundle.loadGlob(['*.json']);
      final worldstate = await jsons.loadString('assets/worldstate.json');

      when(client.get('https://api.warframestat.us/pc'))
          .thenAnswer((_) async => http.Response(worldstate, 200));

      expectLater(
          worldstateBloc.state,
          emitsInOrder([
            const TypeMatcher<WorldstateUninitialized>(),
            const TypeMatcher<WorldstateLoaded>()
          ]));

      worldstateBloc.dispatch(UpdateState());
    });

    test('dispose does not create a new state', () {
      expectLater(worldstateBloc.state, emitsInOrder([]));

      worldstateBloc.dispose();
    });
  });

  group('Test Platform bloc', () {
    test('Initial state is Platform Uninitialized', () {
      expect(platformBloc.initialState, KDefaultState());
    });

    test('Make sure state changes with String and that it is a String',
        () async {
      final state = StreamQueue(platformBloc.state);
      expectLater(
          platformBloc.state,
          emitsInOrder([
            KDefaultState(),
            PCState(),
            PS4State(),
            Xb1State(),
            SwitchState()
          ]));

      platformBloc.dispatch(PCEvent());
      platformBloc.dispatch(PS4Event());
      platformBloc.dispatch(Xb1Event());
      platformBloc.dispatch(SwitchEvent());

      final platform = await state.next;
      expect(platform.platform, const TypeMatcher<String>());
    });

    test('dispose does not create a new state', () {
      expectLater(platformBloc.state, emitsInOrder([]));

      platformBloc.dispose();
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
