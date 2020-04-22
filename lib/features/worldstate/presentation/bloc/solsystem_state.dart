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

  bool get activeAcolytes => worldstate.persistentEnemies?.isNotEmpty ?? false;

  bool get activeAlerts => worldstate.alerts?.isNotEmpty ?? false;

  bool get activeSales => worldstate.dailyDeals?.isNotEmpty ?? false;

  bool get activeSiphons => worldstate.kuva?.isNotEmpty ?? false;

  bool get arbitrationActive => worldstate.arbitration?.node != null;

  bool get eventsActive => worldstate.events?.isNotEmpty ?? false;

  bool get outpostDetected => worldstate.sentientOutposts?.active ?? false;

  List<Challenge> get _activeChallenges {
    return worldstate.nightwave.activeChallenges;
  }

  List<Challenge> get nightwaveDailies {
    return _activeChallenges.where((c) => c.isDaily == true).toList()
      ..sort((a, b) => a.expiry.compareTo(b.expiry));
  }

  List<Challenge> get nightwaveWeeklies {
    return _activeChallenges.where((c) => c.isDaily == null).toList()
      ..sort((a, b) {
        if (a.isElite ?? false) {
          return 0;
        } else {
          return 1;
        }
      });
  }

  @override
  List<Object> get props => [worldstate];
}

class SystemError extends SolsystemState {
  const SystemError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
