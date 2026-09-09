part of 'synthtargets_cubit.dart';

sealed class SynthtargetsState extends Equatable {
  const new();
}

class SynthtargetsInitial extends SynthtargetsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SynthtargetsInitial()';
}

class TargetsLocated extends SynthtargetsState {
  const new(this.targets);

  final List<SynthTarget> targets;

  @override
  List<Object> get props => [targets];

  @override
  String toString() => 'TargetsLocated(targets: ${targets.length})';
}

class TargetsNotFound extends SynthtargetsState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'TargetsNotFound()';
}
