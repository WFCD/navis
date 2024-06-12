import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/profile/utils/mastery_utils.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'mastery_cal_state.dart';

typedef PlayerXPInfo = ({
  int rank,
  List<XpItem> items,
  List<ProfileMission> missions
});

class MasteryCalCubit extends Cubit<MasteryCalState> {
  MasteryCalCubit(this.repository) : super(const MasteryInitial());

  final WarframestatRepository repository;

  Future<void> calculateMastery(PlayerXPInfo xpInfo) async {
    try {
      final inventory = inventoryMastery(xpInfo.items);
      final regionMastery = await repository.fetchNodeMastery();
      final nodes = nodeMastery(xpInfo.missions, regionMastery);

      emit(MasteryCalculated(owned: inventory + nodes, rank: xpInfo.rank));
    } catch (e) {
      emit(MasteryFailure(e.toString()));
    }
  }
}
