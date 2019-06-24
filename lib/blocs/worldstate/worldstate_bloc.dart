import 'dart:async';

import 'package:codable/codable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/models/export.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';

import '../../global_keys.dart';
import '../../services/worldstate.dart';
import 'worldstate_states.dart';

enum UpdateEvent { update }

class WorldstateBloc extends HydratedBloc<UpdateEvent, WorldStates>
    with EquatableMixinBase, EquatableMixin {
  WorldstateBloc();

  static final http.Client client = http.Client();

  final instance = locator<LocalStorageService>();
  final ws = locator<WorldstateAPI>();

  @override
  WorldStates get initialState =>
      super.initialState ?? WorldstateUninitialized();

  @override
  Stream<WorldStates> mapEventToState(UpdateEvent event) async* {
    if (event == UpdateEvent.update) {
      try {
        final state = await ws.getWorldstate(instance.platform);
        yield WorldstateLoaded(state);
      } catch (error) {
        yield WorldstateError('Error loading worldstate');
      }
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _displayErrorMessage();
    logError(error);
  }

  Future<void> update() async {
    await Future.delayed(
        const Duration(milliseconds: 300), () => dispatch(UpdateEvent.update));
  }

  void _displayErrorMessage() {
    scaffold.currentState.showSnackBar(SnackBar(
      content: const Text('Error connecting to warframestat.us API'),
      action: SnackBarAction(
          label: 'RETRY', onPressed: () => dispatch(UpdateEvent.update)),
    ));
  }

  @override
  WorldStates fromJson(Map<String, dynamic> json) {
    final key = KeyedArchive.unarchive(json);
    final worldstate = WorldState()..decode(key);

    return WorldstateLoaded(worldstate);
  }

  @override
  Map<String, dynamic> toJson(WorldStates state) {
    return state.worldstate != null
        ? KeyedArchive.archive(state.worldstate)
        : null;
  }
}
