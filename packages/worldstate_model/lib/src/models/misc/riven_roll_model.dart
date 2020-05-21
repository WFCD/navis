import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/misc/riven_roll.dart';

part 'riven_roll_model.g.dart';

@JsonSerializable()
class RivenRollModel extends RivenRoll {
  const RivenRollModel({
    String itemType,
    String compatibility,
    bool rerolled,
    double avg,
    double stddev,
    double median,
    int min,
    int max,
    int pop,
  }) : super(
          itemType: itemType,
          compatibility: compatibility,
          rerolled: rerolled,
          avg: avg,
          stddev: stddev,
          median: median,
          min: min,
          max: max,
          pop: pop,
        );

  factory RivenRollModel.fromJson(Map<String, dynamic> json) {
    return _$RivenRollModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RivenRollModelToJson(this);
}
