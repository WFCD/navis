import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/sortie.dart';

part 'sortie_model.g.dart';

@JsonSerializable()
class SortieModel extends Sortie {
  const SortieModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String boss,
    String faction,
    this.variantModels,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          boss: boss,
          faction: faction,
          variants: variantModels,
        );

  factory SortieModel.fromJson(Map<String, dynamic> json) {
    return _$SortieModelFromJson(json);
  }

  @JsonKey(name: 'variants')
  final List<VariantModel> variantModels;

  Map<String, dynamic> toJson() => _$SortieModelToJson(this);
}

@JsonSerializable()
class VariantModel extends Variant {
  const VariantModel({
    String missionType,
    String modifier,
    String modifierDescription,
    String node,
  }) : super(
          missionType: missionType,
          modifier: modifier,
          modifierDescription: modifierDescription,
          node: node,
        );

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return _$VariantModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VariantModelToJson(this);
}
