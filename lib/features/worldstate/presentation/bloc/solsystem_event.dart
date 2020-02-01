part of 'solsystem_bloc.dart';

abstract class SolsystemEvent extends Equatable {
  const SolsystemEvent();
}

class SolupdateSystem extends SolsystemEvent {
  final GamePlatforms platform;

  const SolupdateSystem(this.platform);

  @override
  List<Object> get props => [platform];
}

class SolupdateTargets extends SolsystemEvent {
  @override
  List<Object> get props => [];
}
