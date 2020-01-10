import 'package:equatable/equatable.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WorldStates extends Equatable {
  const WorldStates();
}

class InitialWorldStates extends WorldStates {
  @override
  List<Object> get props => [];
}

class WorldstateLoadSuccess extends WorldStates {
  const WorldstateLoadSuccess(this.worldstate);

  final Worldstate worldstate;

  @override
  List<Object> get props => [worldstate];
}

class WorldstateLoadFailure extends WorldStates {
  const WorldstateLoadFailure(this.cachedWorldstate, this.error);

  final Worldstate cachedWorldstate;
  final Object error;

  @override
  List<Object> get props => [cachedWorldstate, error];
}
