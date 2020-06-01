import 'package:equatable/equatable.dart';
import 'package:warframestat_api_models/entities.dart';

abstract class WorldStates extends Equatable {
  const WorldStates({this.worldstate});

  final Worldstate worldstate;

  @override
  List<Object> get props => [worldstate];
}

class WorldstateUninitialized extends WorldStates {}

class WorldstateError extends WorldStates {
  const WorldstateError(this.error);

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class WorldstateLoaded extends WorldStates {
  const WorldstateLoaded([Worldstate worldstate])
      : super(worldstate: worldstate);
}
