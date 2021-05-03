import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../domain/usecases/get_worldstate.dart';
import '../../../utils/worldstate_util.dart';

part 'solsystem_event.dart';
part 'solsystem_state.dart';

const String serverFailureMessage = 'Failed to contact server';
const String cacheFailureMessage = 'Cache Failure';

class SolsystemBloc extends HydratedBloc<SyncEvent, SolsystemState> {
  SolsystemBloc({required this.getWorldstate}) : super(SolsystemInitial());

  final GetWorldstate getWorldstate;

  @override
  Stream<SolsystemState> mapEventToState(
    SyncEvent event,
  ) async* {
    if (event is SyncSystemStatus) {
      try {
        final either = await getWorldstate(event.forceUpdate);

        yield either.match((r) => SolState(cleanState(r)), matchFailure);
      } on ServerException {
        yield const SystemError(serverFailureMessage);
      } on CacheException {
        yield const SystemError(cacheFailureMessage);
      } on UnknownException {
        yield const SystemError('Unknown error occured');
      }
    }
  }

  Future<void> update({bool forceUpdate = false}) async {
    add(SyncSystemStatus(forceUpdate: forceUpdate));
    await Future<void>.delayed(1.seconds);
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
