import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_remote.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';

// ignore: must_be_immutable
class MockGetWorldstate extends Mock implements GetWorldstate {}

void main() {
  GetWorldstate getWorldstate;
  SolsystemBloc solsystemBloc;

  setUp(() async {
    BlocSupervisor.delegate = await HydratedBlocDelegate.build(
      storageDirectory: Directory.systemTemp,
    );

    getWorldstate = MockGetWorldstate();
    solsystemBloc = SolsystemBloc(worldstate: getWorldstate);
  });

  tearDown(() {
    solsystemBloc.close();
  });

  test('initialState should be [SolsystemInitial]', () {
    expect(solsystemBloc.initialState, equals(SolsystemInitial()));
  });

  group('getWorldstate', () {
    final tWorldstate = toWorldstate(fixture('worldstate.json'));

    setUp(() {
      when(getWorldstate(any)).thenAnswer((_) async => Right(tWorldstate));
    });

    test('should call getWorldstate', () async {
      solsystemBloc.add(const SolupdateSystem(GamePlatforms.pc));
      await untilCalled(getWorldstate(any));

      verify(getWorldstate(GamePlatforms.pc));
    });
  });
}
