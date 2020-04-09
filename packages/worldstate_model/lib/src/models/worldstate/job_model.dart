import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/job.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel extends Job {
  const JobModel({
    String type,
    this.rewardpool,
    List<int> enemyLevels,
    List<int> standingStages,
  }) : super(
          rewardpool,
          type: type,
          enemyLevels: enemyLevels,
          standingStages: standingStages,
        );

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return _$JobModelFromJson(json);
  }

  @JsonKey(name: 'rewardPool')
  final dynamic rewardpool;

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
