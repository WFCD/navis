import 'dart:async';
import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/worldstate/cubits/solsystem/solsystem_state.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

const String serverException = 'Failed to contact server';
const String formatException = 'Server returned a malformed response';
const String unknownException = r'Something happened ¯\_(ツ)_/¯';

class SolsystemCubit extends HydratedCubit<SolsystemState> {
  SolsystemCubit(this.repository) : super(SolsystemInitial());

  final WorldstateRepository repository;

  Future<void> fetchWorldstate({bool forceUpdate = false}) async {
    try {
      final state = await repository.getWorldstate(forceUpdate: forceUpdate);

      emit(SolState(_cleanState(state)));
    } catch (e, s) {
      final current = state;
      await _exceptionHandle(e, s);
      emit(current);

      // Rethrow the error so the obsover can catch it and send it to sentry.
      rethrow;
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

  Future<void> _exceptionHandle(Object exception, [StackTrace? s]) async {
    switch (exception.runtimeType) {
      case SocketException:
        emit(const SystemError(serverException));
        break;
      case FormatException:
        emit(const SystemError(formatException));
        break;
      default:
        await Sentry.captureException(exception, stackTrace: s);
        emit(const SystemError(unknownException));
    }
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
