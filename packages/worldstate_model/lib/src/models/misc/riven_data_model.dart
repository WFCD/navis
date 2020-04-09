import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/misc/riven_data.dart';

import 'riven_roll_model.dart';

part 'riven_data_model.g.dart';

@JsonSerializable()
class RivenDataModel extends RivenData {
  const RivenDataModel({this.rerolledModel, this.unrolledModel})
      : super(rerolled: rerolledModel, unrolled: unrolledModel);

  factory RivenDataModel.fromJson(Map<String, dynamic> json) {
    return _$RivenDataModelFromJson(json);
  }

  @JsonKey(name: 'rerolled')
  final RivenRollModel rerolledModel;

  @JsonKey(name: 'unrolled')
  final RivenRollModel unrolledModel;

  Map<String, dynamic> toJson() => _$RivenDataModelToJson(this);
}
