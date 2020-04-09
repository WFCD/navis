import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/event.dart';

import 'job_model.dart';
import 'reward_model.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel extends Event {
  const EventModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String faction,
    String affiliatedWith,
    String description,
    String victimNode,
    String node,
    String tooltip,
    num maximumScore,
    num currentScore,
    num health,
    this.rewardModels,
    this.interimStepModels,
    this.jobModels,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          faction: faction,
          affiliatedWith: affiliatedWith,
          description: description,
          victimNode: victimNode,
          node: node,
          tooltip: tooltip,
          maximumScore: maximumScore,
          currentScore: currentScore,
          health: health,
          rewards: rewardModels,
          interimSteps: interimStepModels,
          jobs: jobModels,
        );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return _$EventModelFromJson(json);
  }

  @JsonKey(name: 'rewards')
  final List<RewardModel> rewardModels;

  @JsonKey(name: 'interimSteps')
  final List<InterimStepModel> interimStepModels;

  @JsonKey(name: 'jobs')
  final List<JobModel> jobModels;

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}

@JsonSerializable()
class InterimStepModel extends InterimStep {
  const InterimStepModel({int goal, this.rewardModel})
      : super(goal: goal, reward: rewardModel);

  factory InterimStepModel.fromJson(Map<String, dynamic> json) {
    return _$InterimStepModelFromJson(json);
  }

  @JsonKey(name: 'reward')
  final RewardModel rewardModel;

  Map<String, dynamic> toJson() => _$InterimStepModelToJson(this);
}
