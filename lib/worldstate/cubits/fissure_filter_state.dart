part of 'fissure_filter_cubit.dart';

abstract class FissureFilterState extends Equatable {
  const FissureFilterState({required this.fissures});

  final List<Fissure> fissures;

  FissureFilter get type;

  @override
  List<Object> get props => [fissures, type];
}

class Fissures extends FissureFilterState {
  const Fissures({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.fissures;
}

class VoidStorms extends FissureFilterState {
  const VoidStorms({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.voidStorm;
}

class SteelPathFissures extends FissureFilterState {
  const SteelPathFissures({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.steelPath;
}
