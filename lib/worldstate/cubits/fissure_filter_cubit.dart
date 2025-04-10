import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'fissure_filter_state.dart';

enum FissureFilter { fissures, voidStorm, steelPath }

class FissureFilterCubit extends HydratedCubit<FissureFilterState> {
  FissureFilterCubit(List<Fissure> fissures)
    : super(FissureFilterState(fissures: fissures, type: FissureFilter.fissures));

  static final _logger = Logger('FissureFilterCubit');

  FissureFilter _filter = FissureFilter.fissures;

  void filterFissures(FissureFilter filter, List<Fissure> fissures) {
    _filter = filter;

    Iterable<Fissure> filteredFissures;
    switch (filter) {
      case FissureFilter.fissures:
        filteredFissures = fissures.whereNot((i) => i.isHard || i.isStorm);
      case FissureFilter.voidStorm:
        filteredFissures = fissures.where((i) => i.isStorm);
      case FissureFilter.steelPath:
        filteredFissures = fissures.where((i) => i.isHard);
    }

    if (isClosed) return;
    emit(FissureFilterState(fissures: List.unmodifiable(filteredFissures.toList()), type: filter));
  }

  void updateFissues(List<Fissure> fissures) {
    filterFissures(_filter, fissures);
  }

  @override
  FissureFilterState? fromJson(Map<String, dynamic> json) {
    _logger.info('Hydrating filtered fissures');
    final type =
        json['filter'] == 'all' ? FissureFilter.fissures : FissureFilter.values.byName(json['filter'] as String);

    final fissures =
        (json['fissures'] as List<dynamic>).map((e) => Fissure.fromJson(e as Map<String, dynamic>)).toList();

    return FissureFilterState(fissures: fissures, type: type);
  }

  @override
  Map<String, dynamic>? toJson(FissureFilterState state) {
    _logger.info('Caching current state');
    return {'filter': state.type.name, 'fissures': state.fissures.map((e) => e.toJson()).toList()};
  }
}
