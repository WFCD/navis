import 'dart:async';

import 'package:intl/intl.dart';
import 'package:navis/models/export.dart';
import 'package:rxdart/rxdart.dart';

import '../network/network.dart';
import 'base.dart';

class WorldstateBloc implements Base {
  final Sink<WorldState> currentState;
  final Stream<WorldState> worldstate;

  static WorldState _worldstate;
  final DateFormat format = DateFormat.jms().add_yMd();

  factory WorldstateBloc() {
    final state = Network();
    final currentState = BehaviorSubject<WorldState>(); // ignore: close_sinks
    final worldstate = currentState.distinct();

    state.updateState().then((state) => currentState.add(state));
    worldstate.listen((state) => _worldstate = state);
    return WorldstateBloc._(currentState, worldstate);
  }

  WorldstateBloc._(this.currentState, this.worldstate);

  WorldState get lastState => _worldstate;

  //final Duration _late = Duration(minutes: 1);

  // I have no idea what I'm doing anymore
  static int get invasions => _worldstate.invasions.length;

  Duration get bountyTime {
    try {
      String expiry = _worldstate.syndicates.first.expiry;
      return DateTime.parse(expiry).difference(DateTime.now());
    } catch (err) {
      return Duration(minutes: 150);
    }
  }

  Duration get cetusCycleTime {
    Duration currentTime = _durations(_worldstate.cetus.expiry);
    DateTime expiry = DateTime.parse(_worldstate.cetus.expiry);

    if (DateTime.now().isAfter(expiry)) {
      if (_worldstate.cetus.isDay) return Duration(minutes: 100);

      return Duration(minutes: 50);
    }

    return currentTime;
  }

  Duration get earthCycleTime {
    Duration currentTime = _durations(_worldstate.earth.expiry);
    DateTime expiry = DateTime.parse(_worldstate.earth.expiry);

    if (DateTime.now().isAfter(expiry)) return Duration(minutes: 240);

    return currentTime;
  }

  Duration get vallisCycleTime {
    Duration currentTime = _durations(_worldstate.vallis.expiry);
    DateTime expiry = DateTime.parse(_worldstate.vallis.expiry);

    if (DateTime.now().isAfter(expiry)) {
      if (_worldstate.vallis.isWarm) return Duration(minutes: 20);

      return Duration(minutes: 4);
    }

    return currentTime;
  }

  String get cetusExpiry => _expirations(_worldstate.cetus.expiry);

  String get earthExpiry => _expirations(_worldstate.earth.expiry);

  String get vallisExpiry => _expirations(_worldstate.vallis.expiry);

  String get voidTraderArrival => _expirations(_worldstate.trader.activation);

  String get voidTraderDeparture => _expirations(_worldstate.trader.expiry);

  Future<Null> update() async {
    final state = Network();
    WorldState seed;

    try {
      seed = await state.updateState();
      return currentState.add(seed);
    } catch (err) {
      throw Exception('No connection');
    }
  }

  _expirations(String expiry) {
    try {
      return format.format(DateTime.parse(expiry));
    } catch (err) {
      return 'Fetching Date';
    }
  }

  _durations(String expiry) {
    Duration converted;

    try {
      converted = DateTime.parse(expiry).difference(DateTime.now());
    } catch (err) {
      converted = Duration(minutes: 3) - Duration(minutes: 4);
    }

    return converted;
  }

  @override
  void dispose() => currentState.close();
}
