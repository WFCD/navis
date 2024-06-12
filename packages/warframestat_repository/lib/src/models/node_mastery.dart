import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_mastery.g.dart';

@JsonSerializable()
class NodeMastery extends Equatable {
  const NodeMastery({
    required this.name,
    required this.uniqueName,
    required this.systemIndex,
    required this.nodeType,
    required this.masteryReq,
    required this.missionIndex,
    required this.factionIndex,
    required this.minEnemyLevel,
    required this.maxEnemyLevel,
    required this.mastery,
  });

  factory NodeMastery.fromJson(Map<String, dynamic> json) {
    return _$NodeMasteryFromJson(json);
  }

  final String name;
  final String uniqueName;
  final int systemIndex;
  final int nodeType;
  final int masteryReq;
  final int missionIndex;
  final int factionIndex;
  final int minEnemyLevel;
  final int maxEnemyLevel;
  final int mastery;

  Map<String, dynamic> toJson() => _$NodeMasteryToJson(this);

  @override
  List<Object?> get props {
    return [
      name,
      uniqueName,
      systemIndex,
      nodeType,
      masteryReq,
      missionIndex,
      factionIndex,
      minEnemyLevel,
      maxEnemyLevel,
      mastery,
    ];
  }
}
