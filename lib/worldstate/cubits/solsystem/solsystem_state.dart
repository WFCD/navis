import 'package:equatable/equatable.dart';
import 'package:wfcd_client/entities.dart';

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
