import 'package:json_annotation/json_annotation.dart';

part 'target.g.dart';

@JsonSerializable()
class SynthTarget {
  const SynthTarget({this.name, this.locations});

  factory SynthTarget.fromJson(Map<String, dynamic> json) =>
      _$SynthTargetFromJson(json);

  final String name;
  final List<SynthLocation> locations;

  Map<String, dynamic> toJson() => _$SynthTargetToJson(this);
}

@JsonSerializable()
class SynthLocation {
  const SynthLocation({
    this.lastVerified,
    this.level,
    this.faction,
    this.spawnRate,
    this.mission,
    this.planet,
    this.type,
  });

  factory SynthLocation.fromJson(Map<String, dynamic> json) =>
      _$SynthLocationFromJson(json);

  @JsonKey(name: 'last_verified')
  final String lastVerified;

  @JsonKey(name: 'spawn_rate')
  final String spawnRate;

  final String level, faction;
  final String mission, planet, type;

  Map<String, dynamic> toJson() => _$SynthLocationToJson(this);
}
