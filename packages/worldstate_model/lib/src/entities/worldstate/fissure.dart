import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class VoidFissure extends WorldstateObject {
  const VoidFissure({
    String id,
    DateTime activation,
    DateTime expiry,
    this.node,
    this.missionType,
    this.enemy,
    this.tier,
    this.tierNum,
    this.active,
    this.expired,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String node, missionType, enemy, tier;
  final int tierNum;
  final bool active, expired;

  @override
  List<Object> get props {
    return super.props
      ..addAll([node, missionType, enemy, tier, tierNum, active, expired]);
  }
}
