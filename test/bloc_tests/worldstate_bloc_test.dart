import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:navis/services/worldstate_service.dart';
import 'package:worldstate_model/worldstate_models.dart';

import '../setup_methods.dart';

class MockWorldstateService extends Mock implements WorldstateService {}

void main() {
  final worldstateJson = File('./worldstate.json').readAsStringSync();
  final worldstate = Worldstate.fromJson(json.decode(worldstateJson));

  WorldstateService api;
  WorldstateBloc worldstateBloc;

  setUpAll(() async {
    await mockSetup();

    api = MockWorldstateService();
    worldstateBloc = WorldstateBloc(api);
  });

  test('Enusre that Worldstate is Loaded', () async {
    when(api.getWorldstate()).thenAnswer((_) => Future.value(worldstate));

    worldstateBloc.add(UpdateEvent());

    await Future.delayed(const Duration(milliseconds: 900));

    expectLater(worldstateBloc.state, WorldstateLoaded(worldstate));
  });
}
