import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/services/wfcd_api.dart';
import 'package:navis/utils/enums.dart';
import 'package:navis/utils/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'setup_methods.dart';

Map<String, dynamic> mockstate = {
  'news': [],
  'alerts': [],
  'syndicateMissions': [],
  'fissures': [],
  'invasions': [],
  'persistentEnemies': []
};

Future<void> main() async {
  WFCD wfcd;

  WorldstateBloc worldstate;
  StorageBloc storage;
  SharedPreferences prefs;

  setUpAll(() async {
    await setupPackageMockMethods();
    await setupLocator();

    BlocSupervisor.delegate = await HydratedBlocDelegate.build();

    worldstate = WorldstateBloc();
    storage = StorageBloc(instance: await LocalStorageService.getInstance());
    prefs = await SharedPreferences.getInstance();
    wfcd = locator<WFCD>();
  });

  group('Test Worldstate bloc', () {
    test('Initial state is Worldstate Uninitialized', () {
      expect(worldstate.initialState,
          const TypeMatcher<WorldstateUninitialized>());
    });

    test('Worldstate is loaded correctly', () async {
      wfcd.warframestat.interceptors.add(InterceptorsWrapper(
          onRequest: (option) => wfcd.warframestat.resolve(mockstate)));

      worldstate.dispatch(UpdateEvent.update);

      expectLater(
          worldstate.state,
          emitsInOrder([
            const TypeMatcher<WorldstateUninitialized>(),
            const TypeMatcher<WorldstateLoaded>()
          ]));
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
