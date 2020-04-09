// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synth_target_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SynthTargetModel _$SynthTargetModelFromJson(Map<String, dynamic> json) {
  return SynthTargetModel(
    name: json['name'] as String,
    locationModels: (json['locations'] as List)
        ?.map((e) => e == null
            ? null
            : SynthLocationModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SynthTargetModelToJson(SynthTargetModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'locations': instance.locationModels,
    };
