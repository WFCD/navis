import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

part 'worldstate_event.dart';
part 'worldstate_state.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldState> with ReplayBlocMixin, SafeBlocMixin {
  WorldstateBloc(this.locale, this.repository) : super(WorldstateInitial()) {
    on<WorldstateStarted>(_emiteState);
    on<WorldstateUpdated>((event, emit) => emit(WorldstateSuccess(event.state)));
    on<WorldstateFailed>((event, emit) => emit(WorldstateFailure()));
    add(WorldstateStarted(locale));
  }

  final String locale;
  final WorldstateRepository repository;

  Future<void> _emiteState(WorldstateStarted event, Emitter<WorldState> emit) async {
    final worldstate = await repository.buildWorldstate(locale);
    if (!isClosed) add(WorldstateUpdated(worldstate));

    await emit.onEach<Worldstate>(
      repository.worldstateEmitter(locale),
      onData: (state) => add(WorldstateUpdated(state)),
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

  @override
  String toString() => 'WorldstateBloc()';
}
