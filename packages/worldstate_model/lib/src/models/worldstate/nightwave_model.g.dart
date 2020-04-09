// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nightwave_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NightwaveModel _$NightwaveModelFromJson(Map<String, dynamic> json) {
  return NightwaveModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    tag: json['tag'] as String,
    active: json['active'] as bool,
    season: json['season'] as int,
    phase: json['phase'] as int,
    possibleChallengeModels: (json['possibleChallenges'] as List)
        ?.map((e) => e == null
            ? null
            : ChallengeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    activeChallengeModels: (json['activeChallenges'] as List)
        ?.map((e) => e == null
            ? null
            : ChallengeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    rewardTypes:
        (json['rewardTypes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$NightwaveModelToJson(NightwaveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'tag': instance.tag,
      'active': instance.active,
      'season': instance.season,
      'phase': instance.phase,
      'rewardTypes': instance.rewardTypes,
      'possibleChallenges': instance.possibleChallengeModels,
      'activeChallenges': instance.activeChallengeModels,
    };

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return ChallengeModel(
    id: json['id'] as String,
    activation: json['activation'] == null
        ? null
        : DateTime.parse(json['activation'] as String),
    expiry: json['expiry'] == null
        ? null
        : DateTime.parse(json['expiry'] as String),
    title: json['title'] as String,
    desc: json['desc'] as String,
    active: json['active'] as bool,
    isDaily: json['isDaily'] as bool,
    isElite: json['isElite'] as bool,
    reputation: json['reputation'] as int,
  );
}

Map<String, dynamic> _$ChallengeModelToJson(ChallengeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activation': instance.activation?.toIso8601String(),
      'expiry': instance.expiry?.toIso8601String(),
      'title': instance.title,
      'desc': instance.desc,
      'active': instance.active,
      'isDaily': instance.isDaily,
      'isElite': instance.isElite,
      'reputation': instance.reputation,
    };
