// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstructionProgressModel _$ConstructionProgressModelFromJson(
    Map<String, dynamic> json) {
  return ConstructionProgressModel(
    id: json['id'] as String,
    fomorianProgress: json['fomorianProgress'] as String,
    razorbackProgress: json['razorbackProgress'] as String,
    unknownProgress: json['unknownProgress'] as String,
  );
}

Map<String, dynamic> _$ConstructionProgressModelToJson(
        ConstructionProgressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fomorianProgress': instance.fomorianProgress,
      'razorbackProgress': instance.razorbackProgress,
      'unknownProgress': instance.unknownProgress,
    };
