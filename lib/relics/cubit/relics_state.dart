part of 'relics_cubit.dart';

sealed class RelicsState extends Equatable {
  const RelicsState();

  @override
  List<Object> get props => [];
}

final class RelicsInitial extends RelicsState {}

final class RelicsLoading extends RelicsState {}

final class RelicsSuccessful extends RelicsState {
  const RelicsSuccessful(this.relics);

  final List<RelicSet> relics;

  @override
  List<Object> get props => [relics];

  @override
  String toString() => 'RelicsSuccessful(relics: ${relics.length})';
}
