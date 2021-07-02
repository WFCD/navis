import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/presentation/bloc/darvodeal_bloc.dart';
import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetDarvoDealInfo extends Mock implements GetDarvoDealInfo {}

void main() {
  final dealFixture = fixture('darvo_deal.json');
  final worldstateFixture = fixture('worldstate.json');

  final tDeal =
      toBaseItems(json.decode(dealFixture) as List<Map<String, dynamic>>);
  final tWorldstate =
      toWorldstate(json.decode(worldstateFixture) as Map<String, dynamic>);

  late GetDarvoDealInfo getDarvoDealInfo;
  late DarvodealBloc darvodealBloc;

  setUpAll(() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: Directory.systemTemp,
    );

    getDarvoDealInfo = MockGetDarvoDealInfo();
    darvodealBloc = DarvodealBloc(getDarvoDealInfo: getDarvoDealInfo);
  });

  tearDownAll(() {
    darvodealBloc
      ..clear()
      ..close();
  });
  test('InitialState should be SolsystemInitial', () {
    expect(darvodealBloc.state, equals(DarvodealInitial()));
  });

  // test('Test should retrieve the test deal model', () async {
  //   when(() => getDarvoDealInfo(any())).thenAnswer((_) async => Ok(tDeal));

  //   darvodealBloc.add(LoadDarvodeal(tWorldstate.dailyDeals.first));

  //   //TODO: need a more specfic item to compare with
  //   await untilCalled(() => getDarvoDealInfo(any()));

  //   verify(() => getDarvoDealInfo(any()));
  //   expect(darvodealBloc.state, DarvoDealLoaded(tDeal));
  // });
}
