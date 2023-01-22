import 'package:equatable/equatable.dart';
import 'package:warframestat_client/warframestat_client.dart';

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

  // bool get activeAcolytes => worldstate.enemyActive;

  bool get activeAlerts => worldstate.alerts.isNotEmpty;

  bool get activeSales => worldstate.flashSales.isNotEmpty;

  bool get arbitrationActive => worldstate.arbitration != null;

  bool get eventsActive => worldstate.events.isNotEmpty;

  bool get outpostDetected => worldstate.sentientOutposts != null;

  @override
  List<Object> get props => [worldstate];

  @override
  String toString() {
    return worldstate.timestamp.toIso8601String();
  }
}

class SystemError extends SolsystemState {
  const SystemError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
