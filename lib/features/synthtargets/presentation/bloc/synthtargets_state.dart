part of 'synthtargets_bloc.dart';

abstract class SynthtargetsState extends Equatable {
  const SynthtargetsState();
}

class SynthtargetsInitial extends SynthtargetsState {
  @override
  List<Object> get props => [];
}

class TargetsLocated extends SynthtargetsState {
  const TargetsLocated(this.targets);

  final List<SynthTarget> targets;

  @override
  List<Object> get props => [targets];
}
