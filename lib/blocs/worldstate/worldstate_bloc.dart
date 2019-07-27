import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worldstate_model/worldstate_models.dart';

import '../../services/repository.dart';
import 'worldstate_states.dart';

enum UpdateEvent { update }

class WorldstateBloc extends HydratedBloc<UpdateEvent, WorldStates> {
  WorldstateBloc(this.repository);

  final Repository repository;

  @override
  WorldStates get initialState =>
      super.initialState ?? WorldstateUninitialized();

  @override
  Stream<WorldStates> transform(Stream<UpdateEvent> events,
      Stream<WorldStates> Function(UpdateEvent event) next) {
    return super.transform(
        Observable(events).debounceTime(const Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<WorldStates> mapEventToState(UpdateEvent event) async* {
    if (event == UpdateEvent.update) {
      try {
        final state = await repository.getWorldstate();
        yield WorldstateLoaded(state);
      } catch (e) {
        yield WorldstateError(e.toString());
      }
    }
  }

  Future<void> update() async {
    dispatch(UpdateEvent.update);
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  WorldStates fromJson(Map<String, dynamic> json) {
    return WorldstateLoaded(Worldstate.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(WorldStates state) {
    return state.worldstate != null ? state.worldstate.toJson() : null;
  }
}
