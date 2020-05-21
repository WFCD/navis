import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/misc/synth_target.dart';

import 'synth_location_model.dart';

part 'synth_target_model.g.dart';

@JsonSerializable()
class SynthTargetModel extends SynthTarget {
  const SynthTargetModel({
    String name,
    this.locationModels,
  }) : super(name: name, locations: locationModels);

  factory SynthTargetModel.fromJson(Map<String, dynamic> json) {
    return _$SynthTargetModelFromJson(json);
  }

  @JsonKey(name: 'locations')
  final List<SynthLocationModel> locationModels;

  Map<String, dynamic> toJson() => _$SynthTargetModelToJson(this);
}
