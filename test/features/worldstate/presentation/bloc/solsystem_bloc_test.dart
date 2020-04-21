import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/domain/usecases/get_synth_targets.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:test/test.dart';
import 'package:wfcd_client/base.dart';

import '../../../../fixtures/fixture_reader.dart';

// ignore: must_be_immutable
class MockGetWorldstate extends Mock implements GetWorldstate {}

// ignore: must_be_immutable
class MockGetDarvoDealInfo extends Mock implements GetDarvoDealInfo {}

// ignore: must_be_immutable
class MockGetSynthTargets extends Mock implements GetSynthTargets {}

void main() {
  final tWorldstate = toWorldstate(fixture('worldstate.json'));
  final tSynthTargets = toTargets(fixture('synthTargets.json'));
  final tResults = toBaseItems(fixture('darvo_deal_test.json'));

  const tInstance = GetWorldstateInstance(GamePlatforms.pc, lang: null);

  GetWorldstate getWorldstate;
  GetDarvoDealInfo getDarvoDealInfo;
  GetSynthTargets getSynthTargets;

  SolsystemBloc solsystemBloc;

  setUp(() async {
    BlocSupervisor.delegate = await HydratedBlocDelegate.build(
      storageDirectory: Directory.systemTemp,
    );

    getWorldstate = MockGetWorldstate();
    getDarvoDealInfo = MockGetDarvoDealInfo();
    getSynthTargets = MockGetSynthTargets();

    solsystemBloc = SolsystemBloc(
      getWorldstate: getWorldstate,
      getDarvoDealInfo: getDarvoDealInfo,
      getSynthTargets: getSynthTargets,
    );

    when(getWorldstate(any)).thenAnswer((_) async => Right(tWorldstate));
    when(getDarvoDealInfo(any)).thenAnswer((_) async => Right(tResults.first));
    when(getSynthTargets(any)).thenAnswer((_) async => Right(tSynthTargets));
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

      verify(getWorldstate(tInstance));
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
