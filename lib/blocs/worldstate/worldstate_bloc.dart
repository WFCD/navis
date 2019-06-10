import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';

import '../../global_keys.dart';
import '../../services/worldstate.dart';
import 'worldstate_states.dart';

enum UpdateEvent { update }

class WorldstateBloc extends Bloc<UpdateEvent, WorldStates>
    with EquatableMixinBase, EquatableMixin {
  WorldstateBloc();

  static final http.Client client = http.Client();

  @override
  WorldStates get initialState => WorldstateUninitialized();

  final instance = locator<LocalStorageService>();
  final ws = locator<WorldstateAPI>();

  @override
  Stream<WorldStates> mapEventToState(UpdateEvent event) async* {
    if (event == UpdateEvent.update) {
      final state = await ws.getWorldstate(instance.platform);
      yield WorldstateLoaded(state);
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
}
