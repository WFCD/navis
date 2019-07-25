//import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/models/export.dart';

abstract class WorldStates extends Equatable {
  WorldStates({this.worldstate, List props = const []})
      : super([worldstate, ...props]);

  final Worldstate worldstate;
}

class WorldstateUninitialized extends WorldStates {}

class WorldstateError extends WorldStates {
  WorldstateError(this.error) : super(props: [error]);

  final String error;
}

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded(Worldstate worldstate) : super(worldstate: worldstate);
}
