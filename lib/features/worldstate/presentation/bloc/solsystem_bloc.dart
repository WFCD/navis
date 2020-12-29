import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/models.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/repositories/worldstate_rep_impl.dart';
import '../../domain/usecases/get_darvo_deal_info.dart';
import '../../domain/usecases/get_worldstate.dart';
import '../../utils/worldstate_util.dart';

part 'solsystem_event.dart';
part 'solsystem_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Failed to contact server';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SolsystemBloc extends HydratedBloc<SyncEvent, SolsystemState> {
  SolsystemBloc({
    @required this.getWorldstate,
    @required this.getDarvoDealInfo,
  })  : assert(getWorldstate != null),
        assert(getDarvoDealInfo != null),
        super(SolsystemInitial());

  final GetWorldstate getWorldstate;
  final GetDarvoDealInfo getDarvoDealInfo;

  @override
  Stream<SolsystemState> mapEventToState(
    SyncEvent event,
  ) async* {
    if (event is SyncSystemStatus) {
      try {
        final either = await getWorldstate(event.forceUpdate);

        yield either.fold(
          (l) => matchFailure(l),
          (r) => SolState(cleanState(r)),
        );
      } on ServerException {
        yield const SystemError(SERVER_FAILURE_MESSAGE);
      } on CacheException {
        yield const SystemError(CACHE_FAILURE_MESSAGE);
      }
    }
  }

  Future<void> update({bool forceUpdate}) async {
    add(SyncSystemStatus(forceUpdate: forceUpdate));
    await Future<void>.delayed(1.seconds);
  }

  Future<List<Item>> getDealInformation() async {
    final deals = (state as SolState).worldstate.dailyDeals;
    final info = <Item>[];

    for (final deal in deals) {
      final request = DealRequest(deal.id, deal.item);
      final either = await getDarvoDealInfo(request);

      either.fold(
        (l) => throw CacheException(),
        (r) => info.add(r),
      );
    }

    return info;
  }

  @override
  SolsystemState fromJson(Map<String, dynamic> json) {
    // Because worldstate is cleaned when it's cached there
    // is no need to clean it when returning from cache
    return SolState(WorldstateModel.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(SolsystemState state) {
    if (state is SolState) {
      return (state.worldstate as WorldstateModel).toJson();
    }

    return null;
  }
}
