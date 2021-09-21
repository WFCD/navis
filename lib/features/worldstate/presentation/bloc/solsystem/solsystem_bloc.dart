import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../../../constants/default_durations.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/usecases/get_worldstate.dart';
import '../../../utils/worldstate_util.dart';

part 'solsystem_event.dart';
part 'solsystem_state.dart';

const String serverFailureMessage = 'Failed to contact server';
const String cacheFailureMessage = 'Cache Failure';

class SolsystemBloc extends HydratedBloc<SyncEvent, SolsystemState> {
  SolsystemBloc({required this.getWorldstate}) : super(SolsystemInitial()) {
    on<SyncSystemStatus>(_syncSystem);
  }

  final GetWorldstate getWorldstate;

  Future<void> _syncSystem(
    SyncSystemStatus event,
    Emitter<SolsystemState> emit,
  ) async {
    try {
      final either = await getWorldstate(event.forceUpdate);

      either.match((r) => emit(SolState(cleanState(r))), matchFailure);
    } on ServerException {
      emit(const SystemError(serverFailureMessage));
    } on CacheException {
      emit(const SystemError(cacheFailureMessage));
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(SystemError(e.toString()));
    }
  }

  Future<void> update({bool forceUpdate = false}) async {
    await Future<void>.delayed(
      kDelayShort,
      () => add(SyncSystemStatus(forceUpdate: forceUpdate)),
    );
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
