part of 'drops_cubit.dart';

sealed class DropsState extends Equatable {
  const DropsState();

  @override
  List<Object> get props => [];
}

final class DropsInitial extends DropsState {}

final class DropsLoading extends DropsState {}

final class BountyDrops extends DropsState {
  const BountyDrops({required this.rewards});

  final BountyRewardpool rewards;

  @override
  List<Object> get props => [rewards];

  @override
  String toString() => 'BountyDrops(${rewards.rewards.length})';
}

final class RegionDrops extends DropsState {
  const RegionDrops({required this.rewards});

  final List<RegionRewardPool> rewards;

  @override
  List<Object> get props => [rewards];

  @override
  String toString() => 'RegionDrops(${rewards.length})';
}
