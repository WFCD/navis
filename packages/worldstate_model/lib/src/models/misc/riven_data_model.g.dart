// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riven_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RivenDataModel _$RivenDataModelFromJson(Map<String, dynamic> json) {
  return RivenDataModel(
    rerolledModel: json['rerolled'] == null
        ? null
        : RivenRollModel.fromJson(json['rerolled'] as Map<String, dynamic>),
    unrolledModel: json['unrolled'] == null
        ? null
        : RivenRollModel.fromJson(json['unrolled'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RivenDataModelToJson(RivenDataModel instance) =>
    <String, dynamic>{
      'rerolled': instance.rerolledModel,
      'unrolled': instance.unrolledModel,
    };
