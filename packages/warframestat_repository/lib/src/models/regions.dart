import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'regions.g.dart';

@JsonSerializable()
class CraigJunction extends Equatable {
  const CraigJunction({
    required this.uniqueName,
    required this.name,
    required this.systemIndex,
    required this.minEnemyLevel,
    required this.maxEnemyLevel,
    required this.mastery,
    required this.targetSystemIndex,
  });

  factory CraigJunction.fromJson(Map<String, dynamic> json) {
    return _$CraigJunctionFromJson(json);
  }

  final String uniqueName;
  final String name;
  final int systemIndex;
  final int minEnemyLevel;
  final int maxEnemyLevel;
  final int mastery;
  final int targetSystemIndex;

  Map<String, dynamic> toJson() => _$CraigJunctionToJson(this);

  @override
  List<Object?> get props => [
        uniqueName,
        name,
        systemIndex,
        minEnemyLevel,
        maxEnemyLevel,
        mastery,
        targetSystemIndex,
      ];
}

@JsonSerializable()
class CraigNode extends Equatable {
  const CraigNode({
    required this.uniqueName,
    required this.name,
    required this.systemIndex,
    required this.minEnemyLevel,
    required this.maxEnemyLevel,
    required this.mastery,
    required this.nodeType,
    required this.masteryReq,
    required this.missionIndex,
    required this.factionIndex,
  });

  factory CraigNode.fromJson(Map<String, dynamic> json) {
    return _$CraigNodeFromJson(json);
  }

  final String uniqueName;
  final String name;
  final int systemIndex;
  final int minEnemyLevel;
  final int maxEnemyLevel;
  final int mastery;
  final int nodeType;
  final int masteryReq;
  final int missionIndex;
  final int factionIndex;

  Map<String, dynamic> toJson() => _$CraigNodeToJson(this);

  @override
  List<Object?> get props => [
        uniqueName,
        name,
        systemIndex,
        minEnemyLevel,
        maxEnemyLevel,
        mastery,
        nodeType,
        masteryReq,
        missionIndex,
        factionIndex,
      ];
}
