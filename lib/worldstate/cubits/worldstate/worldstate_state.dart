part of 'worldstate_cubit.dart';

sealed class SolsystemState extends Equatable {
  const SolsystemState();

  @override
  List<Object> get props => [];
}

final class SolsystemInitial extends SolsystemState {}

final class LoadingWorldstate extends SolsystemState {}

final class WorldstateSuccess extends SolsystemState {
  const WorldstateSuccess(this.worldstate);

  final Worldstate worldstate;

  // bool get activeAcolytes => worldstate.enemyActive;

  bool get activeAlerts => worldstate.alerts.isNotEmpty;

  bool get activeSales => worldstate.flashSales.isNotEmpty;

  bool get arbitrationActive => worldstate.arbitration != null && !worldstate.arbitration!.node.contains('000');

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

final class WorldstateFailure extends SolsystemState {}
