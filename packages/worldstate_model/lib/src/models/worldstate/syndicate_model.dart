import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/syndicate.dart';

import 'job_model.dart';

part 'syndicate_model.g.dart';

@JsonSerializable()
class SyndicateModel extends Syndicate {
  const SyndicateModel({
    String id,
    DateTime activation,
    DateTime expiry,
    this.syndicate,
    bool active,
    this.jobModels,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          name: syndicate,
          active: active,
          jobs: jobModels,
        );

  factory SyndicateModel.fromJson(Map<String, dynamic> json) {
    return _$SyndicateModelFromJson(json);
  }

  final String syndicate;

  @JsonKey(name: 'jobs')
  final List<JobModel> jobModels;

  Map<String, dynamic> toJson() => _$SyndicateModelToJson(this);
}
