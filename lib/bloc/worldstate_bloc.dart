import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/repositories/repositories.dart';
import 'package:navis/utils/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import './bloc.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldstateState> {
  WorldstateBloc(this.worldstateRepository);

  final WorldstateRepository worldstateRepository;

  Platforms _platform;

  @override
  WorldstateState get initialState {
    return super.initialState ?? InitialWorldstateState();
  }

  @override
  Stream<WorldstateState> mapEventToState(
    WorldstateEvent event,
  ) async* {
    if (event is Updated) yield WorldstateLoadSuccess(event.worldstate);

    if (event is UpdatedPlatform) {
      _platform = event.platform;
      await updateWorldstate();
    }
  }

  Future<void> updateWorldstate() async {
    try {
      final state =
          await worldstateRepository.getWorldstate(_platform ?? Platforms.pc);

      add(Updated(state));
    } catch (error) {
      add(Failed(error));
    }
  }

  @override
  WorldstateState fromJson(Map<String, dynamic> json) {
    final state = Worldstate.fromJson(json);

    return WorldstateLoadSuccess(state);
  }

  @override
  Map<String, dynamic> toJson(WorldstateState state) {
    if (state is WorldstateLoadSuccess) return state.worldstate.toJson();

    return null;
  }
}
