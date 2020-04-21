// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return EventModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    faction: json['faction'] as String,
    affiliatedWith: json['affiliatedWith'] as String,
    description: json['description'] as String,
    victimNode: json['victimNode'] as String,
    node: json['node'] as String,
    tooltip: json['tooltip'] as String,
    maximumScore: json['maximumScore'] as num,
    currentScore: json['currentScore'] as num,
    health: json['health'] as num,
    rewardModels: (json['rewards'] as List)
        ?.map((e) =>
            e == null ? null : RewardModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    interimStepModels: (json['interimSteps'] as List)
        ?.map((e) => e == null
            ? null
            : InterimStepModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    jobModels: (json['jobs'] as List)
        ?.map((e) =>
            e == null ? null : JobModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'faction': instance.faction,
      'description': instance.description,
      'victimNode': instance.victimNode,
      'node': instance.node,
      'tooltip': instance.tooltip,
      'affiliatedWith': instance.affiliatedWith,
      'health': instance.health,
      'currentScore': instance.currentScore,
      'maximumScore': instance.maximumScore,
      'rewards': instance.rewardModels?.map((e) => e?.toJson())?.toList(),
      'interimSteps':
          instance.interimStepModels?.map((e) => e?.toJson())?.toList(),
      'jobs': instance.jobModels?.map((e) => e?.toJson())?.toList(),
    };

InterimStepModel _$InterimStepModelFromJson(Map<String, dynamic> json) {
  return InterimStepModel(
    goal: json['goal'] as int,
    rewardModel: json['reward'] == null
        ? null
        : RewardModel.fromJson(json['reward'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InterimStepModelToJson(InterimStepModel instance) =>
    <String, dynamic>{
      'goal': instance.goal,
      'reward': instance.rewardModel?.toJson(),
    };
