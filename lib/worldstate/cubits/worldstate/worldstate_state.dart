part of 'worldstate_cubit.dart';

sealed class SolsystemState extends Equatable {
  const SolsystemState();
}

class SolsystemInitial extends SolsystemState {
  @override
  List<Object> get props => [];
}

class LoadingWorldstate extends SolsystemState {
  @override
  List<Object> get props => [];
}

class WorldstateSuccess extends SolsystemState {
  const WorldstateSuccess(this.worldstate);

  final Worldstate worldstate;

  // bool get activeAcolytes => worldstate.enemyActive;

  bool get activeAlerts => worldstate.alerts.isNotEmpty;

  bool get activeSales => worldstate.flashSales.isNotEmpty;

  bool get arbitrationActive => worldstate.arbitration != null;

  bool get eventsActive => worldstate.events.isNotEmpty;

  bool get outpostDetected => worldstate.sentientOutposts != null;

  bool get deepArchimedeaActive => worldstate.deepArchimedea != null;

  @override
  List<Object> get props => [worldstate];

  @override
  String toString() {
    return worldstate.timestamp.toIso8601String();
  }
}

class WorldstateFailure extends SolsystemState {
  const WorldstateFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
