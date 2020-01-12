import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/repository/repositories.dart';
import 'package:navis/utils/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'worldstate_events.dart';
import 'worldstate_states.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldStates> {
  WorldstateBloc(this.worldstateRepository);

  final WorldstateRepository worldstateRepository;

  Platforms _platform;

  @override
  WorldStates get initialState {
    return super.initialState ?? InitialWorldStates();
  }

  @override
  Stream<WorldStates> mapEventToState(
    WorldstateEvent event,
  ) async* {
    if (event is Updated) yield WorldstateLoadSuccess(event.worldstate);

    if (event is UpdatedPlatform) {
      _platform = event.platform;
      await update();
    }
  }

  Future<void> update() async {
    try {
      final state =
          await worldstateRepository.getWorldstate(_platform ?? Platforms.pc);

      add(Updated(state));
    } catch (error) {
      add(Failed(error));
    }
  }

  @override
  WorldStates fromJson(Map<String, dynamic> json) {
    final state = Worldstate.fromJson(json);

    return WorldstateLoadSuccess(state);
  }

  @override
  Map<String, dynamic> toJson(WorldStates state) {
    if (state is WorldstateLoadSuccess) return state.worldstate.toJson();

    return null;
  }
}
