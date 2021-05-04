import 'dart:convert';
import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navis/features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:oxidized/oxidized.dart';
import 'package:test/test.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../fixtures/fixture_reader.dart';

// ignore: must_be_immutable
class MockGetWorldstate extends Mock implements GetWorldstate {}

// ignore: must_be_immutable
class MockGetDarvoDealInfo extends Mock implements GetDarvoDealInfo {}

class DealRequestFake extends Mock implements DealRequest {}

void main() {
  final worldstateFixture = fixture('worldstate.json');
  final resultsFixture = fixture('darvo_deal_test.json');

  final tWorldstate =
      toWorldstate(json.decode(worldstateFixture) as Map<String, dynamic>);

  final tResults = toBaseItems(json.decode(resultsFixture) as List<dynamic>);

  late GetWorldstate getWorldstate;
  late GetDarvoDealInfo getDarvoDealInfo;

  late SolsystemBloc solsystemBloc;

  setUpAll(() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: Directory.systemTemp,
    );

    getWorldstate = MockGetWorldstate();
    getDarvoDealInfo = MockGetDarvoDealInfo();

    solsystemBloc = SolsystemBloc(getWorldstate: getWorldstate);

    registerFallbackValue<DealRequest>(DealRequestFake());

    when(() => getWorldstate(any())).thenAnswer((_) async => Ok(tWorldstate));
    when(() => getDarvoDealInfo(any()))
        .thenAnswer((_) async => Ok(tResults.first));
  });

  tearDown(() {
    solsystemBloc.close();
  });

  // test('initialState should be [SolsystemInitial]', () async {
  //   expect(solsystemBloc.state, equals(SolsystemInitial()));
  // });

  test('should sync solsystem status', () async {
    solsystemBloc.add(const SyncSystemStatus());
    await untilCalled(() => getWorldstate(any()));

    verify(() => getWorldstate(false));
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
