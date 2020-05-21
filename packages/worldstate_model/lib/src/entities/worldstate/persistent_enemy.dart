import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class PersistentEnemy extends WorldstateObject {
  const PersistentEnemy({
    String id,
    DateTime activation,
    DateTime expiry,
    this.agentType,
    this.locationTag,
    this.lastDiscoveredAt,
    this.lastDiscoveredTime,
    this.fleeDamage,
    this.rank,
    this.healthPercent,
    this.isDiscovered,
    this.isUsingTicketing,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String agentType, locationTag, lastDiscoveredAt;
  final DateTime lastDiscoveredTime;
  final int fleeDamage, rank;
  final double healthPercent;
  final bool isDiscovered, isUsingTicketing;

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        agentType,
        locationTag,
        lastDiscoveredAt,
        lastDiscoveredTime,
        fleeDamage,
        rank,
        healthPercent,
        isDiscovered,
        isUsingTicketing
      ]);
  }
}
