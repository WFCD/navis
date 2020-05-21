// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syndicate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyndicateModel _$SyndicateModelFromJson(Map<String, dynamic> json) {
  return SyndicateModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    syndicate: json['syndicate'] as String,
    active: json['active'] as bool,
    jobModels: (json['jobs'] as List)
        ?.map((e) =>
            e == null ? null : JobModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SyndicateModelToJson(SyndicateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'active': instance.active,
      'syndicate': instance.syndicate,
      'jobs': instance.jobModels?.map((e) => e?.toJson())?.toList(),
    };
