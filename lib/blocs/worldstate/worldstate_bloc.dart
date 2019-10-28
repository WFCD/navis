import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/services/worldstate_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'worldstate_events.dart';
import 'worldstate_states.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldStates> {
  WorldstateBloc(this.api);

  final WorldstateService api;

  @override
  WorldStates get initialState =>
      super.initialState ?? WorldstateUninitialized();

  @override
  Stream<WorldStates> transformEvents(Stream<WorldstateEvent> events,
      Stream<WorldStates> Function(UpdateEvent event) next) {
    return super.transformEvents(
        (events as Observable<WorldstateEvent>)
            .debounceTime(const Duration(milliseconds: 350)),
        next);
  }

  @override
  Stream<WorldStates> mapEventToState(WorldstateEvent event) async* {
    if (event is UpdateEvent) {
      try {
        final state = await api.getWorldstate();
        yield WorldstateLoaded(state);
      } catch (e) {
        yield WorldstateError(e);
      }
    }
  }

  Future<void> update() async {
    add(UpdateEvent());
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  WorldStates fromJson(Map<String, dynamic> json) {
    return WorldstateLoaded(json as Worldstate);
  }

  @override
  Map<String, dynamic> toJson(WorldStates state) {
    return state.worldstate?.toJson();
  }
}
