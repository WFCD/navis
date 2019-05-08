//import 'package:equatable/equatable.dart';
import 'package:navis/models/export.dart';

abstract class WorldStates {
  WorldState worldState;
}

class WorldstateUninitialized extends WorldStates {}

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded(this._worldState);

  final WorldState _worldState;

  @override
  WorldState get worldState => _worldState;
}
