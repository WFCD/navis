import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_remote.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

part 'solsystem_event.dart';
part 'solsystem_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Failed to contact server';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SolsystemBloc extends HydratedBloc<SolsystemEvent, SolsystemState> {
  SolsystemBloc({
    @required GetWorldstate worldstate,
  })  : assert(worldstate != null),
        getWorldstate = worldstate;

  final GetWorldstate getWorldstate;

  @override
  SolsystemState get initialState => SolsystemInitial();

  @override
  Stream<SolsystemState> mapEventToState(
    SolsystemEvent event,
  ) async* {
    if (event is SolupdateSystem) {
      yield DetectingState();
      final worldstate = await getWorldstate(event.platform);

      yield* worldstate.fold(
        (failure) async* {
          yield SystemError(_mapFailureToMessage(failure));
        },
        (worldstate) async* {
          yield SolState(worldstate);
        },
      );
    }
  }

  Future<void> update() async {
    add(const SolupdateSystem(GamePlatforms.pc));
  }

  @override
  SolsystemState fromJson(Map<String, dynamic> json) {
    return SolState(Worldstate.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(SolsystemState state) {
    if (state is SolState) return state.worldstate.toJson();

    return null;
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
