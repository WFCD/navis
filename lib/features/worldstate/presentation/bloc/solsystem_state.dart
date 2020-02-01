part of 'solsystem_bloc.dart';

abstract class SolsystemState extends Equatable {
  const SolsystemState();
}

class SolsystemInitial extends SolsystemState {
  @override
  List<Object> get props => [];
}

class DetectingState extends SolsystemState {
  @override
  List<Object> get props => [];
}

class SolState extends SolsystemState {
  final Worldstate worldstate;

  const SolState(this.worldstate);

  @override
  List<Object> get props => [worldstate];
}

class SystemError extends SolsystemState {
  final String message;

  const SystemError(this.message);

  @override
  List<Object> get props => [message];
}
