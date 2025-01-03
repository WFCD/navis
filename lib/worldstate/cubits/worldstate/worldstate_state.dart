part of 'worldstate_cubit.dart';

sealed class SolsystemState extends Equatable {
  const SolsystemState();
}

final class SolsystemInitial extends SolsystemState {
  @override
  List<Object> get props => [];
}

final class LoadingWorldstate extends SolsystemState {
  @override
  List<Object> get props => [];
}

final class WorldstateSuccess extends SolsystemState {
  const WorldstateSuccess(this.worldstate);

  final Worldstate worldstate;

  @override
  List<Object> get props => [worldstate];

  @override
  String toString() {
    return worldstate.timestamp.toIso8601String();
  }
}

final class WorldstateFailure extends SolsystemState {
  const WorldstateFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
