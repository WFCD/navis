import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wfcd_client/clients.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'worldstate_events.dart';
import 'worldstate_states.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldStates> {
  WorldstateBloc({this.api, this.persistent});

  final WorldstateClient api;
  final PersistentStorageService persistent;

  @override
  WorldStates get initialState =>
      super.initialState ?? WorldstateUninitialized();

  @override
  Stream<WorldStates> transformEvents(Stream<WorldstateEvent> events,
      Stream<WorldStates> Function(UpdateEvent event) next) {
    return super.transformEvents(
        Observable<WorldstateEvent>(events)
            .debounceTime(const Duration(milliseconds: 200)),
        next);
  }

  @override
  Stream<WorldStates> mapEventToState(WorldstateEvent event) async* {
    if (event is UpdateEvent) {
      try {
        final _platform = persistent?.platform ?? Platforms.pc;
        final worldstate = await api.getWorldstate(_platform);

        yield WorldstateLoaded(cleanState(worldstate));
      } catch (exception, stack) {
        Crashlytics.instance.recordError(exception, stack);
        yield WorldstateError(exception);
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
