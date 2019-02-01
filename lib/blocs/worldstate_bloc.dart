import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/stateutils.dart';
import 'package:navis/models/export.dart';

import '../services/worldstate.dart';
import 'provider.dart';

class WorldstateBloc implements Base {
  factory WorldstateBloc() {
    final updatedState = BehaviorSubject<WorldState>(
        seedValue: initworldstate); // ignore: close_sinks
    final worldstate = updatedState.distinct();

    return WorldstateBloc._(updatedState, worldstate);
  }

  WorldstateBloc._(this.updatedState, this.worldstate);

  static WorldState initworldstate;

  final Sink<WorldState> updatedState;
  final Stream<WorldState> worldstate;

  Stateutils get stateUtils => Stateutils(worldstate: initworldstate);
  Factionutils get factionUtils => Factionutils();

  Future<void> update() async {
    final state = WorldstateAPI();
    updatedState.add(await state.updateState());
  }

  @override
  void dispose() => updatedState.close();
}
