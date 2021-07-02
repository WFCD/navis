import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navis/features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/presentation/bloc/darvodeal_bloc.dart';
import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetDarvoDealInfo extends Mock implements GetDarvoDealInfo {}

class MockDealRequest extends Mock implements DealRequest {}

void main() {
  final dealFixture = fixture('darvo_deal.json');
  final worldstateFixture = fixture('worldstate.json');

  final tDeal = toBaseItems(json.decode(dealFixture) as List<dynamic>);
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

    registerFallbackValue(MockDealRequest());
  });

  tearDownAll(() {
    darvodealBloc
      ..clear()
      ..close();
  });
  test('InitialState should be SolsystemInitial', () {
    expect(darvodealBloc.state, equals(DarvodealInitial()));
  });

  test('Test should retrieve the test deal model', () async {
    when(() => getDarvoDealInfo(any()))
        .thenAnswer((_) async => Ok(tDeal.first));

    darvodealBloc.add(LoadDarvodeal(tWorldstate.dailyDeals.first));

    await untilCalled(() => getDarvoDealInfo(any()));
    await Future.delayed(const Duration(seconds: 1));

    verify(() => getDarvoDealInfo(any()));
    expect(darvodealBloc.state, DarvoDealLoaded(tDeal.first));
  });

  test(
    'Test to make sure the deal was saved into the Hydrated hive box',
    () async {
      when(() => getDarvoDealInfo(any()))
          .thenAnswer((_) async => Ok(tDeal.first));

      darvodealBloc.add(LoadDarvodeal(tWorldstate.dailyDeals.first));
      await Future.delayed(const Duration(seconds: 1));

      final cached = HydratedBloc.storage.read(darvodealBloc.storageToken)
          as Map<String, dynamic>;

      final deal = toBaseItem(cached['items'] as Map<String, dynamic>);

      expect(deal.uniqueName, tDeal.first.uniqueName);
    },
  );
}
