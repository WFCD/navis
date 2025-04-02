part of 'fissure_filter_cubit.dart';

class FissureFilterState extends Equatable {
  const FissureFilterState({required this.fissures, required this.type});

  final List<Fissure> fissures;
  final FissureFilter type;

  @override
  List<Object> get props => [fissures, type];
}
