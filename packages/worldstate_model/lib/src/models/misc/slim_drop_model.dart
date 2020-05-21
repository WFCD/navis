import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/misc/slim_drop.dart';

part 'slim_drop_model.g.dart';

@JsonSerializable()
class SlimDropModel extends SlimDrop {
  const SlimDropModel({
    String place,
    String item,
    String rarity,
    this.dropchance,
  }) : super(
          place: place,
          item: item,
          rarity: rarity,
          dropChance: dropchance,
        );

  factory SlimDropModel.fromJson(Map<String, dynamic> json) {
    return _$SlimDropModelFromJson(json);
  }

  @JsonKey(name: 'chance')
  final dynamic dropchance;

  Map<String, dynamic> toJson() => _$SlimDropModelToJson(this);
}
