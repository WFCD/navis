import 'dart:convert';
import 'dart:io';

//import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/utils/enums.dart';
import 'package:navis/utils/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

Future<void> main() async {
  final client = MockClient();

  WorldstateBloc worldstate;
  StorageBloc storage;
  SharedPreferences prefs;

  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp();

    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{}; // set initial values here if desired
      }
      return null;
    });

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });

    BlocSupervisor.delegate = await HydratedBlocDelegate.build();

    await setupLocator(client: client, isTest: true);

    worldstate = WorldstateBloc();
    storage = StorageBloc(instance: await LocalStorageService.getInstance());
    prefs = await SharedPreferences.getInstance();
  });

  group('Test Worldstate bloc', () {
    test('Initial state is Worldstate Uninitialized', () {
      expect(worldstate.initialState,
          const TypeMatcher<WorldstateUninitialized>());
    });

    test('Worldstate is loaded correctly', () async {
      when(client.get('https://api.warframestat.us/pc'))
          .thenAnswer((_) async => http.Response(json.encode(mockstate), 200));

      expectLater(
          worldstate.state,
          emitsInOrder([
            const TypeMatcher<WorldstateUninitialized>(),
            const TypeMatcher<WorldstateLoaded>()
          ]));

      worldstate.dispatch(UpdateEvent.update);
    });

    test('dispose does not create a new state', () {
      expectLater(worldstate.state, emitsInOrder([]));

      worldstate.dispose();
    });
  });

  group('Storage bloc related test', () {
    test('Test Dark Mode Toggle', () async {
      storage.dispatch(ToggleDarkMode(enableDark: false));

      // wait for shared_prefs to actually save fisrt
      await Future.delayed(const Duration(milliseconds: 500));

      expect(prefs.getBool(darkModeKey), false);
    });
  });

  test('Make sure platform saves', () async {
    // the default is pc so just need to make sure any other platform can be saved.
    storage.dispatch(ChangePlatformEvent(Platforms.swi));

    await Future.delayed(const Duration(milliseconds: 500));

    final Platforms storedPlatform = Platforms.values.firstWhere(
        (p) => p.toString() == 'Platforms.${prefs.getString(platformKey)}');

    expect(storedPlatform, Platforms.swi);
  });
}
