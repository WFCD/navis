import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/utils/worldstate_util.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/domain/usecases/get_synth_targets.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:supercharged/supercharged.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/base.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

part 'solsystem_event.dart';
part 'solsystem_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Failed to contact server';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class SolsystemBloc extends HydratedBloc<SyncEvent, SolsystemState> {
  SolsystemBloc({
    @required this.getWorldstate,
    @required this.getDarvoDealInfo,
    @required this.getSynthTargets,
  })  : assert(getWorldstate != null),
        assert(getDarvoDealInfo != null),
        assert(getSynthTargets != null);

  final GetWorldstate getWorldstate;
  final GetDarvoDealInfo getDarvoDealInfo;
  final GetSynthTargets getSynthTargets;

  String currentLocale;

  @override
  SolsystemState get initialState => SolsystemInitial();

  @override
  Stream<SolsystemState> mapEventToState(
    SyncEvent event,
  ) async* {
    if (event is SyncSystemStatus) {
      final instance =
          GetWorldstateInstance(event.platform, lang: currentLocale);
      try {
        final either = await getWorldstate(instance);

        yield either.fold(
          (l) => throw Exception(),
          (r) => SolState(cleanState(r)),
        );
      } on ServerFailure {
        yield const SystemError(SERVER_FAILURE_MESSAGE);
      } on CacheFailure {
        yield const SystemError(CACHE_FAILURE_MESSAGE);
      }
    }
  }

  Future<void> update() async {
    add(const SyncSystemStatus(GamePlatforms.pc));
    await Future<void>.delayed(1.seconds);
  }

  Future<List<BaseItem>> getDealInformation() async {
    if (state is SolState) {
      final deals = (state as SolState).worldstate.dailyDeals;
      final info = <BaseItem>[];

      for (final deal in deals) {
        final request = DealRequest(deal.id, deal.item);
        final either = await getDarvoDealInfo(request);

        either.fold((l) => throw Exception(), (r) => info.add(r));
      }

      return info;
    } else {
      //TODO: return cached versions if possible
      return null;
    }
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
