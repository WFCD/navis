part of 'drops_cubit.dart';

sealed class DropsState extends Equatable {
  const new();

  @override
  List<Object> get props => [];
}

final class DropsInitial extends DropsState;

final class DropsLoading extends DropsState;

final class BountyDrops extends DropsState {
  const new({required this.rewardPoolString, required this.rewards});

  final String rewardPoolString;
  final BountyRewardpool rewards;

  @override
  List<Object> get props => [rewards];

  @override
  String toString() => 'BountyDrops(${rewards.rewards.length})';
}

final class RegionDrops extends DropsState {
  const new({required this.node, required this.rewards});

  final String node;
  final List<RegionRewardPool> rewards;

  @override
  List<Object> get props => [rewards];

  @override
  String toString() => 'RegionDrops($node - rewards(${rewards.length}))';
}
