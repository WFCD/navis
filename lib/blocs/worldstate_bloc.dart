import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/stateutils.dart';
import 'package:navis/models/export.dart';

import '../APIs/worldstate.dart';
import 'provider.dart';

class WorldstateBloc implements Base {
  factory WorldstateBloc() {
    final state = WorldstateAPI();

    final updatedState = BehaviorSubject<WorldState>(); // ignore: close_sinks
    final worldstate = updatedState.distinct();

    state.updateState().then((state) => _initLogic(state, updatedState));
    return WorldstateBloc._(updatedState, worldstate);
  }

  WorldstateBloc._(this.updatedState, this.worldstate);

  final Sink<WorldState> updatedState;
  final Stream<WorldState> worldstate;

  static WorldState initworldstate;

  Stateutils get stateUtils => Stateutils(worldstate: initworldstate);
  Factionutils get factionUtils => Factionutils();

  Future<void> update() async {
    final state = WorldstateAPI();
    try {
      updatedState.add(await state.updateState());
      initworldstate = await state.updateState();
    } catch (err) {
      // ignore: empty_catchers
    }
  }

  static void _initLogic(WorldState state, sink) {
    initworldstate = state;
    sink.add(state);
  }

  @override
  void dispose() => updatedState.close();
}
