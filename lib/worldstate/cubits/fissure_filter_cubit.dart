import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:worldstate_models/worldstate_models.dart';

part 'fissure_filter_state.dart';

enum FissureFilter { fissures, voidStorm, steelPath }

class FissureFilterCubit extends HydratedCubit<FissureFilterState> with SafeBlocMixin {
  FissureFilterCubit(List<VoidFissure> fissures)
    : super(FissureFilterState(fissures: fissures, type: FissureFilter.fissures));

  FissureFilter _filter = FissureFilter.fissures;

  void filterFissures(FissureFilter filter, List<VoidFissure> fissures) {
    safeEmit(
      () {
        _filter = filter;

        Iterable<VoidFissure> filteredFissures;
        switch (filter) {
          case FissureFilter.fissures:
            filteredFissures = fissures.whereNot((i) => i.isSteelpath || i.isStorm);
          case FissureFilter.voidStorm:
            filteredFissures = fissures.where((i) => i.isStorm);
          case FissureFilter.steelPath:
            filteredFissures = fissures.where((i) => i.isSteelpath);
        }

        return FissureFilterState(fissures: List.unmodifiable(filteredFissures.toList()), type: filter);
      },
    );
  }

  void updateFissues(List<VoidFissure> fissures) {
    filterFissures(_filter, fissures);
  }

  @override
  FissureFilterState? fromJson(Map<String, dynamic> json) {
    logger.info('Hydrating filtered fissures');
    try {
      final type = json['filter'] == 'all'
          ? FissureFilter.fissures
          : FissureFilter.values.byName(json['filter'] as String);

      final fissures = (json['fissures'] as List<dynamic>)
          .map((e) => VoidFissureMapper.fromMap(e as Map<String, dynamic>))
          .toList();

      return FissureFilterState(fissures: fissures, type: type);
    } on Exception catch (e, stack) {
      logger.warning('Failed to hydrate state', e, stack);
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(FissureFilterState state) {
    logger.info('Caching current state');
    return {'filter': state.type.name, 'fissures': state.fissures.map((e) => e.toMap()).toList()};
  }
}
