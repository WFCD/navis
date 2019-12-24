import 'package:equatable/equatable.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WorldstateState extends Equatable {
  const WorldstateState();
}

class InitialWorldstateState extends WorldstateState {
  @override
  List<Object> get props => [];
}

class WorldstateLoadSuccess extends WorldstateState {
  const WorldstateLoadSuccess(this.worldstate);

  final Worldstate worldstate;

  @override
  List<Object> get props => [worldstate];
}

class WorldstateLoadFailure extends WorldstateState {
  const WorldstateLoadFailure(this.cachedWorldstate, this.error);

  final Worldstate cachedWorldstate;
  final Object error;

  @override
  List<Object> get props => [cachedWorldstate, error];
}
