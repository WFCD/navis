import 'dart:async';

import 'package:intl/intl.dart';
import 'package:navis/models/worldstate.dart';
import 'package:rxdart/rxdart.dart';

import '../network/state.dart';
import 'base.dart';

class WorldstateBloc implements Base {
  final Sink<WorldState> currentState;
  final Stream<WorldState> worldstate;

  static WorldState _worldstate;
  final DateFormat format = DateFormat.jms().add_yMd();

  factory WorldstateBloc() {
    final state = SystemState();
    final currentState = BehaviorSubject<WorldState>(); // ignore: close_sinks
    final worldstate = currentState.distinct();

    state.updateState().then((state) => currentState.add(state));
    worldstate.listen((state) => _worldstate = state);
    return WorldstateBloc._(currentState, worldstate);
  }

  WorldstateBloc._(this.currentState, this.worldstate);

  WorldState get lastState => _worldstate;

  // I have no idea what I'm doing anymore
  Duration get cetusCycleTime =>
      DateTime.parse(_worldstate.cetus.expiry).difference(DateTime.now());

  Duration get earthCycleTime =>
      DateTime.parse(_worldstate.earth.expiry).difference(DateTime.now());

  Duration get vallisCycleTime =>
      DateTime.parse(_worldstate.vallis.expiry).difference(DateTime.now());

  String get cetusExpiry =>
      format.format(DateTime.parse(_worldstate.cetus.expiry).toLocal());

  String get earthExpiry =>
      format.format(DateTime.parse(_worldstate.earth.expiry).toLocal());

  String get vallisExpiry =>
      format.format(DateTime.parse(_worldstate.vallis.expiry).toLocal());

  String get voidTraderArrival =>
      format.format(DateTime.parse(_worldstate.trader.activation).toLocal());

  String get voidTraderDeparture =>
      format.format(DateTime.parse(_worldstate.trader.expiry).toLocal());

  Future<Null> update() async {
    final state = SystemState();
    currentState.add(await state.updateState());

    return null;
  }

  @override
  void dispose() => currentState.close();
}
