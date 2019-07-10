import 'dart:async';

import 'package:catcher/catcher_plugin.dart';
import 'package:codable/codable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';

import '../../global_keys.dart';
import '../../services/wfcd_repository.dart';
import 'worldstate_states.dart';

enum UpdateEvent { update }

class WorldstateBloc extends HydratedBloc<UpdateEvent, WorldStates>
    with EquatableMixinBase, EquatableMixin {
  final instance = locator<LocalStorageService>();
  final ws = locator<WfcdRepository>();

  @override
  WorldStates get initialState =>
      super.initialState ?? WorldstateUninitialized();

  @override
  Stream<WorldStates> transform(Stream<UpdateEvent> events,
      Stream<WorldStates> Function(UpdateEvent event) next) {
    return super.transform(Observable(events).distinct(), next);
  }

  @override
  Stream<WorldStates> mapEventToState(UpdateEvent event) async* {
    if (event == UpdateEvent.update) {
      try {
        final state = await ws.getWorldstate(instance.platform);
        yield WorldstateLoaded(state);
      } catch (e) {
        _displayErrorMessage(e);
        // yield WorldstateError(
        //     'Error contacting api.warframestat.us error code: ${e.response.statusCode}');
      }
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    Catcher.reportCheckedError(error, stacktrace);
  }

  Future<void> update() async {
    await Future.delayed(
        const Duration(milliseconds: 500), () => dispatch(UpdateEvent.update));
  }

  void _displayErrorMessage(dynamic error) {
    scaffold.currentState.showSnackBar(SnackBar(
      content: Text(error.toString()),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
          label: 'RETRY', onPressed: () => dispatch(UpdateEvent.update)),
    ));
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
