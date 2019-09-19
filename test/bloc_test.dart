import 'dart:convert';
import 'dart:io'; //ignore: unused_import

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:test/test.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'mocked_classes.dart';
import 'setup_methods.dart';

Future<void> main() async {
  final mockWorldstateService = MockWorldstateService();
  // final mockLocalStorageService = MockLocalStrorageService();
  // final mockNotificationService = MockNotificationService();

  // Repository repository;
  WorldstateBloc worldstate;
  // Box prefs;

  setUpAll(() async {
    await setupPackageMockMethods();

    BlocSupervisor.delegate = await HydratedBlocDelegate.build();

    // repository = await Repository.initRepository();

    worldstate = WorldstateBloc(mockWorldstateService);
    // prefs = await Hive.openBox('settings');
  });

  group('Test Worldstate bloc', () {
    test('Initial state is Worldstate Uninitialized', () {
      expect(worldstate.initialState, WorldstateUninitialized());
    });

    test('Worldstate is loaded correctly', () async {
      when(mockWorldstateService.getWorldstate()).thenAnswer((_) async {
        final data = json.decode(await File('worldstate.json').readAsString());

        return Worldstate.fromJson(data);
      });

      worldstate.dispatch(UpdateEvent());

      expectLater(worldstate.state,
          emitsThrough(const TypeMatcher<WorldstateLoaded>()));
    });

    test('dispose does not create a new state', () {
      expectLater(worldstate.state, emitsInOrder([]));

      worldstate.dispose();
    });
  });

  // group('Storage bloc related test', () {
  //   test('Test dateformat dd_mm_yy', () async {
  //     final format = await testDateformat(storage, Formats.dd_mm_yy, prefs);

  //     expect(format, Formats.dd_mm_yy);
  //   });

  //   test('Test dateformat mm_dd_yy', () async {
  //     final format = await testDateformat(storage, Formats.mm_dd_yy, prefs);

  //     expect(format, Formats.mm_dd_yy);
  //   });

  //   test('Test dateformat month_day_year', () async {
  //     final format =
  //         await testDateformat(storage, Formats.month_day_year, prefs);

  //     expect(format, Formats.month_day_year);
  //   });

  //   // The default is pc so just need to make sure any other platform can be saved.
  //   test('Nintendo Switch', () async {
  //     final storedPlatform = await testStorage(storage, Platforms.swi, prefs);

  //     expect(storedPlatform, Platforms.swi);
  //   });

  //   test('Playstation 4', () async {
  //     final storedPlatform = await testStorage(storage, Platforms.ps4, prefs);

  //     expect(storedPlatform, Platforms.ps4);
  //   });

  //   test('Xbox one', () async {
  //     final storedPlatform = await testStorage(storage, Platforms.xb1, prefs);

  //     expect(storedPlatform, Platforms.xb1);
  //   });

  //   test('PC', () async {
  //     final storedPlatform = await testStorage(storage, Platforms.pc, prefs);

  //     expect(storedPlatform, Platforms.pc);
  //   });
  // });
}

// Future<Platforms> testStorage(
//   StorageBloc storage,
//   Platforms platform,
//   Box prefs,
// ) async {
//   storage.dispatch(ChangePlatformEvent(platform));

//   await Future.delayed(const Duration(milliseconds: 500));

//   return Platforms.values.firstWhere((p) =>
//       p.toString() == 'Platforms.${prefs.get(SettingsKeys.platformKey)}');
// }

// Future<Formats> testDateformat(
//   StorageBloc storage,
//   Formats format,
//   Box prefs,
// ) async {
//   storage.dispatch(ChangeDateFormat(format));

//   await Future.delayed(const Duration(milliseconds: 500));

//   return Formats.values.firstWhere((f) =>
//       f.toString() == 'Formats.${prefs.get(SettingsKeys.dateformatKey)}');
// }
