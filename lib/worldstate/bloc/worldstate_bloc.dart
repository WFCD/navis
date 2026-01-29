import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis/worldstate/utils/worldstate_helpers.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

part 'worldstate_event.dart';
part 'worldstate_state.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldState> with ReplayBlocMixin, SafeBlocMixin {
  WorldstateBloc(this.repository) : super(WorldstateInitial()) {
    on<WorldstateStarted>(_emiteState);
    on<WorldstateUpdated>((event, emit) => emit(WorldstateSuccess(event.state)));
    on<WorldstateFailed>((event, emit) => emit(WorldstateFailure()));
    add(const WorldstateStarted(Locale('en')));
  }

  final WarframeRepository repository;

  Future<void> _emiteState(WorldstateStarted event, Emitter<WorldState> emit) async {
    final locale = event.locale.languageCode;

    final worldstate = await repository.fetchWorldstate(locale);
    if (!isClosed) add(WorldstateUpdated(worldstate..clean()));

    await emit.onEach<Worldstate>(
      repository.worldstateEmitter(locale: locale),
      onData: (state) => add(WorldstateUpdated(state..clean())),
      onError: (error, stackTrace) async {
        add(WorldstateFailed());
        undo();
        addError(error, stackTrace);
      },
    );
  }

  @override
  WorldState? fromJson(Map<String, dynamic> json) {
    try {
      final seed = Worldstate.fromMap(json);
      return WorldstateSuccess(seed);
    } on Exception catch (e, stack) {
      logger.warning('Failed to load worldstate from cache', e, stack);
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WorldState state) {
    if (state is! WorldstateSuccess) return null;
    return state.seed.toMap();
  }
}
