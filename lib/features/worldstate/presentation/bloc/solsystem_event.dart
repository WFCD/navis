part of 'solsystem_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();
}

class SyncSystemStatus extends SyncEvent {
  final GamePlatforms platform;

  const SyncSystemStatus(this.platform);

  @override
  List<Object> get props => [platform];
}

class SyncTargets extends SyncEvent {
  @override
  List<Object> get props => [];
}
