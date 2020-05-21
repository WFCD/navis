import 'package:equatable/equatable.dart';

import 'reward.dart';

class Mission extends Equatable {
  const Mission({
    this.node,
    this.type,
    this.faction,
    this.minEnemyLevel,
    this.maxEnemyLevel,
    this.maxWaveNum,
    this.nightmare,
    this.archwingRequired,
    this.reward,
  });

  final String node, type, faction;
  final int minEnemyLevel, maxEnemyLevel, maxWaveNum;
  final bool nightmare, archwingRequired;

  final Reward reward;

  @override
  List<Object> get props {
    return [
      node,
      type,
      minEnemyLevel,
      maxEnemyLevel,
      maxWaveNum,
      nightmare,
      archwingRequired,
      reward
    ];
  }
}
