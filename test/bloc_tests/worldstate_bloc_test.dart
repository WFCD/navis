import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../mock_classes.dart';
import '../setup_methods.dart';

void main() {
  final worldstateJson = File('./worldstate.json').readAsStringSync();
  final worldstate = WorldstateModel.fromJson(json.decode(worldstateJson));
  final storage = PersistentStorageService();
  final cache = CacheStorageService();

  WarframestatClient api;
  WorldstateBloc worldstateBloc;

  setUpAll(() async {
    await mockSetup();

    api = MockWarframestatRemote();

    await storage.startInstance();
    await cache.startInstance();

    worldstateBloc =
        WorldstateBloc(api: api, persistent: storage, cache: cache);
  });

  test('Enusre that Worldstate is Loaded', () async {
    when(api.getWorldstate(any, language: anyNamed('language')))
        .thenAnswer((_) async => Future.value(worldstate));

    worldstateBloc.add(UpdateEvent());

    await Future.delayed(const Duration(milliseconds: 900));

    expectLater(worldstateBloc.state, WorldstateLoaded(worldstate));
  });
}
