import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward.g.dart';

@JsonSerializable()
class Reward extends Equatable {
  Reward({this.itemString, this.thumbnail, this.asString, this.credits})
      : super([itemString, thumbnail, asString, credits]);

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  final String itemString, thumbnail, asString;
  final int credits;

  Map<String, dynamic> toJson() => _$RewardToJson(this);
}
