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

  String get cetusExpiry => _expiration(_worldstate.cetus.expiry);

  String get earthExpiry => _expiration(_worldstate.earth.expiry);

  String get vallisExpiry => _expiration(_worldstate.vallis.expiry);

  String get voidTraderArrival => _expiration(_worldstate.trader.activation);

  String get voidTraderDeparture => _expiration(_worldstate.trader.expiry);

  Future<Null> update() async {
    final state = SystemState();
    currentState.add(await state.updateState());

    return null;
  }

  _expiration(String expiry) {
    try {
      return format.format(DateTime.parse(expiry).toLocal());
    } catch (err) {
      return 'Fetching Date';
    }
  }

  @override
  void dispose() => currentState.close();
}
