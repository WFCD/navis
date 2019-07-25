import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'slim.g.dart';

@JsonSerializable()
class Drop extends Equatable {
  Drop({this.place, this.item, this.rarity, this.dropChance})
      : super([place, item, rarity, dropChance]);

  factory Drop.fromJson(Map<String, dynamic> json) => _$DropFromJson(json);

  final String place, item, rarity;

  @JsonKey(name: 'chance')
  final dynamic dropChance;

  num get chance => dropChance is String ? num.parse(dropChance) : dropChance;

  Map<String, dynamic> toJson() => _$DropToJson(this);
}
