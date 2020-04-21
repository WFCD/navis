// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentient_outpost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentientOutpostModel _$SentientOutpostModelFromJson(Map<String, dynamic> json) {
  return SentientOutpostModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    active: json['active'] as bool,
    missionModel: json['mission'] == null
        ? null
        : MissionModel.fromJson(json['mission'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SentientOutpostModelToJson(
        SentientOutpostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'active': instance.active,
      'mission': instance.missionModel?.toJson(),
    };
