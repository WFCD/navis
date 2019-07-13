import 'dart:async';

import 'package:catcher/catcher_plugin.dart';
import 'package:codable/codable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/models/export.dart';

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

  @override
  void onError(Object error, StackTrace stacktrace) {
    Catcher.reportCheckedError(error, stacktrace);
  }

  Future<void> update() async {
    dispatch(UpdateEvent.update);
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  WorldStates fromJson(Map<String, dynamic> json) {
    final key = KeyedArchive.unarchive(json);
    final worldstate = Worldstate()..decode(key);

    return WorldstateLoaded(worldstate);
  }

  @override
  Map<String, dynamic> toJson(WorldStates state) {
    return state.worldstate != null
        ? KeyedArchive.archive(state.worldstate)
        : null;
  }
}
