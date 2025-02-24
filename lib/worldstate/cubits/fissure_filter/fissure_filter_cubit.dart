import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'fissure_filter_state.dart';

enum FissureFilter { fissures, voidStorm, steelPath }

class FissureFilterCubit extends HydratedCubit<FissureFilterState> {
  FissureFilterCubit(List<Fissure> fissures) : super(Fissures(fissures: fissures));

  FissureFilter _filter = FissureFilter.fissures;

  void filterFissures(FissureFilter filter, List<Fissure> fissures) {
    _filter = filter;

    switch (filter) {
      case FissureFilter.fissures:
        emit(Fissures(fissures: fissures.whereNot((i) => i.isHard || i.isStorm).toList()));
      case FissureFilter.voidStorm:
        emit(VoidStorms(fissures: fissures.where((i) => i.isStorm).toList()));
      case FissureFilter.steelPath:
        emit(SteelPathFissures(fissures: fissures.where((i) => i.isHard).toList()));
    }
  }

  void updateFissues(List<Fissure> fissures) {
    filterFissures(_filter, fissures);
  }

  @override
  FissureFilterState? fromJson(Map<String, dynamic> json) {
    final type = FissureFilter.values.byName(json['filter'] as String);
    final fissures =
        (json['fissures'] as List<dynamic>).map((e) => Fissure.fromJson(e as Map<String, dynamic>)).toList();

    switch (type) {
      case FissureFilter.fissures:
        return Fissures(fissures: fissures);
      case FissureFilter.voidStorm:
        return VoidStorms(fissures: fissures);
      case FissureFilter.steelPath:
        return SteelPathFissures(fissures: fissures);
    }
  }

  @override
  Map<String, dynamic>? toJson(FissureFilterState state) {
    return {
      'filter': state.type.toString().split('.').last,
      'fissures': state.fissures.map((e) => e.toJson()).toList(),
    };
  }
}
