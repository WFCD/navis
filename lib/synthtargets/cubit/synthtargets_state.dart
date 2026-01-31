import 'package:equatable/equatable.dart';
import 'package:warframestat_client/warframestat_client.dart';

sealed class SynthtargetsState extends Equatable {
  const SynthtargetsState();
}

class SynthtargetsInitial extends SynthtargetsState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SynthtargetsInitial()';
}

class TargetsLocated extends SynthtargetsState {
  const TargetsLocated(this.targets);

  final List<SynthTarget> targets;

  @override
  List<Object> get props => [targets];

  @override
  String toString() => 'TargetsLocated(${targets.length})';
}

class TargetsNotFound extends SynthtargetsState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'TargetsNotFound()';
}
