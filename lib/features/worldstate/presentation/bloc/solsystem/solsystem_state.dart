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
  const SolState(this.worldstate);

  final Worldstate worldstate;

  bool get activeAcolytes => worldstate.enemyActive;

  bool get activeAlerts => worldstate.activeAlerts;

  bool get activeSales => worldstate.isSaleActive;

  bool get arbitrationActive => worldstate.activeArbitration;

  bool get eventsActive => worldstate.activeEvents;

  bool get outpostDetected => worldstate.anomalyDetected;

  List<Challenge> get nightwaveDailies =>
      worldstate.nightwave?.daily ?? <Challenge>[];

  List<Challenge> get nightwaveWeeklies =>
      worldstate.nightwave?.weekly ?? <Challenge>[];

  @override
  List<Object> get props => [worldstate];
}

class SystemError extends SolsystemState {
  const SystemError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
