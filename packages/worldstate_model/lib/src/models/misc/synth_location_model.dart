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
    this.lastVerified,
    this.spawnRate,
  }) : super(
          faction: faction,
          mission: mission,
          planet: planet,
          level: level,
          type: type,
        );

  factory SynthLocationModel.fromJson(Map<String, dynamic> json) {
    return _$SynthLocationModelFromJson(json);
  }

  @override
  @JsonKey(name: 'last_verified')
  final String lastVerified;

  @override
  @JsonKey(name: 'spawn_rate')
  final String spawnRate;

  Map<String, dynamic> toJson() => _$SynthLocationModelToJson(this);
}
