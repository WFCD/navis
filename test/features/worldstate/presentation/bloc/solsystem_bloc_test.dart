import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:test/test.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../fixtures/fixture_reader.dart';

// ignore: must_be_immutable
class MockGetWorldstate extends Mock implements GetWorldstate {}

// ignore: must_be_immutable
class MockGetDarvoDealInfo extends Mock implements GetDarvoDealInfo {}

void main() {
  final worldstateFixture = fixture('worldstate.json');
  final resultsFixture = fixture('darvo_deal_test.json');

  final tWorldstate =
      toWorldstate(json.decode(worldstateFixture) as Map<String, dynamic>);

  final tResults = toBaseItems(json.decode(resultsFixture) as List<dynamic>);

  GetWorldstate getWorldstate;
  GetDarvoDealInfo getDarvoDealInfo;

  SolsystemBloc solsystemBloc;

  setUp(() async {
    BlocSupervisor.delegate = await HydratedBlocDelegate.build(
      storageDirectory: Directory.systemTemp,
    );

    getWorldstate = MockGetWorldstate();
    getDarvoDealInfo = MockGetDarvoDealInfo();

    solsystemBloc = SolsystemBloc(
      getWorldstate: getWorldstate,
      getDarvoDealInfo: getDarvoDealInfo,
    );

    when(getWorldstate(any)).thenAnswer((_) async => Right(tWorldstate));
    when(getDarvoDealInfo(any)).thenAnswer((_) async => Right(tResults.first));
  });

  tearDown(() {
    solsystemBloc.close();
  });

  test('initialState should be [SolsystemInitial]', () {
    expect(solsystemBloc.initialState, equals(SolsystemInitial()));
  });

  group('update system status', () {
    test('should sync solsystem status', () async {
      solsystemBloc.add(const SyncSystemStatus(GamePlatforms.pc));
      await untilCalled(getWorldstate(any));

      verify(getWorldstate(NoParama()));
    });
  });

  // group('retrive darvo deal information', () {
  //   test('should search a BaseItem instance based on the current daily deal',
  //       () async {
  //     solsystemBloc.add(const SyncSystemStatus(GamePlatforms.pc));
  //     await untilCalled(getDarvoDealInfo(any));

  //     await Future<void>.delayed(300.milliseconds);
  //     verify(getDarvoDealInfo(any));
  //   });
  // });
}
