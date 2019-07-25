import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navis/models/abstract_classes.dart';
import 'package:navis/models/worldstate/reward.dart';

part 'alerts.g.dart';

@JsonSerializable()
class Alert extends WorldstateObject {
  Alert({
    String id,
    DateTime activation,
    DateTime expiry,
    this.active,
    this.mission,
  }) : super(id: id, activation: activation, expiry: expiry);

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  final bool active;
  final Mission mission;

  Map<String, dynamic> toJson() => _$AlertToJson(this);
}

@JsonSerializable()
class Mission extends Equatable {
  Mission({
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

  factory Mission.fromJson(Map<String, dynamic> json) =>
      _$MissionFromJson(json);

  final String node, type, faction;
  final int minEnemyLevel, maxEnemyLevel, maxWaveNum;
  final bool nightmare, archwingRequired;

  final Reward reward;

  Map<String, dynamic> toJson() => _$MissionToJson(this);
}
