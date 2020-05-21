import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component_drop.g.dart';

@JsonSerializable()
class ComponentDrop extends Equatable {
  const ComponentDrop({
    this.location,
    this.type,
    this.rarity,
    this.rotation,
    this.chance,
  });

  factory ComponentDrop.fromJson(Map<String, dynamic> json) {
    return _$ComponentDropFromJson(json);
  }

  final String location, type, rarity, rotation;
  final double chance;

  Map<String, dynamic> toJson() => _$ComponentDropToJson(this);

  @override
  List<Object> get props {
    return [location, type, rarity, chance, rotation];
  }
}
