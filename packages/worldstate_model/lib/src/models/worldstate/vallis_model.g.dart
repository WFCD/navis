// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vallis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VallisModel _$VallisModelFromJson(Map<String, dynamic> json) {
  return VallisModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    state: json['state'] as String,
    isWarm: json['isWarm'] as bool,
  );
}

Map<String, dynamic> _$VallisModelToJson(VallisModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'state': instance.state,
      'isWarm': instance.isWarm,
    };
