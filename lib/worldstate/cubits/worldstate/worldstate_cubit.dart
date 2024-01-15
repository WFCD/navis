import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

part 'worldstate_state.dart';

const String serverException = 'Failed to contact server';
const String formatException = 'Server returned a malformed response';
const String unknownException = r'Something happened ¯\_(ツ)_/¯';

class WorldstateCubit extends HydratedCubit<SolsystemState> {
  WorldstateCubit(this.repository) : super(SolsystemInitial());

  final WorldstateRepository repository;

  Future<void> fetchWorldstate(
    Locale locale, {
    bool forceUpdate = false,
  }) async {
    try {
      final state = await repository.getWorldstate(
        language: Language.values.firstWhere(
          (e) => e.name == locale.languageCode,
          orElse: () => Language.en,
        ),
        forceUpdate: forceUpdate,
      );

      _cleanState(state);

      emit(WorldstateSuccess(state));
    } catch (e, s) {
      final current = state;
      await _exceptionHandle(e, s);
      emit(current);

      // SocketExceptions are when the user disconnects from the internet
      // and so we don't need to track these errors.
      if (e is SocketException) return;

      // Rethrow the error so the obsover can catch it and send it to sentry.
      rethrow;
    }
  }

  void _cleanState(Worldstate state) {
    state.alerts.retainWhere((e) => e.active);

    state.news.sort((a, b) => b.date.compareTo(a.date));

// state.persistentEnemies?.sort((a, b) => a.agentType.compareTo(b.agentType));

    state.syndicateMissions
      ..retainWhere((s) => s.jobs.isNotEmpty)
      ..sort((a, b) => a.syndicate.compareTo(b.syndicate));

    state.fissures
      ..retainWhere((e) => !e.expired)
      ..sort((a, b) => a.tierNum.compareTo(b.tierNum));

    state.invasions.retainWhere((e) => !e.completed);
  }

  Future<void> _exceptionHandle(Object exception, [StackTrace? s]) async {
    switch (exception) {
      case SocketException:
        emit(const WorldstateFailure(serverException));
      case FormatException:
        emit(const WorldstateFailure(formatException));
      default:
        await Sentry.captureException(exception, stackTrace: s);
        emit(const WorldstateFailure(unknownException));
    }
  }

  @override
  SolsystemState? fromJson(Map<String, dynamic> json) {
    try {
      // Because worldstate is cleaned when it's cached there
      // is no need to clean it when returning from cache.
      return WorldstateSuccess(Worldstate.fromJson(json));
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SolsystemState state) {
    if (state is WorldstateSuccess) {
      return state.worldstate.toJson();
    }

    return null;
  }
}
