import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart' show Language;
import 'package:warframestat_repository/warframestat_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

part 'worldstate_event.dart';
part 'worldstate_state.dart';

late Stream<Worldstate> _worldstate;

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldState> with ReplayBlocMixin {
  WorldstateBloc(this.repository) : super(WorldstateInitial()) {
    on<WorldstateStarted>(_start);
    on<WorldstateUpdated>((event, emit) => emit(WorldstateSuccess(event.state)));
    on<WorldstateFailed>((event, emit) => emit(WorldstateFailure()));
    add(WorldstateStarted(Locale(repository.language.name)));
  }

  final WarframestatRepository repository;

  final _logger = Logger('WorldstateBloc');

  Future<void> _start(WorldstateStarted event, Emitter<WorldState> emit) async {
    repository.language = Language.values.byName(event.locale.languageCode);
    _worldstate = repository.worldstate();

    await emit.onEach<Worldstate>(
      _worldstate,
      onData: (state) {
        if (isClosed) return;
        add(WorldstateUpdated(state..clean(repository.language)));
      },
      onError: (error, stackTrace) async {
        if (isClosed) return;
        add(WorldstateFailed(error, stackTrace));
        undo();
        await Sentry.captureException(error, stackTrace: stackTrace);
      },
    );
  }

  @override
  WorldState? fromJson(Map<String, dynamic> json) {
    _logger.info('Hydrating state');
    try {
      final seed = Worldstate.fromMap(json);

      return WorldstateSuccess(seed);
    } on Exception {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WorldState state) {
    if (state is! WorldstateSuccess) return null;
    _logger.info('Caching state');

    return state.seed.toMap();
  }
}
