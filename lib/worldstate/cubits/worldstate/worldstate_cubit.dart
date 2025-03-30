import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'worldstate_state.dart';

class WorldstateCubit extends HydratedCubit<SolsystemState> with ReplayCubitMixin {
  WorldstateCubit(this.repository) : super(SolsystemInitial());

  final WarframestatRepository repository;

  static final _logger = Logger('WorldstateCubit');

  Future<void> fetchWorldstate() async {
    try {
      _logger.info('Updating Worldstate');
      final state = await ConnectionManager.call(repository.fetchWorldstate);

      state.clean();
      emit(WorldstateSuccess(state));
    } on SocketException {
      emit(WorldstateFailure());
    } on FormatException {
      emit(WorldstateFailure());
    } on Exception catch (e, stack) {
      _logger.shout('Weird exception happened', e, stack);

      // I want to tigger listeners then retore previous state
      emit(WorldstateFailure());
      undo();
    }
  }

  @override
  SolsystemState? fromJson(Map<String, dynamic>? json) {
    _logger.info('Hydrating Worldstate');
    if (json == null) return null;

    return WorldstateSuccess(Worldstate.fromJson(json));
  }

  @override
  Map<String, dynamic>? toJson(SolsystemState state) {
    _logger.info('Caching current state');
    if (state is! WorldstateSuccess) return null;

    return state.worldstate.toJson();
  }
}
