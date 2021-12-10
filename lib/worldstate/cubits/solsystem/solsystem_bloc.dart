import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/worldstate/cubits/solsystem/solsystem_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

const String serverFailureMessage = 'Failed to contact server';
const String cacheFailureMessage = 'Cache Failure';

class SolsystemCubit extends HydratedCubit<SolsystemState> {
  SolsystemCubit(this.repository) : super(SolsystemInitial());

  final WorldstateRepository repository;

  Future<void> fetchWorldstate({bool forceUpdate = false}) async {
    try {
      final state = await repository.getWorldstate(forceUpdate: forceUpdate);

      emit(SolState(_cleanState(state)));
    } on ServerException {
      emit(const SystemError(serverFailureMessage));
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(SystemError(e.toString()));
    }
  }

  Worldstate _cleanState(Worldstate state) {
    state.alerts.retainWhere((e) => e.active);

    state.news.sort((a, b) => b.date.compareTo(a.date));

    state.persistentEnemies?.sort((a, b) => a.agentType.compareTo(b.agentType));

    state.syndicateMissions
      ..retainWhere((s) => s.jobs.isNotEmpty)
      ..sort((a, b) => a.name.compareTo(b.name));

    state.fissures
      ..retainWhere((e) => !e.expired)
      ..sort((a, b) => a.tierNum.compareTo(b.tierNum));

    state.invasions.retainWhere((e) => !e.completed);

    return state;
  }

  @override
  SolsystemState? fromJson(Map<String, dynamic> json) {
    try {
      // Because worldstate is cleaned when it's cached there
      // is no need to clean it when returning from cache.
      return SolState(WorldstateModel.fromJson(json));
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SolsystemState state) {
    if (state is SolState) {
      return (state.worldstate as WorldstateModel).toJson();
    }

    return null;
  }
}
