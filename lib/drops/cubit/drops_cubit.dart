import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:warframe_drop_repository/warframe_drop_repository.dart';

part 'drops_state.dart';

class DropsCubit extends Cubit<DropsState> {
  DropsCubit(this._repository) : super(DropsInitial());

  final WarframeDropRepository _repository;

  void findBountyRewards(SyndicateBounty bounty) {
    emit(DropsLoading());
    final pool = _repository.findBountyRewards(bounty);
    emit(BountyDrops(rewards: pool));
  }

  void findRegionRewards(String node) {
    emit(DropsLoading());
    final rewards = _repository.findRegionRewardpools(node);
    emit(RegionDrops(rewards: rewards));
  }
}
