part of 'fissure_filter_cubit.dart';

abstract class FissureFilterState extends Equatable {
  const FissureFilterState({required this.fissures});

  final List<VoidFissure> fissures;

  FissureFilter get type;

  List<VoidFissure> filter();

  @override
  List<Object> get props => [filter];
}

class Unfiltred extends FissureFilterState {
  const Unfiltred({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.all;

  @override
  List<VoidFissure> filter() => fissures;
}

class VoidFissures extends FissureFilterState {
  const VoidFissures({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.fissures;

  @override
  List<VoidFissure> filter() =>
      fissures.where((e) => !e.isHard && !e.isStorm).toList();
}

class VoidStorms extends FissureFilterState {
  const VoidStorms({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.voidStorm;

  @override
  List<VoidFissure> filter() => fissures.where((e) => e.isStorm).toList();
}

class SteelPathFissures extends FissureFilterState {
  const SteelPathFissures({required super.fissures});

  @override
  FissureFilter get type => FissureFilter.steelPath;

  @override
  List<VoidFissure> filter() => fissures.where((e) => e.isHard).toList();
}
