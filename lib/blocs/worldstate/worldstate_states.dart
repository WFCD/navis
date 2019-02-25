//import 'package:equatable/equatable.dart';
import 'package:navis/models/export.dart';

abstract class WorldStates {}

class WorldstateUninitialized extends WorldStates {}

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded({this.worldState});

  final WorldState worldState;
}
