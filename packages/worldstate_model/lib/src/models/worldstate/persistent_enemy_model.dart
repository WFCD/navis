import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/persistent_enemy.dart';

part 'persistent_enemy_model.g.dart';

@JsonSerializable()
class PersistentEnemyModel extends PersistentEnemy {
  const PersistentEnemyModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String agentType,
    String locationTag,
    String lastDiscoveredAt,
    DateTime lastDiscoveredTime,
    int fleeDamage,
    int rank,
    double healthPercent,
    bool isDiscovered,
    bool isUsingTicketing,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          agentType: agentType,
          locationTag: locationTag,
          lastDiscoveredAt: lastDiscoveredAt,
          lastDiscoveredTime: lastDiscoveredTime,
          fleeDamage: fleeDamage,
          rank: rank,
          healthPercent: healthPercent,
          isDiscovered: isDiscovered,
          isUsingTicketing: isUsingTicketing,
        );

  factory PersistentEnemyModel.fromJson(Map<String, dynamic> json) {
    return _$PersistentEnemyModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PersistentEnemyModelToJson(this);
}
