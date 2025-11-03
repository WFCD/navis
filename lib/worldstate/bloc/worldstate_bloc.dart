import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

part 'worldstate_event.dart';
part 'worldstate_state.dart';

class WorldstateBloc extends HydratedBloc<WorldstateEvent, WorldState> with ReplayBlocMixin {
  WorldstateBloc(this.repository) : super(WorldstateInitial()) {
    on<WorldstateStarted>(_emiteState);
    on<WorldstateUpdated>((event, emit) => emit(WorldstateSuccess(event.state)));
    on<WorldstateFailed>((event, emit) => emit(WorldstateFailure()));
    add(const WorldstateStarted(Locale('en')));
  }

  final WarframeRepository repository;

  final _logger = Logger('WorldstateBloc');

  Future<void> _emiteState(WorldstateStarted event, Emitter<WorldState> emit) async {
    final locale = event.locale.languageCode;

    if (state is WorldstateSuccess) {
      final current = (state as WorldstateSuccess).seed.timestamp;
      final elapsed = DateTime.timestamp().difference(current);
      if (elapsed >= const Duration(minutes: 3)) await _forceUpdateWorldstate(locale);
    } else {
      // Assume there's no cache and update the state
      await _forceUpdateWorldstate(locale);
    }

    await emit.onEach<Worldstate>(
      repository.worldstateEmitter(locale),
      onData: (state) {
        if (isClosed) return;
        add(WorldstateUpdated(state..clean()));
      },
      onError: (error, stackTrace) async {
        if (isClosed) return;
        add(WorldstateFailed(error, stackTrace));
        undo();
        await Sentry.captureException(error, stackTrace: stackTrace);
      },
    );
  }

  Future<void> _forceUpdateWorldstate(String locale) async {
    try {
      final worldstate = await repository.fetchWorldstate(locale);
      if (isClosed) return;
      add(WorldstateUpdated(worldstate..clean()));
    } on Exception catch (error, stackTrace) {
      if (isClosed) return;
      add(WorldstateFailed(error, stackTrace));
      undo();
      await Sentry.captureException(error, stackTrace: stackTrace);
    }
  }

  @override
  WorldState? fromJson(Map<String, dynamic> json) {
    _logger.info('Hydrating state');
    try {
      final seed = Worldstate.fromMap(json);

      return WorldstateSuccess(seed);
    } on Exception catch (e, stack) {
      _logger.warning('Failed to load worldstate from cache', e, stack);
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
