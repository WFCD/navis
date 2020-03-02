import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'package:navis/features/worldstate/domain/usecases/get_synth_targets.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:supercharged/supercharged.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

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

  @override
  SolsystemState get initialState => SolsystemInitial();

  @override
  Stream<SolsystemState> mapEventToState(
    SyncEvent event,
  ) async* {
    if (event is SyncSystemStatus) {
      try {
        final worldstate = await getWorldstate(event.platform);
        final dealInfo = await _getDealInformation(worldstate.dailyDeals);
        final synthTargets = await getSynthTargets(NoParama());

        yield SolState(
          worldstate: worldstate,
          dealInfo: dealInfo,
          synthTargets: synthTargets,
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

  @override
  SolsystemState fromJson(Map<String, dynamic> json) {
    return SolState(worldstate: Worldstate.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(SolsystemState state) {
    if (state is SolState) return state.worldstate.toJson();

    return null;
  }

  Future<List<BaseItem>> _getDealInformation(List<DarvoDeal> deals) async {
    final info = <BaseItem>[];

    for (final deal in deals) {
      final request = DealRequest(deal.id, deal.item);
      info.add(await getDarvoDealInfo(request));
    }

    return info;
  }
}
