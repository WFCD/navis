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
  final BaseItem dealInfo;

  const SolState({this.worldstate, this.dealInfo});

  @override
  List<Object> get props => [worldstate, dealInfo];

  SolState copyWith({Worldstate worldstate, BaseItem dealInfo}) {
    return SolState(
      worldstate: worldstate ?? this.worldstate,
      dealInfo: dealInfo ?? this.dealInfo,
    );
  }
}

class SystemError extends SolsystemState {
  final String message;

  const SystemError(this.message);

  @override
  List<Object> get props => [message];
}
