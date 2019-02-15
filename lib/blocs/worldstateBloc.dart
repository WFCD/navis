import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/factionutils.dart';

import '../globalkeys.dart';
import '../services/repository.dart';

class WorldstateBloc extends Bloc<StateEvent, WorldStates> {
  final repository = Respiratory();
  final DateFormat format = DateFormat.jms().add_yMd();

  @override
  WorldStates get initialState => WorldstateUninitialized();

  @override
  Stream<WorldStates> mapEventToState(currentState, event) async* {
    if (currentState is WorldstateUninitialized) {
      final state = await repository.getState();
      yield WorldstateLoaded(worldState: state);
    }
    if (currentState is WorldstateLoaded) {
      final state = await repository.getState();
      yield WorldstateLoaded(worldState: state);
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    scaffold.currentState.showSnackBar(const SnackBar(
        content: Text('Error updating worldstate try again later')));
  }

  Factionutils get factionUtils => Factionutils();

  String expiration(DateTime expiry) {
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

// data State
abstract class WorldStates {}

class WorldstateUninitialized extends WorldStates {}

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded({this.worldState});

  final WorldState worldState;

  WorldstateLoaded copyWith({WorldState worldState}) {
    return WorldstateLoaded(worldState: worldState);
  }
}

// State Event
abstract class StateEvent {}

class UpdateState extends StateEvent {}
