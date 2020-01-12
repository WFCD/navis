import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/repository/api/worldstate_repository.dart';
import 'package:navis/utils/enums.dart';
// import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import '../mock_classes.dart';

void main() {
  const worldstate = Worldstate();

  WorldstateRepository api;
  WorldstateBloc worldstateBloc;

  setUpAll(() async {
    final directory = await Directory.systemTemp.createTemp();
    BlocSupervisor.delegate =
        await HydratedBlocDelegate.build(storageDirectory: directory);

    api = MockWorldstateRepository();
    worldstateBloc = WorldstateBloc(api);
  });

  test('Enusre that Worldstate is Loaded', () async {
    when(api.getWorldstate(Platforms.pc))
        .thenAnswer((_) async => Future.value(worldstate));

    worldstateBloc.update();

    await Future.delayed(const Duration(milliseconds: 900));

    expectLater(worldstateBloc.state, const WorldstateLoadSuccess(worldstate));
  });
}
