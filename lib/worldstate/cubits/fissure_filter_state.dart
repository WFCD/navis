part of 'fissure_filter_cubit.dart';

class FissureFilterState extends Equatable {
  const FissureFilterState({required this.fissures, required this.type});

  final List<VoidFissure> fissures;
  final FissureFilter type;

  @override
  List<Object> get props => [fissures, type];

  @override
  String toString() => 'FissureFilterState(type: ${type.name}, length: ${fissures.length})';
}
