import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

part 'fissure_filter_state.dart';

enum FissureFilter { all, fissures, voidStorm, steelPath }

class FissureFilterCubit extends HydratedCubit<FissureFilterState> {
  FissureFilterCubit(List<VoidFissure> fissures)
      : super(Unfiltred(fissures: fissures));

  void filterFissures(FissureFilter filter, List<VoidFissure> fissures) {
    switch (filter) {
      case FissureFilter.all:
        emit(Unfiltred(fissures: fissures));
        break;
      case FissureFilter.fissures:
        emit(VoidFissures(fissures: fissures));
        break;
      case FissureFilter.voidStorm:
        emit(VoidStorms(fissures: fissures));
        break;
      case FissureFilter.steelPath:
        emit(SteelPathFissures(fissures: fissures));
        break;
    }
  }

  @override
  FissureFilterState? fromJson(Map<String, dynamic> json) {
    final type = FissureFilter.values.byName(json['filter'] as String);
    final fissures = (json['fissures'] as List<dynamic>)
        .map((e) => VoidFissureModel.fromJson(e as Map<String, dynamic>))
        .toList();

    switch (type) {
      case FissureFilter.all:
        return Unfiltred(fissures: fissures);
      case FissureFilter.fissures:
        return VoidFissures(fissures: fissures);
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
      'fissures':
          state.fissures.map((e) => (e as VoidFissureModel).toJson()).toList(),
    };
  }
}
