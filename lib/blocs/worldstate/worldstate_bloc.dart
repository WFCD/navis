import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../global_keys.dart';
import '../../services/worldstate.dart';
import 'worldstate_states.dart';

enum UpdateEvent { update }

class WorldstateBloc extends Bloc<UpdateEvent, WorldStates>
    with EquatableMixinBase, EquatableMixin {
  WorldstateBloc._({this.client});

  factory WorldstateBloc.initialize({http.Client client}) {
    if (client == null) return WorldstateBloc._(client: http.Client());

    return WorldstateBloc._(client: client);
  }

  final http.Client client;

  WorldstateAPI api = WorldstateAPI();

  @override
  WorldStates get initialState => WorldstateUninitialized();

  @override
  Stream<WorldStates> mapEventToState(UpdateEvent event) async* {
    if (event == UpdateEvent.update) {
      final prefs = await SharedPreferences.getInstance();
      final state = await api.updateState(client, prefs.getString('platform'));

      yield WorldstateLoaded(state);
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    scaffold.currentState.showSnackBar(const SnackBar(
        content: Text('Error updating worldstate try again later')));
  }

  @override
  void dispose() {
    client?.close();
    super.dispose();
  }

  Future<void> update() async {
    await Future.delayed(
        const Duration(milliseconds: 300), () => dispatch(UpdateEvent.update));
  }
}
