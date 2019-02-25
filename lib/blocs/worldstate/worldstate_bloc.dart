import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../global_keys.dart';
import '../../services/worldstate.dart';
import 'worldstate_events.dart';
import 'worldstate_states.dart';

class WorldstateBloc extends Bloc<StateEvent, WorldStates>
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
  Stream<WorldStates> mapEventToState(currentState, event) async* {
    final prefs = await SharedPreferences.getInstance();

    if (event is UpdateState) {
      final state = await api.updateState(client,
          platform: prefs.getString('platform') ?? 'pc');

      yield WorldstateLoaded(worldState: state);
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    scaffold.currentState.showSnackBar(const SnackBar(
        content: Text('Error updating worldstate try again later')));
    //print(error.toString());
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  Factionutils get factionUtils => Factionutils();

  String expiration(DateTime expiry) {
    final DateFormat format = DateFormat.jms().add_yMd();

    try {
      return format.format(expiry);
    } catch (err) {
      return 'Fetching Date';
    }
  }

  Future<void> update() async {
    await Future.delayed(
        const Duration(milliseconds: 300), () => dispatch(UpdateState()));
  }
}
