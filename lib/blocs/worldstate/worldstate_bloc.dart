import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wfcd_api_wrapper/wfcd_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'worldstate_events.dart';
import 'worldstate_states.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldStates> {
  WorldstateBloc({this.api, this.persistent});

  final WfcdWrapper api;
  final PersistentStorageService persistent;

  @override
  WorldStates get initialState =>
      super.initialState ?? WorldstateUninitialized();

  @override
  Stream<WorldStates> transformEvents(Stream<WorldstateEvent> events,
      Stream<WorldStates> Function(UpdateEvent event) next) {
    return super.transformEvents(
        Observable<WorldstateEvent>(events)
            .debounceTime(const Duration(milliseconds: 400)),
        next);
  }

  @override
  Stream<WorldStates> mapEventToState(WorldstateEvent event) async* {
    if (event is UpdateEvent) {
      try {
        final _platform = persistent?.platform ?? Platforms.pc;
        final worldstate = await api.getWorldstate(_platform);

        yield WorldstateLoaded(cleanState(worldstate));
      } catch (e) {
        yield WorldstateError(e);
      }
    }
  }

  Future<void> update() async {
    add(UpdateEvent());
    await Future.delayed(const Duration(milliseconds: 500));
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
