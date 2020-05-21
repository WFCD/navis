import 'package:equatable/equatable.dart';

class SynthLocation extends Equatable {
  const SynthLocation({
    this.lastVerified,
    this.level,
    this.faction,
    this.spawnRate,
    this.mission,
    this.planet,
    this.type,
  });

  final String lastVerified;
  final String spawnRate;
  final String level, faction;
  final String mission, planet, type;

  @override
  List<Object> get props {
    return [lastVerified, level, faction, spawnRate, mission, planet, type];
  }
}
