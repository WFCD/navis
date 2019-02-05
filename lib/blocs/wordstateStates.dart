import 'package:navis/models/export.dart';

abstract class WorldStates {}

class WorldstateUninitialized extends WorldStates {}

class WorldstateError extends WorldStates {
  WorldstateError({this.error});

  final dynamic error;
}

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded({this.worldState});

  final WorldState worldState;

  WorldstateLoaded copyWith({WorldState worldState}) {
    return WorldstateLoaded(worldState: worldState);
  }
}
