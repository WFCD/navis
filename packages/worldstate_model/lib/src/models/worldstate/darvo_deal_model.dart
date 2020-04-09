import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/darvo_deal.dart';

part 'darvo_deal_model.g.dart';

@JsonSerializable()
class DarvoDealModel extends DarvoDeal {
  const DarvoDealModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String item,
    int originalPrice,
    int salePrice,
    int total,
    int sold,
    int discount,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          item: item,
          originalPrice: originalPrice,
          salePrice: salePrice,
          total: total,
          sold: sold,
          discount: discount,
        );

  factory DarvoDealModel.fromJson(Map<String, dynamic> json) {
    return _$DarvoDealModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DarvoDealModelToJson(this);
}
