import 'dart:convert';
import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:oxidized/oxidized.dart';
import 'package:test/test.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetWorldstate extends Mock implements GetWorldstate {}

void main() {
  final worldstateFixture = fixture('worldstate.json');
  final tWorldstate =
      toWorldstate(json.decode(worldstateFixture) as Map<String, dynamic>);

  late GetWorldstate getWorldstate;

  late SolsystemBloc solsystemBloc;

  setUpAll(() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: Directory.systemTemp,
    );

    getWorldstate = MockGetWorldstate();

    solsystemBloc = SolsystemBloc(getWorldstate: getWorldstate);

    when(() => getWorldstate(any())).thenAnswer((_) async => Ok(tWorldstate));
  });

  tearDownAll(() {
    solsystemBloc.close();
    HydratedBloc.storage.clear();
  });

  test('initialState should be [SolsystemInitial]', () {
    expect(solsystemBloc.state, equals(SolsystemInitial()));
  });

  test('should sync solsystem status', () async {
    await solsystemBloc.update();
    await untilCalled(() => getWorldstate(any()));

    verify(() => getWorldstate(false));

    await solsystemBloc.update(forceUpdate: true);
    await untilCalled(() => getWorldstate(any()));

    verify(() => getWorldstate(true));
  });
}
