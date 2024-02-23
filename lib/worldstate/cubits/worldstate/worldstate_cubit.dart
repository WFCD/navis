import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/utils.dart';
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
      Worldstate state;

      if (await hasInternetConnection) {
        state = await repository.getWorldstate(
          language: Language.values.firstWhere(
            (e) => e.name == locale.languageCode,
            orElse: () => Language.en,
          ),
          forceUpdate: forceUpdate,
        )
          ..clean();

        emit(WorldstateSuccess(state));
      }

      state = await onReconnect(
        () async => repository.getWorldstate(
          language: Language.values.firstWhere(
            (e) => e.name == locale.languageCode,
            orElse: () => Language.en,
          ),
          forceUpdate: forceUpdate,
        ),
      )
        ..clean();

      emit(WorldstateSuccess(state));
    } catch (e, s) {
      final current = state;
      await _exceptionHandle(e, s);
      emit(current);
    }
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
