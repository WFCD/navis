part of 'worldstate_bloc.dart';

sealed class WorldState extends Equatable {
  const WorldState();

  @override
  List<Object> get props => [];
}

final class WorldstateInitial extends WorldState {
  @override
  String toString() => 'WorldstateInitial()';
}

final class WorldstateSuccess extends WorldState {
  const WorldstateSuccess(this.seed);

  final Worldstate seed;

  @override
  List<Object> get props => [seed.timestamp];

  @override
  String toString() => 'WorldstateSuccess(state: ${seed.timestamp})';
}

final class WorldstateFailure extends WorldState {
  @override
  String toString() => 'WorldstateFailure()';
}
