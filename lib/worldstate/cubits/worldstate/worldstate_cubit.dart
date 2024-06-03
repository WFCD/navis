import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'worldstate_state.dart';

const String serverException = 'Failed to contact server';
const String formatException = 'Server returned a malformed response';
const String unknownException = r'Something happened ¯\_(ツ)_/¯';

class WorldstateCubit extends HydratedCubit<SolsystemState> {
  WorldstateCubit(this.repository) : super(SolsystemInitial());

  final WarframestatRepository repository;

  Future<void> fetchWorldstate() async {
    try {
      final state = await ConnectionManager.call(repository.fetchWorldstate);

      state.clean();
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
  SolsystemState? fromJson(Map<String, dynamic>? json) {
    Sentry.addBreadcrumb(Breadcrumb(message: 'WorldstateCubit.fromJson'));

    if (json == null) return null;

    try {
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
