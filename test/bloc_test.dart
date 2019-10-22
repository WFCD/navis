import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'mocked_classes.dart';
import 'setup_methods.dart';

void main() {
  final worldstateJson = File('test/worldstate.json').readAsStringSync();
  final worldstate = Worldstate.fromJson(json.decode(worldstateJson));
  final api = MockWorldstateService();

  SearchBloc searchBloc;
  WorldstateBloc worldstateBloc;

  setUpAll(() async {
    await setupPackageMockMethods();

    BlocSupervisor.delegate = await HydratedBlocDelegate.build();

    searchBloc = MockSearchBloc();
    worldstateBloc = MockWorldstateBloc();
  });

  group('WorldstateBloc group', () {
    test('Enusre that Worldstate is Loaded', () async {
      whenListen(
          worldstateBloc, Stream.fromIterable([WorldstateLoaded(worldstate)]));

      expectLater(worldstateBloc,
          emitsInOrder(<WorldStates>[WorldstateLoaded(worldstate)]));
    });

    test('Make sure nothing is emited after closing', () {
      worldstateBloc.close();
      expectLater(worldstateBloc, emitsInOrder([emitsDone]));
    });
  });
}
