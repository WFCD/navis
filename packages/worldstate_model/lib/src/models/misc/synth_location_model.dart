import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/misc/synth_location.dart';

part 'synth_location_model.g.dart';

@JsonSerializable()
class SynthLocationModel extends SynthLocation {
  const SynthLocationModel({
    String faction,
    String mission,
    String planet,
    String level,
    String type,
    String last_verified,
    String spawn_rate,
  }) : super(
          faction: faction,
          mission: mission,
          planet: planet,
          level: level,
          type: type,
          lastVerified: last_verified,
          spawnRate: spawn_rate,
        );

  factory SynthLocationModel.fromJson(Map<String, dynamic> json) {
    return _$SynthLocationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SynthLocationModelToJson(this);
}
