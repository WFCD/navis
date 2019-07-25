import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navis/models/abstract_classes.dart';

part 'syndicate.g.dart';

@JsonSerializable()
class Syndicate extends WorldstateObject {
  Syndicate({
    String id,
    DateTime activation,
    DateTime expiry,
    this.syndicate,
    this.active,
    this.jobs,
  }) : super(id: id, activation: activation, expiry: expiry);

  factory Syndicate.fromJson(Map<String, dynamic> json) =>
      _$SyndicateFromJson(json);

  final String syndicate;
  final bool active;
  final List<Jobs> jobs;

  Map<String, dynamic> toJson() => _$SyndicateToJson(this);
}

@JsonSerializable()
class Jobs extends Equatable {
  Jobs({
    this.type,
    this.pool,
    this.enemyLevels,
    this.standingStages,
  }) : super([type, pool, enemyLevels, standingStages]);

  factory Jobs.fromJson(Map<String, dynamic> json) => _$JobsFromJson(json);

  final String type;

  @JsonKey(name: 'rewardPool')
  final dynamic pool;

  final List<int> enemyLevels, standingStages;

  Map<String, dynamic> toJson() => _$JobsToJson(this);

  List<String> get rewardPool =>
      pool is List ? pool.cast<String>() : <String>[];
}
