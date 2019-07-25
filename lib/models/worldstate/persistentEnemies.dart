import 'package:json_annotation/json_annotation.dart';
import 'package:navis/models/abstract_classes.dart';

part 'persistentEnemies.g.dart';

@JsonSerializable()
class PersistentEnemie extends WorldstateObject {
  PersistentEnemie({
    String id,
    DateTime activation,
    DateTime expiry,
    this.agentType,
    this.locationTag,
    this.lastDiscoveredAt,
    this.lastDiscoveredTime,
    this.fleeDamage,
    this.region,
    this.rank,
    this.healthPercent,
    this.isDiscovered,
    this.isUsingTicketing,
  }) : super(id: id, activation: activation, expiry: expiry);

  factory PersistentEnemie.fromJson(Map<String, dynamic> json) =>
      _$PersistentEnemieFromJson(json);

  final String agentType, locationTag, lastDiscoveredAt;
  final DateTime lastDiscoveredTime;
  final int fleeDamage, region, rank;
  final num healthPercent;
  final bool isDiscovered, isUsingTicketing;

  Map<String, dynamic> toJson() => _$PersistentEnemieToJson(this);
}
