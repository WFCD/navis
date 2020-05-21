import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability extends Equatable {
  const Ability({this.name, this.description});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  final String name, description;

  Map<String, dynamic> toJson() => _$AbilityToJson(this);

  @override
  List<Object> get props => [name, description];
}
