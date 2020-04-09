// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) {
  return JobModel(
    type: json['type'] as String,
    rewardpool: json['rewardPool'],
    enemyLevels: (json['enemyLevels'] as List)?.map((e) => e as int)?.toList(),
    standingStages:
        (json['standingStages'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
      'type': instance.type,
      'enemyLevels': instance.enemyLevels,
      'standingStages': instance.standingStages,
      'rewardPool': instance.rewardpool,
    };
