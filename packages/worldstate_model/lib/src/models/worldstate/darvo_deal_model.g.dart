// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'darvo_deal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DarvoDealModel _$DarvoDealModelFromJson(Map<String, dynamic> json) {
  return DarvoDealModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    item: json['item'] as String,
    originalPrice: json['originalPrice'] as int,
    salePrice: json['salePrice'] as int,
    total: json['total'] as int,
    sold: json['sold'] as int,
    discount: json['discount'] as int,
  );
}

Map<String, dynamic> _$DarvoDealModelToJson(DarvoDealModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'item': instance.item,
      'originalPrice': instance.originalPrice,
      'salePrice': instance.salePrice,
      'total': instance.total,
      'sold': instance.sold,
      'discount': instance.discount,
    };
