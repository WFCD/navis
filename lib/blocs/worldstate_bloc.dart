import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/stateutils.dart';
import 'package:navis/models/export.dart';

import '../services/worldstate.dart';
import 'provider.dart';

class WorldstateBloc implements Base {
  factory WorldstateBloc() {
    final updatedState = BehaviorSubject<WorldState>(); // ignore: close_sinks
    final worldstate = updatedState.distinct();

    return WorldstateBloc._(updatedState, worldstate);
  }

  WorldstateBloc._(this.updatedState, this.worldstate);

  final _state = WorldstateAPI();

  WorldState initial;

  final Sink<WorldState> updatedState;
  final Stream<WorldState> worldstate;

  Stateutils get stateUtils => Stateutils(worldstate: initial);
  Factionutils get factionUtils => Factionutils();

  Future<void> update() async {
    initial ??= await _state.updateState();
    updatedState.add(await _state.updateState());
  }

  @override
  void initState() {
    update();
  }

  @override
  void dispose() => updatedState.close();
}
