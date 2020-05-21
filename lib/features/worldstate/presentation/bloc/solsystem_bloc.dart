import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/core/network/warframestat_remote.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:supercharged/supercharged.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/worldstate_util.dart';
import '../../data/repositories/worldstate_rep_impl.dart';
import '../../domain/usecases/get_darvo_deal_info.dart';
import '../../domain/usecases/get_worldstate.dart';

part 'solsystem_event.dart';
part 'solsystem_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Failed to contact server';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SolsystemBloc extends HydratedBloc<SyncEvent, SolsystemState> {
  SolsystemBloc({
    @required this.getWorldstate,
    @required this.getDarvoDealInfo,
  })  : assert(getWorldstate != null),
        assert(getDarvoDealInfo != null);

  final GetWorldstate getWorldstate;
  final GetDarvoDealInfo getDarvoDealInfo;

  @override
  SolsystemState get initialState => SolsystemInitial();

  @override
  Stream<SolsystemState> mapEventToState(
    SyncEvent event,
  ) async* {
    if (event is SyncSystemStatus) {
      try {
        final either = await getWorldstate(NoParama());

        yield either.fold(
          (l) => _matchFailure(l),
          (r) => SolState(cleanState(r)),
        );
      } on ServerException {
        yield const SystemError(SERVER_FAILURE_MESSAGE);
      } on CacheException {
        yield const SystemError(CACHE_FAILURE_MESSAGE);
      }
    }
  }

  Future<void> update() async {
    add(const SyncSystemStatus(GamePlatforms.pc));
    await Future<void>.delayed(1.seconds);
  }

  Future<List<BaseItem>> getDealInformation() async {
    final deals = (state as SolState).worldstate?.dailyDeals ?? [];
    final info = <BaseItem>[];

    for (final deal in deals) {
      final request = DealRequest(deal.id, deal.item);
      final either = await getDarvoDealInfo(request);

      either.fold(
        (l) => info.add(BaseItem(
          name: deal.item,
          description: '',
          type: 'unknown',
          imageName: '',
        )),
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

  SolsystemState _matchFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        throw ServerException();
      case CacheException:
        throw CacheException();
      default:
        throw UnknownException();
    }
  }
}
