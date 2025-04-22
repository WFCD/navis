import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'worldstate_event.dart';
part 'worldstate_state.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldState> with ReplayBlocMixin {
  WorldstateBloc(this.repository) : super(WorldstateInitial()) {
    on<WorldstateStarted>(_start);
    on<WorldstateUpdated>((event, emit) => emit(WorldstateSuccess(event.state)));
    add(WorldstateStarted(Locale(repository.language.name)));
  }

  final WarframestatRepository repository;

  final _logger = Logger('WorldstateBloc');

  Future<void> _start(WorldstateStarted event, Emitter<WorldState> emit) async {
    repository.language = Language.values.byName(event.locale.languageCode);
    await emit.onEach(
      repository.worldstate().throttleTime(const Duration(seconds: Duration.secondsPerMinute)),
      onData: (state) {
        if (isClosed) return;
        add(WorldstateUpdated(state..clean()));
      },
      onError: (error, stackTrace) {
        if (isClosed) return;
        add(WorldstateFailed());
        undo();
      },
    );
  }

  @override
  WorldState? fromJson(Map<String, dynamic> json) {
    _logger.info('Hydrating state');
    final seed = Worldstate.fromJson(json);

    return WorldstateSuccess(seed);
  }

  @override
  Map<String, dynamic>? toJson(WorldState state) {
    if (state is! WorldstateSuccess) return null;
    _logger.info('Caching state');

    return state.seed.toJson();
  }
}
