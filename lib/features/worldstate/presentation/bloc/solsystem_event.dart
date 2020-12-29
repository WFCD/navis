part of 'solsystem_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();
}

class SyncSystemStatus extends SyncEvent {
  const SyncSystemStatus({this.forceUpdate = false});

  final bool forceUpdate;

  @override
  List<Object> get props => [forceUpdate];
}
