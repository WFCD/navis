import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

import 'reward.dart';

class Invasion extends WorldstateObject {
  const Invasion({
    String id,
    DateTime activation,
    DateTime expiry,
    this.node,
    this.desc,
    this.attackingFaction,
    this.defendingFaction,
    this.eta,
    this.vsInfestation,
    this.completed,
    this.completion,
    this.count,
    this.attackerRewardInfo,
    this.defenderRewardInfo,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String node, desc, attackingFaction, defendingFaction, eta;
  final bool vsInfestation, completed;
  final num completion, count;
  final Reward attackerRewardInfo, defenderRewardInfo;

  /// shorthand for [attackerRewardInfo.itemString]
  String get attackerReward => attackerRewardInfo.itemString;

  /// shorthand for [defenderRewardInfo.itemString]
  String get defenderReward => defenderRewardInfo.itemString;

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        node,
        desc,
        attackingFaction,
        defendingFaction,
        eta,
        vsInfestation,
        completed,
        completion,
        count,
        attackerReward,
        defenderReward,
      ]);
  }
}
