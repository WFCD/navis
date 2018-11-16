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
  Duration get bountyTime => _durations(_worldstate.syndicates.first.expiry);

  Duration get cetusCycleTime => _durations(_worldstate.cetus.expiry);

  Duration get earthCycleTime => _durations(_worldstate.earth.expiry);

  Duration get vallisCycleTime => _durations(_worldstate.vallis.expiry);

  String get cetusExpiry => _expirations(_worldstate.cetus.expiry);

  String get earthExpiry => _expirations(_worldstate.earth.expiry);

  String get vallisExpiry => _expirations(_worldstate.vallis.expiry);

  String get voidTraderArrival => _expirations(_worldstate.trader.activation);

  String get voidTraderDeparture => _expirations(_worldstate.trader.expiry);

  Future<Null> update() async {
    final state = SystemState();
    currentState.add(await state.updateState());

    return null;
  }

  _expirations(String expiry) {
    try {
      return format.format(DateTime.parse(expiry).toLocal());
    } catch (err) {
      return 'Fetching Date';
    }
  }

  _durations(String expiry) {
    try {
      return DateTime.parse(expiry).difference(DateTime.now());
    } catch (err) {
      return Duration(minutes: 1);
    }
  }

  @override
  void dispose() => currentState.close();
}
